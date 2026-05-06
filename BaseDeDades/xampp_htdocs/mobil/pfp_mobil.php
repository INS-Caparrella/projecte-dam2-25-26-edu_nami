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

$conn = new mysqli($host, $user, $pass, $db, $port);
if ($conn->connect_error) {
    ob_clean();
    echo json_encode(["ok" => false, "error" => "Error de connexió"]);
    exit;
}

$dni   = trim($_POST["dni"]   ?? "");
$token = trim($_POST["token"] ?? "");

if ($dni === "" || $token === "") {
    ob_clean();
    echo json_encode(["ok" => false, "error" => "Falten paràmetres"]);
    exit;
}

require "validar_token.php"; 


// Verificar fichero
if (!isset($_FILES["foto"]) || $_FILES["foto"]["error"] !== UPLOAD_ERR_OK) {
    ob_clean();
    echo json_encode(["ok" => false, "error" => "No s'ha rebut cap fitxer"]);
    exit;
}

$maxBytes = 300 * 1024; // 300 KB
if ($_FILES["foto"]["size"] > $maxBytes) {
    ob_clean();
    echo json_encode(["ok" => false, "error" => "Fitxer massa gran"]);
    exit;
}

$ext      = "jpg";
$nomFoto  = "perfil_" . preg_replace('/[^a-zA-Z0-9]/', '', $dni) . ".jpg";
$carpeta  = __DIR__ . "/img/alumns/";   // ← carpeta correcta
$rutaAbs  = $carpeta . $nomFoto;
$rutaRel  = "/img/alumns/" . $nomFoto;  // ← ruta relativa correcta

if (!is_dir($carpeta)) {
    mkdir($carpeta, 0755, true);
}

if (!move_uploaded_file($_FILES["foto"]["tmp_name"], $rutaAbs)) {
    ob_clean();
    echo json_encode(["ok" => false, "error" => "Error desant la foto"]);
    exit;
}

// Actualizar BD
$stmt2 = $conn->prepare("UPDATE persones SET ruta_foto = ? WHERE dni = ?");
$stmt2->bind_param("ss", $rutaRel, $dni);
$stmt2->execute();
$stmt2->close();

ob_clean();
echo json_encode(["ok" => true, "ruta_foto" => $rutaRel]);