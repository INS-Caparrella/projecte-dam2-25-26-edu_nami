<?php
header('Content-Type: application/json; charset=utf-8');

// Validació bàsica

$id = isset($_GET['dni']) ? $_GET['dni']: "";

if ($id === "") {
    echo json_encode([]);
    exit;
}

// Connexió
$mysqli = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($mysqli->connect_errno) {
    echo json_encode([]);
    exit;
}
$mysqli->set_charset("utf8mb4");

include "validar_token.php";

// OBTENIR CICLE ACTUAL
$sql = "SELECT nom_cicle FROM estudiants WHERE dni = ?;";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("s", $id);   
$stmt->execute();
$res = $stmt->get_result();

if ($row = $res->fetch_assoc()) {

    $estudis= [
        "actual" => $row["nom_cicle"],
        "historic" => []
    ];

    // OBTENIR CICLES ANTERIORS 
    $sql2 = "SELECT hc.nom_cicle FROM historic_estudiants hc JOIN estudiants e ON e.nia=hc.nia WHERE dni = ?;";

    $stmt2 = $mysqli->prepare($sql2);
    $stmt2->bind_param("s", $id);  
    $stmt2->execute();
    $res2 = $stmt2->get_result();

    while ($e = $res2->fetch_assoc()) {

        $estudis["historic"][] = [
            "cicleH"  => $e["nom_cicle"],
        ];
    }

    echo json_encode([$estudis], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

} else {
    echo json_encode([]);
}

$mysqli->close();
?>
