<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "Error de connexio"]);
    exit;
}

$metode = $_SERVER["REQUEST_METHOD"];

if($metode === "GET") {
    $sql = "SELECT DISTINCT 
    p.nom, p.cognom, p.email, p.ruta_foto, pr.dedicacio AS carrec, a.departament, ce.nom AS centre
    FROM persones p 
    JOIN professors pr ON p.dni = pr.dni
    JOIN prof_assignatura pa ON pr.codi_prof = pa.id_codiprof
    JOIN assignatures a ON pa.id_assignatura = a.codi
    JOIN contractes ct ON pr.codi_prof = ct.codi_prof
    JOIN centres ce ON ct.codi_centre = ce.codi
    WHERE p.rol = 'professor'
    ORDER BY ce.nom, p.cognom";

    $result = $conn->query($sql);

    if(!$result) {
        echo json_encode([
            "ok" => false,
            "error" => "error de consulta"
        ]);
        exit;
    }

    $professors = [];

    while($row = $result->fetch_assoc()){
        $professors[] = $row;
    }

    echo json_encode([
        "ok" => true,
        "professors" => $professors
    ]);
    exit;
}

echo json_encode([
    "ok" => false,
    "error" => "método incorrecto"
]);
exit;
?>