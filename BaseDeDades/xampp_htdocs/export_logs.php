<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "error de conexión"]);
    exit;
}

$dni_consultor = trim($_GET["dni_consultor"] ?? "");
$limit = min((int)($_GET["limit"] ?? 500), 2000);

if(!$dni_consultor) {
    echo json_encode(["ok" => false, "error" => "falta dni_consultor"]);
    exit;
}

// verificar rol
$perm = $conn->prepare("SELECT rol FROM persones WHERE dni = ? LIMIT 1");
$perm->bind_param("s", $dni_consultor);
$perm->execute();
$res_rol = $perm->get_result()->fetch_assoc();
$perm->close();

$rol = $res_rol["rol"] ?? "";
$te_permisos = in_array($rol, ["director", "administrador"]);

if(!$te_permisos) {
    $rol_cap = "Cap d'estudis";
    $perm2 = $conn->prepare("SELECT d.rol FROM directiva d 
    INNER JOIN professors pr ON pr.codi_prof = d.codi_prof
    WHERE pr.dni = ? AND d.rol = ? LIMIT 1
    ");
    $perm2->bind_param("ss", $dni_consultor, $rol_cap);
    $perm2->execute();
    $perm2->store_result();
    $te_permisos->$perm2->num_rows>0;
    $perm2->close();
}

if(!$te_permisos) {
    echo json_encode(["ok" => false, "error" => "sin permisos para exportar los logs"]);
    exit;
}

// obtener los logs
$stmt = $conn->prepare("SELECT l.id, l.dni_user, CONCAT(p.nom, ' ', p.cognom) AS nom_usuari, u.username, l.ip, l.exito, l.data
    FROM logs_login l
    LEFT JOIN usuaris u ON u.dni = l.dni_user
    LEFT JOIN persones p ON p.dni = l.dni_user
    ORDER BY l.data DESC
    LIMIT ?
    ");
$stmt->bind_param("i", $limit);
$stmt->execute();
$res = $stmt->get_result();
$logs = [];
while($row = $res->fetch_assoc()) {
    $ip_int = (int)$row["ip"];
    $row["ip_llegible"] = $ip_int > 0 ? long2ip($ip_int) : "desconeguda";
    $logs[] = $row;
}

echo json_encode([
    "ok" => true,
    "logs" => $logs,
    "total" => count($logs)
]);
?>