<?php
$nia = $_GET['nia'] ?? null;

if ($nia === null) {
    http_response_code(400);
    echo "falta_nia";
    exit;
}

$mysqli = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($mysqli->connect_errno) {
    http_response_code(500);
    echo "error_bd";
    exit;
}

$sql1 = "SELECT nom_cicle, 
                MIN(finalitzat) AS tots_finalitzats,
                MIN(nota_final) AS nota_minima
         FROM historic_estudiants 
         WHERE nia = ?
         GROUP BY nom_cicle
         HAVING tots_finalitzats = 1 AND nota_minima >= 5";
$stmt1 = $mysqli->prepare($sql1);
$stmt1->bind_param("i", $nia);
$stmt1->execute();
$res1 = $stmt1->get_result();

if ($res1->num_rows > 0) {
    echo "expedient";
    exit;
}

$sql2 = "SELECT COUNT(*) AS total FROM historic_estudiants WHERE nia = ?";
$stmt2 = $mysqli->prepare($sql2);
$stmt2->bind_param("i", $nia);
$stmt2->execute();
$res2 = $stmt2->get_result()->fetch_assoc();

if ($res2['total'] > 0) {
    echo "butlleti";
    exit;
}

echo "ninguno";