<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($conn->connect_error) {
    echo json_encode([
        "ok" => false,
        "error" => "error de conexión"
    ]);
    exit;
}

$metode = $_SERVER["REQUEST_METHOD"];


if ($metode === "GET") {
    $id_acta = $_GET["id_acta"] ?? "";

    if (!$id_acta) {
        echo json_encode([
            "ok" => false,
            "error" => "falta id_acta"
        ]);
        exit;
    }

    $stmt = $conn->prepare("
        SELECT a.*, CONCAT(p.nom, ' ', p.cognom) AS professor_nom
        FROM acta_avaluacio a
        LEFT JOIN persones p ON p.dni = a.obert_per
        WHERE a.id = ?
    ");
    $stmt->bind_param("i", $id_acta);
    $stmt->execute();
    $res = $stmt->get_result();

    echo json_encode([
        "ok"   => true,
        "acta" => $res->fetch_assoc()
    ]);
    exit;
}

if ($metode === "POST") {
    $id_acta    = $_POST["id_acta"]    ?? "";
    $dni_prof   = $_POST["dni_prof"]   ?? "";
    $nia        = $_POST["nia"]        ?? "";  
    $valor_nou  = $_POST["valor_nou"]  ?? "";
    $motiu      = $_POST["motiu"]      ?? "";

    if (!$id_acta || !$dni_prof || !$nia || $valor_nou === "" || !$motiu) {
        echo json_encode([
            "ok" => false,
            "error" => "parámetros incorrectos"
        ]);
        exit;
    }

    // comprobar rol (director o cap d’estudis)
    $check = $conn->prepare("
        SELECT dni 
        FROM persones 
        WHERE dni = ? AND rol IN ('director','cap_estudis')
        LIMIT 1
    ");
    $check->bind_param("s", $dni_prof);
    $check->execute();
    $check->store_result();

    if ($check->num_rows === 0) {
        echo json_encode([
            "ok" => false,
            "error" => "no tiene permisos."
        ]);
        exit;
    }

    // obtener valor anterior de la nota
    $stmt = $conn->prepare("
        SELECT nota_final 
        FROM acta_notes 
        WHERE id_acta = ? AND nia = ?
        LIMIT 1
    ");
    $stmt->bind_param("ii", $id_acta, $nia);
    $stmt->execute();
    $res = $stmt->get_result();
    $row = $res->fetch_assoc();

    if (!$row) {
        echo json_encode([
            "ok" => false,
            "error" => "no se ha encontrado la nota del alumno en esta acta."
        ]);
        exit;
    }

    $valor_anterior = $row["nota_final"];

    // actualizar nota en acta_notes
    $stmt = $conn->prepare("
        UPDATE acta_notes 
        SET nota_final = ? 
        WHERE id_acta = ? AND nia = ?
    ");
    $stmt->bind_param("dii", $valor_nou, $id_acta, $nia);
    $stmt->execute();

    // marcar acta como corregida
    $stmt = $conn->prepare("
        UPDATE acta_avaluacio 
        SET corregida = 1 
        WHERE id = ?
    ");
    $stmt->bind_param("i", $id_acta);
    $stmt->execute();

    // registrar histórico
    $stmt = $conn->prepare("
        INSERT INTO historic_actes
            (id_acta, dni_professor, camp_modificat, valor_anterior, valor_nou, motiu)
        VALUES (?, ?, ?, ?, ?, ?)
    ");
    $camp = "nota_final";
    $stmt->bind_param("isssss", $id_acta, $dni_prof, $camp, $valor_anterior, $valor_nou, $motiu);
    $stmt->execute();

    echo json_encode([
        "ok"  => true,
        "msg" => "corrección registrada"
    ]);
    exit;
}

echo json_encode([
    "ok" => false,
    "error" => "método no permitido"
]);
exit;
?>