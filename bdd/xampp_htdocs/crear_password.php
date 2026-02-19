<?php
header("Content-Type: application/json");

$conn = new mysqli("localhost", "root", "", "projecte_evalis",3307);

if ($conn->connect_error) {
    echo json_encode(["pot_entrar" => false]);
    exit;
}

$dni = $_POST["dni"] ?? "";
$password = $_POST["password"] ?? "";

if ($dni === "" || $password === "") {
    echo json_encode(["pot_entrar" => false]);
    exit;
}

$hash = password_hash($password, PASSWORD_DEFAULT);

$stmt = $conn->prepare(
    "UPDATE usuaris SET password=? WHERE dni=? AND password IS NULL"
);
$stmt->bind_param("ss", $hash, $dni);
$stmt->execute();

if ($stmt->affected_rows === 1) {
    echo json_encode(["pot_entrar" => true]);
} else {
    echo json_encode(["pot_entrar" => false]);
}
