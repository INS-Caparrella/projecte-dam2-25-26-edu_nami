<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);

$id_acta = $_POST["id_acta"] ?? "";
$nia = $_POST["nia"] ?? "";
$nota = $_POST["nota"] ?? "";

if(!$id_acta || !$nia || !$nota) {
    echo json_encode([
        "ok" => false,
        "error" => "faltan parámetros"
    ]);
    exit;
}

$stmt = $conn->prepare("
INSERT INTO acta_notes (id_acta, nia, nota_final)
VALUES (?, ?, ?)
ON DUPLICATE KEY UPDATE nota_final = VALUES(nota_final)
");
$stmt->bind_param("iid", $id_acta, $nia, $nota);
$stmt->execute();

echo json_encode(["ok" => true]);
?>