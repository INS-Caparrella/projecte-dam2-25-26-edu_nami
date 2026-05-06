<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "error de conexión"]);
    exit;
}

$nom_grup = trim($_GET["nom_grup"] ?? "");
if(!$nom_grup) {
    echo json_encode(["ok" => false, "error" => "falta nom_grup"]);
    exit;
}

$stmt = $conn->prepare("
    SELECT p.nom, p.cognom, p.dni, e.nom_grup, e.nom_cicle
    FROM estudiants e
    INNER JOIN persones p ON p.dni = e.dni
    WHERE e.nom_grup = ? AND e.actiu = 1
    ORDER BY p.cognom, p.nom
    ");

$stmt->bind_param("s", $nom_grup);
$stmt->execute();
$res = $stmt->get_result();

$alumnes = [];
while($row = $res->fetch_assoc()) $alumnes[] = $row;

if(empty($alumnes)) {
    echo json_encode(["ok" => false, "error" => "no hay alumnos en este grupo"]);
    exit;
}

echo json_encode(["ok" => true, 
        "alumnes" => $alumnes, 
        "grup" => $nom_grup]);
?>