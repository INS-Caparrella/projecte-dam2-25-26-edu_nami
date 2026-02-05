<?php
$servername="localhost";
$username="root";
$password="";
$dbname="plataforma_evalis";

$conn=new mysqli($servername,$username,$password,$dbname);
if($conn->connect_error){
	http_response_code(500);
	die("Connexió fallida: ".$conn->connect_error);
}

$conn->set_charset("utf8mb4");

// Capçaleres JSON
header("Content-Type: application/json; charset=utf-8");

// Consulta (tria els camps que tens a la taula de pilots)
$sql="
  SELECT *
  FROM persones
  ORDER BY nom ASC
";
$result=$conn->query($sql);

$persones=[];
if($result&&$result->num_rows>0){
  while($row=$result->fetch_assoc()){
    $persones[]=$row;
  }
}

// Sortida JSON (sense escapar Unicode ni slashes)
echo json_encode($persones,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);

$conn->close();
?>