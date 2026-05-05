<?php
ob_start();
header("Content-Type: application/json; charset=utf-8");

$host="localhost";
$user="root";
$pass="";
$db="projecte_evalis";
$port=3307;

$conn=new mysqli($host,$user,$pass,$db,$port);
if($conn->connect_error){
    ob_clean();
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Error de connexió a la BD"]);
    exit;
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    ob_clean();
    echo json_encode([
        "pot_entrar" => false,
        "tipus_error" => "Mètode incorrecte"
    ]);
    exit;
}

$username = trim($_POST["username"] ?? "");
$password = trim($_POST["password"] ?? "");

if($username===""||$password===""){
    ob_clean();
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Falten camps"]);
    exit;
}

$stmt = $conn->prepare("
    SELECT u.id_user, u.password, u.dni, p.nom, p.cognom, p.rol, p.ruta_foto
    FROM usuaris u 
    INNER JOIN persones p ON p.dni = u.dni 
    WHERE username=?
");
$stmt->bind_param("s", $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 0) {
    ob_clean();
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Usuari o contrasenya incorrectes"]);
    exit;
}

$stmt->bind_result($id_user, $password_hash_bd, $dni, $nom, $cognom, $rol, $ruta_foto);
$stmt->fetch();
$stmt->close();

if (!password_verify($password, $password_hash_bd)) {
    guardarLog($conn, $dni, 0);
    ob_clean();
    echo json_encode(["pot_entrar"=>false,"tipus_error"=>"Usuari o contrasenya incorrectes"]);
    exit;
}

$grup = null;
$grups = [];

if ($rol === "professor") {
    $stmt = $conn->prepare("SELECT codi_prof FROM professors WHERE dni = ?");
    $stmt->bind_param("s", $dni);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($row = $res->fetch_assoc()) {
        $codi_prof = $row["codi_prof"];

        $g = $conn->prepare("SELECT nom_grup FROM assistencia WHERE codi_prof = ?");
        $g->bind_param("s", $codi_prof);
        $g->execute();
        $resG = $g->get_result();

        while ($rowG = $resG->fetch_assoc()) {
            $grups[] = $rowG["nom_grup"];
        }

        if (count($grups) == 1) {
            $grup = $grups[0];
        }
    }
}

$token = bin2hex(random_bytes(32));
$data_inici = date("Y-m-d H:i:s");
$data_fi = date("Y-m-d H:i:s", time() + 36000);

$stmt2 = $conn->prepare("
    INSERT INTO sessions (dni_user, token, data_inici, data_fin)
    VALUES (?, ?, ?, ?)
");
$stmt2->bind_param("ssss", $dni, $token, $data_inici, $data_fi);
$stmt2->execute();


guardarLog($conn, $dni, 1);
ob_clean();
echo json_encode([
    "pot_entrar" => true,
    "dni"        => $dni,
    "rol"        => $rol,
    "nom"        => $nom,
    "cognom"     => $cognom,
    "ruta_foto"  => $ruta_foto,
    "token"      => $token,
    "expires"    => $data_fi,
    "grup"       => $grup,
    "grups"      => $grups
]);

function guardarLog(mysqli $conn, string $dni, int $exito): void {
    if (empty($dni)) return;
    $ip = ip2long($_SERVER["REMOTE_ADDR"] ?? "0.0.0.0");
    if ($ip === false) $ip = 0;
    $log = $conn->prepare("INSERT INTO logs_login (dni_user, ip, exito) VALUES (?, ?, ?)");
    $log->bind_param("sii", $dni, $ip, $exito);
    $log->execute();
}