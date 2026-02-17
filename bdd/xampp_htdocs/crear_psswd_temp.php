<?php
$conn = new mysqli("localhost", "root", "", "projecte_evalis");

$username = "ndiakite";
$password = "1234";

$hash = password_hash($password, PASSWORD_DEFAULT);

$stmt = $conn->prepare(
    "UPDATE usuaris SET password=? WHERE username=?"
);
$stmt->bind_param("ss", $hash, $username);
$stmt->execute();

echo "Password creada";
