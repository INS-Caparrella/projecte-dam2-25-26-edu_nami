<?php
//X els cursos de cicle no finalitzat (CoursesScreen)

ob_start();
header('Content-Type: application/json; charset=utf-8');

$dni   = isset($_GET['dni'])   ? $_GET['dni']   : "";
$cicle = isset($_GET['cicle']) ? $_GET['cicle']  : "";

if ($dni === "" || $cicle === "") {
    ob_clean();
    echo json_encode([]);
    exit;
}

$mysqli = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($mysqli->connect_errno) {
    ob_clean();
    echo json_encode([]);
    exit;
}
$mysqli->set_charset("utf8mb4");

include "validar_token.php";

// 1. DADES ALUMNE
$sql = "SELECT p.nom, p.cognom, p.dni, e.nia, e.nom_grup, e.nom_cicle, e.data_inici AS data_inici_actual
        FROM persones p
        JOIN estudiants e ON e.dni = p.dni
        WHERE p.dni = ?";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("s", $dni);
$stmt->execute();
$alumne = $stmt->get_result()->fetch_assoc();

if (!$alumne) {
    ob_clean();
    echo json_encode([]);
    exit;
}

// 2. CURSOS DEL CICLE: historic + actual si es el mateix cicle
$cursos = [];

// Cursos anteriors del mateix cicle (historic)
$sql2 = "SELECT nom_cicle, finalitzat, nota_final, data_inici, data_fi
         FROM historic_estudiants
         WHERE nia = ? AND nom_cicle = ?
         ORDER BY data_inici ASC";
$stmt2 = $mysqli->prepare($sql2);
$stmt2->bind_param("is", $alumne['nia'], $cicle);
$stmt2->execute();
$res2 = $stmt2->get_result();

while ($row = $res2->fetch_assoc()) {
    $anyInici = date('Y', strtotime($row['data_inici']));
    $anyFi    = date('Y', strtotime($row['data_fi']));
    $cursos[] = [
        "curs"        => $anyInici . "-" . $anyFi,
        "data_inici"  => $row['data_inici'],
        "data_fi"     => $row['data_fi'],
        "finalitzat"  => (bool)$row['finalitzat'],
        "nota_final"  => $row['nota_final'],
        "actual"      => false
    ];
}

// Curs actual si el cicle coincideix
if ($alumne['nom_cicle'] === $cicle) {
    $anyInici = date('Y', strtotime($alumne['data_inici_actual']));
    $anyFi    = $anyInici + 1;
    $cursos[] = [
        "curs"        => $anyInici . "-" . $anyFi,
        "data_inici"  => $alumne['data_inici_actual'],
        "data_fi"     => null,
        "finalitzat"  => false,
        "nota_final"  => null,
        "actual"      => true
    ];
}

$mysqli->close();

ob_clean();
echo json_encode([
    "nom"     => $alumne['nom'] . " " . $alumne['cognom'],
    "dni"     => $alumne['dni'],
    "nia"     => $alumne['nia'],
    "grup"    => $alumne['nom_grup'],
    "cicle"   => $cicle,
    "cursos"  => $cursos
], JSON_UNESCAPED_UNICODE);