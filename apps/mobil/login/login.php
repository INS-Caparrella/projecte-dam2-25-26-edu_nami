<?php
header("Content-Type: application/json; charset=utf-8");

// Connexió a MySQL (XAMPP)
$host="localhost";
$user="root";
$pass="";
$db="plataforma_evalis";

//Proves de hashos ************************************************************************************
// var_dump(password_verify("1234", "$2y$10$6/n.5fSDPXMBw2iWVWbx7.KXWVYorccMMovgIVwVHMAEM6lzhHjje"));
//echo password_hash("1234", PASSWORD_DEFAULT);
//exit;
//*****************************************************************************************************

$conn=new mysqli($host,$user,$pass,$db);
if($conn->connect_error){
    echo json_encode([
        "pot_entrar"=>false,
        "tipus_derror"=>"Error de connexió a la BD"
    ]);
    exit;
}


$metode = $_SERVER["REQUEST_METHOD"];

if($metode=="POST"){
	$username=isset($_POST["user"])?$_POST["user"]:"";
	$password=isset($_POST["pass"])?$_POST["pass"]:"";
}
else if($metode=="GET"){
	$username=isset($_GET["user"])?$_GET["user"]:"";
	$password=isset($_GET["pass"])?$_GET["pass"]:"";
}
else{
	echo "el mètode ha de ser GET o POST";
    exit;
}

if($username===""||$password===""){
    echo json_encode([
        "pot_entrar"=>false,
        "tipus_derror"=>"Falten camps"
    ]);
    exit;
}

// Busquem l'usuari
$stmt=$conn->prepare("SELECT password_hash FROM usuaris WHERE username=?");
$stmt->bind_param("s",$username);
$stmt->execute();
$stmt->store_result();

if($stmt->num_rows===0){
    echo json_encode([
        "pot_entrar"=>false,
        "tipus_derror"=>"Usuari o contrasenya incorrectes"
    ]);
    exit;
}

$stmt->bind_result($password_hash_bd);
$stmt->fetch();

// Comprovem la contrasenya amb password_verify
if(password_verify($password,$password_hash_bd)){
    echo json_encode([
        "pot_entrar"=>true        
    ]);
}else{
    echo json_encode([
        "pot_entrar"=>false,
        "tipus_derror"=>"Usuari o contrasenya incorrectes"
    ]);
}

$stmt->close();
$conn->close();