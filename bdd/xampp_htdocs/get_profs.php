<?php
header('Content-Type: application/json; charset=utf-8');

// Validació bàsica
$dni = isset($_GET['dni']) ? trim($_GET['dni']) : "";
if ($dni === "") {
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

// CONSULTA
$sql = "SELECT 
            p.codi_prof,
            pr.nom,
            pr.cognom,
            pr.email,
            pr.ruta_foto
        FROM estudiants e 
        JOIN cicles c ON e.nom_cicle = c.nom 
        JOIN assignatures_cicle ac ON c.nom = ac.nom_cicle 
        JOIN assignatures ass ON ac.id_assignatura = ass.codi 
        JOIN prof_assignatura ps ON ass.codi = ps.id_assignatura 
        JOIN professors p ON ps.id_codiprof = p.codi_prof 
        JOIN persones pr ON p.dni = pr.dni 
        WHERE e.dni = ?";

$stmt = $mysqli->prepare($sql);
$stmt->bind_param("s", $dni);
$stmt->execute();
$res = $stmt->get_result();

$resultat = [];

while ($row = $res->fetch_assoc()) {
    $resultat[] = [
        "codi_prof"=> $row["codi_prof"],
        "nom" => $row["nom"],
        "cognom" => $row["cognom"],
        "email" => $row["email"],
        "ruta_foto" => $row["ruta_foto"]

    ];
}

echo json_encode($resultat, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

$mysqli->close();
?>
