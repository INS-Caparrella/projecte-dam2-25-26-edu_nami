<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "Error de connexio"]);
    exit;
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo json_encode(["ok" => false, "error" => "Mètode no permès"]);
    exit;
}

$id_assignatura = $_POST["id_assignatura"] ?? "";
$dni_prof       = $_POST["dni_prof"]       ?? "";
$curs           = $_POST["curs"]           ?? "";
$trimestre      = (int)($_POST["trimestre"] ?? 0);
$grup           = $_POST["grup"]           ?? "";

$trimestre = (int)($_POST["trimestre"] ?? 0);

// si el trimestre es 0 porque está cerrado busca un acta existente
if ($trimestre === 0) {
    $find = $conn->prepare("
        SELECT id FROM acta_avaluacio
        WHERE id_assignatura = ? AND nom_grup = ? AND curs = ?
        ORDER BY trimestre DESC LIMIT 1
    ");
    $find->bind_param("sss", $id_assignatura, $grup, $curs);
    $find->execute();
    $res = $find->get_result();
    if ($res->num_rows > 0) {
        $row = $res->fetch_assoc();
        echo json_encode(["ok" => true, "id_acta" => (int)$row["id"], "nova" => false]);
    } else {
echo json_encode([
            "ok"    => false,
            "error" => "No hi ha cap acta per aquest grup i assignatura",
            "debug" => [
                "id_assignatura" => $id_assignatura,
                "grup"           => $grup,
                "curs"           => $curs
            ]
        ]);
    }
    exit;
}

if (empty($id_assignatura) || empty($dni_prof) || empty($curs) || 
    $trimestre === 0 || empty($grup)) {
    
    // DEBUG temporal
    echo json_encode([
        "ok" => false, 
        "error" => "Falten parametres",
        "rebut" => [
            "id_assignatura" => $id_assignatura,
            "dni_prof"       => $dni_prof,
            "curs"           => $curs,
            "trimestre"      => $trimestre,
            "grup"           => $grup
        ]
    ]);
    exit;
}

// devuelve el acta si existe
$check = $conn->prepare("
    SELECT id FROM acta_avaluacio
    WHERE id_assignatura = ? AND nom_grup = ? AND trimestre = ? AND curs = ?
    LIMIT 1
");
$check->bind_param("ssis", $id_assignatura, $grup, $trimestre, $curs);
$check->execute();
$res = $check->get_result();

if ($res->num_rows > 0) {
    $row = $res->fetch_assoc();
    echo json_encode(["ok" => true, "id_acta" => (int)$row["id"], "nova" => false]);
    exit;
}
$check->close();

// crear nueva acta
$stmt = $conn->prepare("
    INSERT INTO acta_avaluacio (id_assignatura, nom_grup, trimestre, curs, obert_per, data_obertura, data_tancament, corregida)
    VALUES (?, ?, ?, ?, ?, NOW(), NOW(), 0)
");
$stmt->bind_param("ssiss", $id_assignatura, $grup, $trimestre, $curs, $dni_prof);
$stmt->execute();

if ($stmt->affected_rows > 0) {
    echo json_encode(["ok" => true, "id_acta" => (int)$conn->insert_id, "nova" => true]);
} else {
    echo json_encode(["ok" => false, "error" => "No s'ha pogut crear l'acta"]);
}