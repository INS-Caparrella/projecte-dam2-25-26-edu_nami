<?php
header("Content-Type: application/json; charset=utf-8");

// Connexió a MySQL (XAMPP)
$host="localhost";
$user="root";
$pass="";
$db="projecte_evalis";

//Proves de hashos ************************************************************************************
// var_dump(password_verify("1234", "$2y$10$6/n.5fSDPXMBw2iWVWbx7.KXWVYorccMMovgIVwVHMAEM6lzhHjje"));
//echo password_hash("1234", PASSWORD_DEFAULT);
//exit;
//*****************************************************************************************************

$conn=new mysqli($host,$user,$pass,$db);
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
$stmt=$conn->prepare("SELECT password FROM usuaris WHERE username=?");
$stmt->bind_param("s",$username);
$stmt->execute();
$stmt->store_result();

if($stmt->num_rows===0){
    echo json_encode([
        "pot_entrar"=>false,
        "tipus_error"=>"Usuari o contrasenya incorrectes"
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
        "tipus_error"=>"Usuari o contrasenya incorrectes"
    ]);
}

$stmt->close();
$conn->close();