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
$sql = "SELECT nia, nom_cicle FROM estudiants WHERE dni = ?;";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("s", $id);   
$stmt->execute();
$res = $stmt->get_result();

if ($row = $res->fetch_assoc()) {

    $nia         = $row['nia'];
    $cicleActual = $row['nom_cicle'];

    $estudis = [
        "actual"  => $cicleActual,
        "historic" => []
    ];

    $sql2 = "SELECT DISTINCT hc.nom_cicle,
                MIN(hc.finalitzat) AS tots_finalitzats,
                MIN(hc.nota_final) AS nota_minima
             FROM historic_estudiants hc
             JOIN estudiants e ON e.nia = hc.nia
             WHERE e.dni = ?
             GROUP BY hc.nom_cicle";

    $stmt2 = $mysqli->prepare($sql2);
    $stmt2->bind_param("s", $id);  
    $stmt2->execute();
    $res2 = $stmt2->get_result();

    while ($e = $res2->fetch_assoc()) {
        $totsFinalitzats = $e['tots_finalitzats'] == 1 && $e['nota_minima'] >= 5;
        $estudis["historic"][] = [
            "cicleH"           => $e["nom_cicle"],
            "tots_finalitzats" => $totsFinalitzats,
            "es_actual"        => ($e["nom_cicle"] === $cicleActual)
        ];
    }

    echo json_encode([$estudis], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

} else {
    echo json_encode([]);
}

$mysqli->close();
?>