<?php
header("Content-Type: application/json; charset=utf-8");

$host="localhost";
$user="root";
$pass="";
$db="projecte_evalis";
$port=3307;

$conn=new mysqli($host,$user,$pass,$db,$port);
if($conn->connect_error){
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Error de connexió a la BD"]);
    exit;
}

$metode = $_SERVER["REQUEST_METHOD"];
if($metode=="POST"){
    $username=$_POST["username"] ?? "";
    $password=$_POST["password"] ?? "";
} else {
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Mètode incorrecte"]);
    exit;
}

if($username===""||$password===""){
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Falten camps"]);
    exit;
}

/* 1. OBTENER USUARIO */
$stmt = $conn->prepare("
    SELECT u.id_user, u.password, u.dni, p.nom, p.cognom, p.rol
    FROM usuaris u 
    INNER JOIN persones p ON p.dni = u.dni 
    WHERE username=?
");
$stmt->bind_param("s", $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 0) {
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Usuari o contrasenya incorrectes"]);
    exit;
}

$stmt->bind_result($id_user, $password_hash_bd, $dni, $nom, $cognom, $rol);
$stmt->fetch();
$stmt->close();

/* 2. VALIDAR CONTRASEÑA */
if (!password_verify($password, $password_hash_bd)) {
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Usuari o contrasenya incorrectes"]);
    exit;
}

/* 3. SI ES PROFESOR → obtener codi_prof y grupos */
$grup = null;
$grups = [];

if ($rol === "professor") {

    $stmt = $conn->prepare("SELECT codi_prof FROM Professors WHERE dni = ?");
    $stmt->bind_param("s", $dni);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($row = $res->fetch_assoc()) {
        $codi_prof = $row["codi_prof"];

        $g = $conn->prepare("SELECT grup FROM Grup_classe WHERE codi_prof = ?");
        $g->bind_param("s", $codi_prof);
        $g->execute();
        $resG = $g->get_result();

        while ($rowG = $resG->fetch_assoc()) {
            $grups[] = $rowG["grup"];
        }

        if (count($grups) == 1) {
            $grup = $grups[0];
        }
    }
}

/* 4. CREAR SESIÓN */
$token = bin2hex(random_bytes(32));
$data_inici = date("Y-m-d H:i:s");
$data_fi = date("Y-m-d H:i:s", time() + 3600);

$stmt2 = $conn->prepare("
    INSERT INTO sessions (dni_user, token, data_inici, data_fin)
    VALUES (?, ?, ?, ?)
");
$stmt2->bind_param("ssss", $dni, $token, $data_inici, $data_fi);
$stmt2->execute();

/* 5. RESPUESTA FINAL (ÚNICA) */
echo json_encode([
    "pot_entrar" => true,
    "dni"        => $dni,
    "rol"        => $rol,
    "nom"        => $nom,
    "cognom"     => $cognom,
    "token"      => $token,
    "expires"    => $data_fi,
    "grup"       => $grup,
    "grups"      => $grups
]);
