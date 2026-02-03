<?php
$conn = new mysqli("localhost", "root", "", "projecte_evalis");

if ($conn->connect_error) {
    die("Error de connexió");
}

$username = $_POST["dni"] ?? "";
$password = $_POST["password"] ?? "";

if ($dni === "" || $password === "") {
    die("Falten dades");
}

$hash = password_hash($password, PASSWORD_DEFAULT);

$stmt = $conn->prepare(
    "UPDATE usuaris SET password=? WHERE dni=? AND password IS NULL"
);
$stmt->bind_param("ss", $hash, $username);
$stmt->execute();

if ($stmt->affected_rows === 1) {
    echo "Contrasenya creada correctament";
} else {
    echo "Usuari no vàlid o ja té contrasenya";
}
