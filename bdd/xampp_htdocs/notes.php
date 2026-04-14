<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "Error de connexio"]);
    exit;
}

$accio = $_GET["accio"] ?? $_POST["accio"] ?? "";

switch ($accio) {

    case "assignatures":
        $dni = $_GET["dni"] ?? "";
        if (!$dni) { error_out("Falta dni"); break; }
        $stmt = $conn->prepare("
            SELECT pa.id_assignatura, a.nom
            FROM prof_assignatura pa
            INNER JOIN assignatures a ON a.codi = pa.id_assignatura
            INNER JOIN professors pr  ON pr.codi_prof = pa.id_codiprof
            WHERE pr.dni = ? ORDER BY a.nom
        ");
        $stmt->bind_param("s", $dni);
        $stmt->execute();
        $res = $stmt->get_result();
        $out = [];
        while ($r = $res->fetch_assoc()) $out[] = $r;
        echo json_encode(["ok" => true, "assignatures" => $out]);
        break;

    // obtener todos los ras y las notas
    case "vista_notes_all":
        $id_asig = $_GET["id_assignatura"] ?? "";
        if (!$id_asig) { error_out("Falta id_assignatura"); break; }

        // ras
        $stmt_ras = $conn->prepare("SELECT id, ra FROM ras WHERE codi_assignatura=? ORDER BY ra");
        $stmt_ras->bind_param("s", $id_asig);
        $stmt_ras->execute();
        $res_ras = $stmt_ras->get_result();
        $ras = [];
        while ($r = $res_ras->fetch_assoc()) $ras[] = $r;

        if (empty($ras)) {
            echo json_encode(["ok" => true, "ras" => [], "estudiants" => []]);
            break;
        }

        // estudiantes
        $stmt_est = $conn->prepare("
            SELECT e.nia, p.nom, p.cognom
            FROM estudiants e
            INNER JOIN persones p ON p.dni = e.dni
            WHERE e.nom_cicle IN (
                SELECT ac.nom_cicle FROM assignatures_cicle ac WHERE ac.id_assignatura = ?
            ) AND e.actiu = 1
            ORDER BY p.cognom, p.nom
        ");
        $stmt_est->bind_param("s", $id_asig);
        $stmt_est->execute();
        $estudiants_base = $stmt_est->get_result()->fetch_all(MYSQLI_ASSOC);

        // nota de ra por estudiante
        $stmt_nota = $conn->prepare("SELECT nota FROM estudiants_ras WHERE nia=? AND id_ra=?");

        $estudiants = [];
        foreach ($estudiants_base as $est) {
            $nia          = $est["nia"];
            $notes        = [];
            $notes_valors = [];

            foreach ($ras as $ra) {
                $stmt_nota->bind_param("ii", $nia, $ra["id"]);
                $stmt_nota->execute();
                $row_nota = $stmt_nota->get_result()->fetch_assoc();
                $nota = $row_nota ? $row_nota["nota"] : null;
                $notes["ra_" . $ra["id"]] = $nota;
                if ($nota !== null) $notes_valors[] = (float)$nota;
            }

            $mitjana = count($notes_valors) > 0
                ? round(array_sum($notes_valors) / count($notes_valors), 2)
                : null;

            $estudiants[] = array_merge([
                "nia"     => (int)$nia,
                "nom"     => $est["nom"],
                "cognom"  => $est["cognom"],
                "mitjana" => $mitjana,
                "aprovat" => $mitjana !== null ? $mitjana >= 5 : null
            ], $notes);
        }

        echo json_encode(["ok" => true, "ras" => $ras, "estudiants" => $estudiants]);
        break;

    case "guardar":
        if (!periodeObert($conn)) { error_out("El periode esta tancat"); break; }
        $id_ra = (int)($_POST["id_ra"] ?? 0);
        $nia   = (int)($_POST["nia"]   ?? 0);
        $nota  = $_POST["nota"] ?? "";
        if (!$id_ra || !$nia || $nota === "") { error_out("Falten parametres"); break; }
        $nota = floatval(str_replace(",", ".", $nota));
        if ($nota < 0 || $nota > 10) { error_out("Nota fora de rang"); break; }
        $check = $conn->prepare("SELECT id FROM estudiants_ras WHERE id_ra=? AND nia=?");
        $check->bind_param("ii", $id_ra, $nia);
        $check->execute();
        $check->store_result();
        if ($check->num_rows > 0) { error_out("Ja te nota per aquest RA"); break; }
        $check->close();
        $stmt = $conn->prepare("INSERT INTO estudiants_ras (id_ra, nia, nota) VALUES (?,?,?)");
        $stmt->bind_param("iid", $id_ra, $nia, $nota);
        $stmt->execute();
        echo json_encode(["ok" => $stmt->affected_rows > 0]);
        break;

    case "tancar_proces":
        $id_asig = $_POST["id_assignatura"] ?? "";
        $dni     = $_POST["dni"] ?? "";
        if (!$id_asig || !$dni) { error_out("Falten parametres"); break; }
        $check = $conn->prepare("
            SELECT COUNT(*) AS pendents
            FROM estudiants e
            INNER JOIN assignatures_cicle ac ON ac.nom_cicle = e.nom_cicle
            INNER JOIN ras r ON r.codi_assignatura = ac.id_assignatura
            LEFT JOIN estudiants_ras er ON er.nia = e.nia AND er.id_ra = r.id
            WHERE ac.id_assignatura = ? AND e.actiu = 1 AND er.nota IS NULL
        ");
        $check->bind_param("s", $id_asig);
        $check->execute();
        $res = $check->get_result()->fetch_assoc();
        $check->close();
        if ((int)$res["pendents"] > 0) {
            echo json_encode(["ok" => false, "error" => "Encara hi ha " . $res["pendents"] . " notes pendents."]);
            break;
        }
        echo json_encode(["ok" => true]);
        break;

    default:
        error_out("Accio no reconeguda");
}

function periodeObert(mysqli $conn): bool {
    $r = $conn->query("SELECT id FROM periodes_avaluacio WHERE obert=1 LIMIT 1");
    return $r && $r->num_rows > 0;
}
function error_out(string $msg): void {
    echo json_encode(["ok" => false, "error" => $msg]);
}