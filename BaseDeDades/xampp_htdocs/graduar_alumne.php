<?php
header("Contet-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "error de conexión"]);
    exit;
}

$accio = $_POST["accio"] ?? $_GET["accio"] ?? "";
$nia = (int)($_POST["nia"] ?? $_GET["nia"] ?? 0);

if(!$nia) {
    echo json_encode(["ok" => false,
    "error" => "falta nia"]);
    exit;
}

switch($accio) {

    //comprobar que el estudiante aprobó todo
    case "comprovar":
        $stmt = $conn->prepare("
        SELECT e.nia, e.nom_cicle, e.nom_grup, e.data_inici, p.nom, p.cognom, p.dni, p.data_naix, p.email
        FROM estudiants e
        INNER JOUN persones p ON p.dni = e.dni
        WHERE e.nia = ? AND e.actiu = 1
        LIMIT 1");

        $stmt->bind_param("i", $nia);
        $stmt->execute();
        $est = $stmt->get_result()->fetch_assoc();
        if(!$est) {
            echo json_encode(["ok" => false,
            "error" => "estudiante no encontrado"]);
            break;
        }

        //todas las asignaturas del ciclo
        $stmt2 = $conn->prepare("
        SELECT ac.id_assignatura, a.nom AS nom_assignatura
        FROM assignatures_cicle ac
        INNER JOIN assignatures a ON a.codi = ac.id_assignatura
        WHERE ac.nom_cicle = ?
        ");

        $stmt2->bind_param("s", $est["nom_cicle"]);
        $stmt2->execute();
        $assignatures = $stmt2->get_result()->fetch_all(MYSQL_ASSOC);

        if(empty($assignatures)) {
            echo json_encode(["ok" => false,
            "error" => "no hay asignaturas para este ciclo"]);
            break;
        }

        $total_pes = 0;
        $total_nota = 0;
        $tot_aprovat = true;
        $detall = [];

        foreach($assignatures as $asig) {
            $stmt3 = $conn->prepare("
            SELECT ROUND(AVG(er.nota), 2) AS mitjana, COUNT(er.nota) AS num_notes, COUNT(r.id) AS total_ras
            FROM ras r
            LEFT JOIN estudiants_ras er ON er.id_ra = r.id AND er.nia = ?
            WHERE r.codi_assignatura = ?
            ");
            $stmt3->bind_param("is", $nia, $asig["id_assignatura"]);
            $stmt3->execute();
            $res = $stmt3->get_result()->fetch_assoc();

            $mitjana = $res["mitjana"] !== null ? (float)$res["mitjana"]:null;
            $num_notes = (int)$res["num_notes"];
            $total_ras = (int)$res["total_ras"];
            $pes = max($total_ras, 1);

            if($mitjana === null || $num_notes < $total_ras) {
                $tot_aprovat = false;
                $detall[] = [
                    "assignatura" => $asig["nom_assignatura"],
                    "mitjana" => null,
                    "aprovat" => false,
                    "pendent" => true
                    ];
                    continue;
            }

            if($mitjana < 5) $tot_aprovat = false;

            $total_nota += $mitjana * $pes;
            $total_pes += $pes;

            $detall[] = [
                "assignatura" => $asig["nom_assignatura"],
                "mitjana" => $mitjana,
                "aprovat" => $mitjana >= 5,
                "pendent" => false
            ];
        }

        $notal_final = $total_pes > 0
        ? round($total_nota / $total_pes, 2)
        : null;

        echo json_encode([
            "ok" => true,
            "graduat" => $tot_aprovat,
            "nota_final" => $notal_final,
            "estudiant" => $est,
            "assignatures" => $detall
        ]);
        break;

    // borrar datos después de generar el PDF
    case "guardar":
        $check = $conn->prepare("
        SELECT COUNT(*) AS pendents
        FROM ras r 
        LEFT JOIN estudiants_ras er ON er.id_ra = r.id AND er.nia = ?
        INNER JOIN assignatures_cicle ac ON ac.id_assignatura = r.codi_assignatura
        INNER JOIN estudiants e ON e.nom_cicle = ac.nom_cicle AND e.nia = ?
        WHERE er.nota IS NULL OR er.nota < 5
        ");

        $check->bind_param("ii", $nia, $nia);
        $check->execute();
        $res = $check->get_result()->fetch_assoc();
        $check->close();

        if((int)$res["pendents"] > 0) {
            echo json_encode(["ok" => false,
            "error" => "el estudiante aún no ha aprobado todo"]);
            break;
        }

        $info = $conn->prepare("SELECT nom_cicle, data_inici FROM estudiants WHERE nia = ?");
        $info->bind_param("i", $nia);
        $info->execute();
        $est_info = $info->get_result()->fetch_assoc();
        $info->close();

        $stmt_nota = $conn->prepare("
        SELECT ROUND(SUM(sub.mitjana * sub.pes) / SUM(sub.pes), 2) AS nota_final
        FROM (SELECT r.codi_assignatura, AVG(er.nota) AS mitjana, COUNT(r.id) AS pes
        FROM ras r 
        INNER JOIN estudiants_ras er ON er.id_ra = r.id AND er.nia = ?
        INNER JOIN assignatures_cicle ac ON ac.id_assignatura = r.codi_assignatura
        INNER JOIN estudiants e ON e.nom_cicle = ac.nom_cicle AND e.nia = ?
        GROUP BY r.codi_assignatura
        ) sub");

        $stmt_nota->bind_param("ii", $nia, $nia);
        $stmt_nota->execute();
        $nota_res = $stmt_nota->get_result()->fetch_assoc();
        $notal_final = $nota_res["nota_final"] ?? null;
        $stmt_nota->close();

        //insert en el historial antes de borrar
        $hist = $conn->prepare("
        INSERT INTO historic_estudiants (nia, nom_cicle, finalitzat, nota_final, data_inici, data_fi)
        VALUES(?, ?, 1, ?, ?, CURDATE())
        ON DUPLICATE KEY UPDATE finalitzat=1, nota_final=VALUES(nota_final), data_fi=CURDATE()");
        
        $hist->bind_param("isds", $nia, $est_info["nom_cicle"], $nota_final, $est_info["data_inici"]);
        $hist->execute();
        $hist->close();

        $conn->begin_transaction();
        try {
            // eliminar notas de actas
            $d3 = $conn->prepare("DELETE FROM acta_notes WHERE nia = ?");
            $d3->bind_param("i", $nia);
            $d3->execute();

            // eliminar notas de los ras
            $d1 = $conn->prepare("DELETE FROM estudiants_ras WHERE nia = ?");
            $d1->bind_param("i", $nia);
            $d1->execute();

            // marcar inactivo
            $d4 = $conn->prepare("UPDATE estudiants SET actiu = 0 WHERE nia = ?");
            $d4->bind_param("i", $nia);
            $d4->execute();

            // agregar nota_final al registro
            $d5 = $conn->prepare("UPDATE historic_estudiants SET nota_final = ? WHERE nia = ? ORDER BY id DESC LIMIT 1");
            $d5->bind_param("di", $nota_final, $nia);
            $d5->execute();

            $conn->commit();
            echo json_encode(["ok" => true,
            "nota_final" => $notal_final]);
        } catch (Exception $ex) {
            $conn->rollback();
            echo json_encode(["ok" => false, "error" => $ex->getMessage()]);
        }
}

?>