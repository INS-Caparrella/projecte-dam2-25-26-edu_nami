<?php
if (!isset($mysqli)) {
    http_response_code(500);
    echo json_encode(["error" => "Error de conexión"]);
    exit;
}

$token = $_POST["token"] ?? $_GET["token"] ?? "";

if ($token === "") {
    echo json_encode(["error" => "Falta token"]);
    exit;
}

$stmt = $mysqli->prepare("
    SELECT dni_user, data_fin 
    FROM sessions 
    WHERE token = ?
");
$stmt->bind_param("s", $token);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 0) {
    http_response_code(401);
    echo json_encode(["error" => "Token invalido"]);
    exit;
}

$stmt->bind_result($dni_user, $data_fin);
$stmt->fetch();

if (strtotime($data_fin) < time()) {
    http_response_code(401);
    echo json_encode(["error" => "Token expirado"]);
    exit;
}

$consulta = $_SERVER["REQUEST_URI"];

$stmt2 = $mysqli->prepare("
    INSERT INTO logs_consultes (dni_user, consulta)
    VALUES (?, ?)
");
$stmt2->bind_param("ss", $dni_user, $consulta);
$stmt2->execute();
