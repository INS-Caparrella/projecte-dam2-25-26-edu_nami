<?php
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "error de conexión"]);
    exit;
}

$id_acta = (int)($_GET["id_acta"] ?? 0);
$dni = trim($_GET["dni"] ?? "");

if(!$id_acta || !$dni) {
    echo json_encode([
        "ok" => false,
        "error" => "faltan parámetros"
    ]);
    exit;
}

$perm = $conn->prepare("SELECT dni FROM persones WHERE dni=? AND rol IN ('director', 'administrador') LIMIT 1");
$perm->bind_param("s", $dni);
$perm->execute();
$perm->store_result();

if($perm->num_rows === 0) {
    $rol_cap = "Cap d'estudis";
    $perm2 = $conn->prepare("SELECT d.codi_prof FROM directiva d 
    INNER JOIN professors pr ON pr.codi_prof = d.codi_prof
    WHERE pr.dni = ? AND rol = ? LIMIT 1");
    $perm2->bind_param("ss", $dni, $rol_cap);
    $perm2->execute();
    $perm2->store_result();

    if($perm2->num_rows === 0) {
        echo json_encode([
            "ok" => false,
            "error" => "sin permisos"
        ]);
        exit;
    }
    $perm2->close();
}
$perm->close();

$stmt = $conn->prepare("SELECT aa.id, aa.is_assignatura, aa.nom_grup, aa.trimestre, aa.curs, aa.data_obertura, aa.data_tancament, aa.corregida, a.nom AS nom_assignatura, a.departament, gc.aula,
CONCAT(p.nom, ' ', p.cognom) AS nom_responsable 
FROM acta_avaluacio aa
INNER JOIN assignatures a ON a.codi = aa.id_assignatura
INNER JOIN grup_classe gc ON gc.nom = aa.nom_grup
INNER JOIN persones p ON p.dni = aa.obert_per
WHERE aa.id = ?
LIMIT 1");
$stmt->bind_param("i", $id_acta);
$stmt->execute();
$acta = $stmt->get_result()->fetch_assoc();

if(!$acta) {
    echo json_encode([
        "ok"=> false,
        "error" => "acta no encontrada"
    ]);
    exit;
}

$stmt_ras =$conn->prepare("SELECT id, ra FROM ras WHERE codi_assignatura=? ORDER BY ra");
$stmt_ras->bind_param("s", $acta["id_assignatura"]);
$stmt_ras->execute();
$ras = $stmt_ras->get_result()->fetch_all(MYSQLI_ASSOC);

$stmt_alumn = $conn->prepare("SELECT an.nia, p.nom, p.cognom, an.nota_final, an.repetidor, an.treballant, e.nom_cicle
FROM acta_notes an
INNER JOIN estudiants e ON e.nia = an.nia
INNER JOIN persones p ON p.dni = e.dni
WHERE an.id_acta = ?
ORDER BY p.cognom, p.nom");
$stmt_alumn->bind_param("i", $id_acta);
$stmt_alumn->execute();
$alumnes_raw = $stmt_alumn->get_result()->fetch_all(MYSQLI_ASSOC);

$stmt_nota = $conn->prepare("SELECT nota FROM estudiants_ras WHERE nia=? AND id_ra=?");
$alumnes = [];
foreach($alumnes_raw as $alumno) {
    $notes_ra = [];
    foreach($ras as $ra) {
        $stmt_nota->bind_param("ii", $alumno["nia"], $ra["id"]);
        $stmt_nota->execute();
        $r = $stmt_nota->get_result()->fetch_assoc();
        $notes_ra["ra_" . $ra["id"]] = $r ? $r["nota"] : null;
    }
    $alumnes[] = array_merge($alumno, $notes_ra);
}

$stmt_prof = $conn->prepare("SELECT DISTINCT p.nom, p.cognom, pr.dedicacio, d.rol AS rol_directiva
FROM prof_assignatura pa 
INNER JOIN professors pr ON pr.codi_prof = pa.id_codiprof
INNER JOIN persones p ON p.dni = pr.dni
LEFT JOIN directiva d ON d.codi_prof = pr.codi_prof
WHERE pa.id_assignatura = ?
ORDER BY p.cognom, p.nom");
$stmt_prof->bind_param("s", $acta["id_assignatura"]);
$stmt_prof->execute();
$professors = $stmt_prof->get_result()->fetch_all(MYSQLI_ASSOC);

$stmt_hist = $conn->prepare("SELECT h.camp_mod, h.valor_anterior, h.valor_nou, h.motiu,
DATE_FORMAT(h.data_mod, '%d/%m/%Y %H:%i') AS data_mod,
CONCAT(p.nom, ' ', p.cognom) AS modificat_per
FROM historic_actes h 
INNER JOIN persones p ON p.dni = h.dni_professor
WHERE h.id_acta = ?
ORDER BY h.data_mod DESC");
$stmt_hist->bind_param("i", $id_acta);
$stmt_hist->execute();
$correccions = $stmt_hist->get_result()->fetch_all(MYSQLI_ASSOC);

echo json_encode([
    "ok" => true,
    "acta" => $acta,
    "ras" => $ras,
    "alumnes" => $alumnes,
    "professors" => $professors,
    "correccions" => $correccions
]);