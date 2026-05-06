<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if($conn->connect_error) {
    echo json_encode((["ok" => false,
    "error" => "error de conexión"]));
    exit;
}

$metode = $_SERVER["REQUEST_METHOD"];

if($metode === "GET") {
    $curs = $_GET["curs"] ?? date("Y") . "-" . (date("Y") + 1);

    $stmt = $conn->prepare("
    SELECT pa.id, pa.trimestre, pa.curs, pa.obert,
    pa.data_obertura, pa.data_tancament, 
    CONCAT(p.nom, ' ', p.cognom) AS obert_per_nom
    FROM periodes_avaluacio pa 
    LEFT JOIN persones p ON p.dni = pa.obert_per
    WHERE pa.curs = ?
    ORDER BY pa.trimestre");

    $stmt->bind_param("s", $curs);
    $stmt->execute();
    $result = $stmt->get_result();

    $periodes = [];

    while ($row = $result->fetch_assoc()){
        $periodes[] = $row;
    }

    echo json_encode(["ok" => true, 
    "periodes" => $periodes]);
    exit;
}

if ($metode === "POST"){
    $id_periode = $_POST["id_periode"] ?? "";
    $accion     = $_POST["accio"]      ?? "";
    $dni        = $_POST["dni"]        ?? "";

    if(!$id_periode || !in_array($accion, ["obrir", "tancar"]) || !$dni) {
        echo json_encode(["ok" => false,
        "error" => "parámetros incorrectos"]);
        exit;
    }

    //comprobar que sea un director
    $check = $conn->prepare("
    SELECT p.dni FROM persones p
    WHERE p.dni = ? AND p.rol IN ('director', 'administrador')
    LIMIT 1
");
    $check->bind_param("s", $dni);
    $check->execute();
    $check->store_result();

if ($check->num_rows === 0) {
    // Comprova si és cap d'estudis a directiva
    $rol_cap = "Cap d'estudis";
    $check2 = $conn->prepare("
        SELECT d.codi_prof FROM directiva d
        INNER JOIN professors pr ON pr.codi_prof = d.codi_prof
        WHERE pr.dni = ? AND d.rol = ?
        LIMIT 1
    ");
    $check2->bind_param("ss", $dni, $rol_cap);
    $check2->execute();
    $check2->store_result();

    if ($check2->num_rows === 0) {
        echo json_encode(["ok" => false, "error" => "No tiene permisos"]);
        exit;
    }
    $check2->close();
}
$check->close();

if ($accion === "obrir") {
    $conn->query("UPDATE periodes_avaluacio SET obert = 0, 
    data_tancament = NOW()
    WHERE obert = 1");

    $stmt = $conn->prepare("
    UPDATE periodes_avaluacio 
    SET obert = 1, 
    data_obertura = NOW(), data_tancament = NULL, obert_per = ? WHERE id = ?");

    $stmt->bind_param("si", $dni, $id_periode);
} else {
    $stmt = $conn->prepare("
    UPDATE periodes_avaluacio
    SET obert = 0, data_tancament = NOW()
    WHERE id = ?");

    $stmt->bind_param("i", $id_periode);
}

$stmt->execute();

if($stmt->affected_rows > 0){
    echo json_encode(["ok" => true, "accio" => $accion]);
} else {
    echo json_encode(["ok" => false, "error" => "no se pudo actualizar."]);
}
exit;
}
?>