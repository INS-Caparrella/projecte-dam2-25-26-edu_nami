<?php
ob_start();
error_reporting(0);
ini_set('display_errors', 0);
header("Content-Type: application/json; charset=utf-8");

$host = "localhost";
$user = "root";
$pass = "";
$db   = "projecte_evalis";
$port = 3307;

$mysqli = new mysqli($host, $user, $pass, $db, $port); 
if ($mysqli->connect_error) {
    ob_clean();
    echo json_encode(["error" => "Error de connexió"]);
    exit;
}

require "validar_token.php"; 

$dni = $dni_user; 

$stmt = $mysqli->prepare("
    SELECT 
        p.nom, p.cognom, p.data_naix, p.email,
        p.telf_mob, p.poblacio, p.ruta_foto,
        e.nom_grup, e.nom_cicle, e.grado,
        e.treballant, e.empresa
    FROM persones p
    LEFT JOIN estudiants e ON e.dni = p.dni
    WHERE p.dni = ?
    LIMIT 1
");
$stmt->bind_param("s", $dni);
$stmt->execute();
$res = $stmt->get_result()->fetch_assoc();
$stmt->close();

if ($res === null) {
    ob_clean();
    echo json_encode(["error" => "Usuari no trobat"]);
    exit;
}

ob_clean();
echo json_encode([
    "nom"        => $res["nom"],
    "cognom"     => $res["cognom"],
    "data_naix"  => $res["data_naix"],
    "email"      => $res["email"],
    "telf_mob"   => $res["telf_mob"],
    "poblacio"   => $res["poblacio"],
    "ruta_foto"  => $res["ruta_foto"],
    "nom_grup"   => $res["nom_grup"]  ?? "",
    "nom_cicle"  => $res["nom_cicle"] ?? "",
    "grado"      => $res["grado"]     ?? "",
    "treballant" => (bool)($res["treballant"] ?? false),
    "empresa"    => $res["empresa"]   ?? ""
]);