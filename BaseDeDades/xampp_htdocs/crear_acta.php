<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);

$id_assignatura = $_POST["id_assignatura"] ?? "";
$dni_prof = $_POST["dni_prof"] ?? "";
$curs = $_POST["curs"] ?? "";
$trimestre = $_POST["trimestre"] ?? "";
$grup = $_POST["grup"] ?? "";

if (!$id_assignatura || !$dni_prof || !$curs || !$trimestre || !$grup) {
    echo json_encode(["ok" => false, "error" => "faltan parámetros"]);
    exit;
}

// buscar si ya existe
$stmt = $conn->prepare("
    SELECT id FROM acta_avaluacio
    WHERE id_assignatura = ? AND curs = ? AND trimestre = ? AND nom_grup = ?
    LIMIT 1
");
$stmt->bind_param("ssss", $id_assignatura, $curs, $trimestre, $grup);
$stmt->execute();
$res = $stmt->get_result();

if ($row = $res->fetch_assoc()) {
    echo json_encode(["ok" => true, "id_acta" => $row["id"]]);
    exit;
}

// crear acta nueva
$stmt = $conn->prepare("
    INSERT INTO acta_avaluacio (id_assignatura, curs, trimestre, nom_grup, obert_per, corregida)
    VALUES (?, ?, ?, ?, ?, 0)
");
$stmt->bind_param("sssss", $id_assignatura, $curs, $trimestre, $grup, $dni_prof);
$stmt->execute();

echo json_encode(["ok" => true, "id_acta" => $stmt->insert_id]);
?>
