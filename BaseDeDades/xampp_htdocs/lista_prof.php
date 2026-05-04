<?php
// llistat_professors.php
// GET ?dni_consultor=12345678A
// Retorna la llista de professors visibles segons el rol
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "Error de connexio"]);
    exit;
}

$dni_consultor = trim($_GET["dni_consultor"] ?? "");
if (!$dni_consultor) {
    echo json_encode(["ok" => false, "error" => "Falta dni_consultor"]);
    exit;
}

// Rol del consultant
$stmt_rol = $conn->prepare("SELECT rol FROM persones WHERE dni = ? LIMIT 1");
$stmt_rol->bind_param("s", $dni_consultor);
$stmt_rol->execute();
$rol = $stmt_rol->get_result()->fetch_assoc()["rol"] ?? "professor";
$stmt_rol->close();

if ($rol === "administrador") {
    // Veu tots els professors de tots els centres
    $stmt = $conn->prepare("
        SELECT p.dni, p.nom, p.cognom, p.email, pr.dedicacio,
               d.rol AS rol_directiva,
               ce.nom AS nom_centre
        FROM professors pr
        INNER JOIN persones p  ON p.dni = pr.dni
        LEFT JOIN directiva d  ON d.codi_prof = pr.codi_prof
        LEFT JOIN contractes c ON c.codi_prof = pr.codi_prof AND c.data_baix IS NULL
        LEFT JOIN centres ce   ON ce.codi = c.codi_centre
        ORDER BY p.cognom, p.nom
    ");
    $stmt->execute();
} else {
    // Professor i directiva: veu els del seu centre
    // Primer obtenim el centre del consultant
    $stmt_centre = $conn->prepare("
        SELECT c.codi_centre FROM contractes c
        INNER JOIN professors pr ON pr.codi_prof = c.codi_prof
        WHERE pr.dni = ? AND c.data_baix IS NULL
        LIMIT 1
    ");
    $stmt_centre->bind_param("s", $dni_consultor);
    $stmt_centre->execute();
    $res_centre = $stmt_centre->get_result()->fetch_assoc();
    $stmt_centre->close();

    $codi_centre = $res_centre["codi_centre"] ?? 0;

    $stmt = $conn->prepare("
        SELECT p.dni, p.nom, p.cognom, p.email, pr.dedicacio,
               d.rol AS rol_directiva,
               ce.nom AS nom_centre
        FROM professors pr
        INNER JOIN persones p  ON p.dni = pr.dni
        LEFT JOIN directiva d  ON d.codi_prof = pr.codi_prof
        LEFT JOIN contractes c ON c.codi_prof = pr.codi_prof AND c.data_baix IS NULL
        LEFT JOIN centres ce   ON ce.codi = c.codi_centre
        WHERE c.codi_centre = ?
        ORDER BY p.cognom, p.nom
    ");
    $stmt->bind_param("i", $codi_centre);
    $stmt->execute();
}

$professors = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
echo json_encode(["ok" => true, "professors" => $professors]);