<?php
header("Content-Type: application/json; charset=utf-8");

// Connexió a MySQL (XAMPP)
$host="localhost";
$user="root";
$pass="";
$db="projecte_evalis";
$port=3307;


//Proves de hashos ************************************************************************************
// var_dump(password_verify("1234", "$2y$10$6/n.5fSDPXMBw2iWVWbx7.KXWVYorccMMovgIVwVHMAEM6lzhHjje"));
//echo password_hash("1234", PASSWORD_DEFAULT);
//exit;
//*****************************************************************************************************

$conn=new mysqli($host,$user,$pass,$db,$port);
if($conn->connect_error){
    echo json_encode([
        "pot_entrar"=>false,
        "tipus_error"=>"Error de connexió a la BD"
    ]);
    exit;
}

// Agafem dades del POST
// (Millor POST que GET per no portar la contrasenya a la URL)
$metode = $_SERVER["REQUEST_METHOD"];
if($metode=="POST"){
	$username=isset($_POST["username"])?$_POST["username"]:"";
	$password=isset($_POST["password"])?$_POST["password"]:"";
}
else if($metode=="GET"){
	$username=isset($_GET["username"])?$_GET["username"]:"";
	$password=isset($_GET["password"])?$_GET["password"]:"";
}
else{
	echo "el mètode ha de ser GET o POST";
    exit;
}

if($username===""||$password===""){
    echo json_encode([
        "pot_entrar"=>false,
        "tipus_error"=>"Falten camps"
    ]);
    exit;
}

// Busquem l'usuari
$stmt = $conn->prepare("SELECT u.id_user, u.password, u.dni, p.nom, p.cognom, p.rol 
                        FROM usuaris u 
                        INNER JOIN persones p ON p.dni = u.dni 
                        WHERE username=?");

$stmt->bind_param("s", $username);
$stmt->execute();
$stmt->store_result();

//IP del cliente convertida
$ip = ip2long($_SERVER["REMOTE_ADDR"] ?? "0.0.0.0");
if ($ip === false) $ip = 0;

if ($stmt->num_rows === 0) {
    guardarLog($conn, 0, $ip, 0);
    echo json_encode([
        "pot_entrar" => false,
        "tipus_error" => "Usuari o contrasenya incorrectes"
    ]);
    exit;
}


$stmt->bind_result($id_user, $password_hash_bd, $dni, $nom, $cognom, $rol);
$stmt->fetch();
$stmt->close();

if($password_hash_bd === null) {
    guardarLog($conn, $id_user, $ip, 0);
    echo json_encode(["pot_entrar" => false, 
    "tipus_error" => "cuenta sin contraseña."]);
    exit;
}

// Comprovem contrasenya
if (password_verify($password, $password_hash_bd)) {
    guardarLog($conn, $id_user, $ip, 1);
    
    echo json_encode([
        "pot_entrar" => true,
        "dni"    => $dni,   
        "rol"    => $rol,    // "professor" | "alumne" | "director" | "administrador"
        "nom"    => $nom,
        "cognom" => $cognom
    ]);
} else {
    guardarLog($conn, $id_user, $ip, 0);

    echo json_encode([
        "pot_entrar" => false,
        "tipus_error" => "Usuari o contrasenya incorrectes"
    ]);
}
function guardarLog(mysqli $conn, int $id_user, int $ip, int $login): void {
    if($id_user === 0) return;
    $log = $conn->prepare("
    INSERT INTO logs_login (id_user, ip, login) 
    VALUES (?, ?, ?);");
    $log->bind_param("iii", $id_user, $ip, $login);
    $log->execute();
}