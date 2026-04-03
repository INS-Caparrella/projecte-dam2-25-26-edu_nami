<?php
header('Content-Type: application/json; charset=utf-8');

// Validació bàsica

$id = isset($_GET['dni']) ? $_GET['dni']: "";
$codi_prof = isset($_GET['codi_prof']) ? $_GET['codi_prof'] : "";

if ($id === ""||$codi_prof === "") {
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

// OBTENIR PROFESSOR
$sql = "SELECT * FROM persones pr JOIN professors prf ON pr.dni=prf.dni WHERE prf.codi_prof = ?;";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("s", $codi_prof);   
$stmt->execute();
$res = $stmt->get_result();

if ($row = $res->fetch_assoc()) {

    $prof = [
        "codi_prof"         => $row["codi_prof"],
        "nom"          => $row["nom"],
        "cognom"       => $row["cognom"],
        "email"        => $row["email"],
        "ruta_foto"        => $row["ruta_foto"],
        "assignatures" => []
    ];

    // OBTENIR ASSIGNATURES 
    $sql2 = "SELECT 
            ass.nom,
            gc.aula
        FROM estudiants e 
        JOIN cicles c ON e.nom_cicle = c.nom 
        JOIN assignatures_cicle ac ON c.nom = ac.nom_cicle 
        JOIN assignatures ass ON ac.id_assignatura = ass.codi 
        JOIN prof_assignatura ps ON ass.codi = ps.id_assignatura 
        JOIN professors p ON ps.id_codiprof = p.codi_prof 
        JOIN persones pr ON p.dni = pr.dni
        JOIN grup_classe gc ON gc.nom=e.nom_grup
        WHERE e.dni = ? AND p.codi_prof= ?;";

    $stmt2 = $mysqli->prepare($sql2);
    $stmt2->bind_param("ss", $id, $codi_prof);  
    $stmt2->execute();
    $res2 = $stmt2->get_result();

    while ($e = $res2->fetch_assoc()) {

        $prof["assignatures"][] = [
            "nom_assignatura"  => $e["nom"],
            "aula"             => $e["aula"],
        ];
    }

    echo json_encode([$prof], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

} else {
    echo json_encode([]);
}

$mysqli->close();
?>
