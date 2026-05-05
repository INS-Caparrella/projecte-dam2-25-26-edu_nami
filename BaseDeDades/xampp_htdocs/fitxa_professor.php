<?php
// fitxa_professor.php
// GET ?dni_consultor=12345678A&dni_professor=23456789B
// Retorna dades del professor segons el rol del consultant
header("Content-Type: application/json; charset=utf-8");

$conn = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($conn->connect_error) {
    echo json_encode(["ok" => false, "error" => "Error de connexio"]);
    exit;
}

$dni_consultor  = trim($_GET["dni_consultor"]  ?? "");
$dni_professor  = trim($_GET["dni_professor"]  ?? "");

if (!$dni_consultor || !$dni_professor) {
    echo json_encode(["ok" => false, "error" => "Falten parametres"]);
    exit;
}

// ── Nivell d'accés del consultant ────────────────────────────
// 3 = admin Evalis (administrador)
// 2 = directiva del centre
// 1 = professor (veu bàsics dels companys, total de si mateix)
$stmt_rol = $conn->prepare("SELECT rol FROM persones WHERE dni = ? LIMIT 1");
$stmt_rol->bind_param("s", $dni_consultor);
$stmt_rol->execute();
$res_rol = $stmt_rol->get_result()->fetch_assoc();
$stmt_rol->close();

$rol_consultor = $res_rol["rol"] ?? "";

$nivell = 1; // professor per defecte
if ($rol_consultor === "administrador") {
    $nivell = 3;
} elseif ($rol_consultor === "director") {
    $nivell = 2;
} else {
    // Comprovar si és directiva
    $stmt_dir = $conn->prepare("
        SELECT d.rol FROM directiva d
        INNER JOIN professors pr ON pr.codi_prof = d.codi_prof
        WHERE pr.dni = ? LIMIT 1
    ");
    $stmt_dir->bind_param("s", $dni_consultor);
    $stmt_dir->execute();
    $res_dir = $stmt_dir->get_result()->fetch_assoc();
    $stmt_dir->close();
    if ($res_dir) $nivell = 2;
}

// Si el consultant es consulta a si mateix, veu totes les seves dades
if ($dni_consultor === $dni_professor) $nivell = max($nivell, 2);

// ── Dades bàsiques (tots els nivells) ────────────────────────
$stmt = $conn->prepare("
    SELECT p.nom, p.cognom, p.email, p.ruta_foto,
           pr.codi_prof, pr.dedicacio,
           p.dni, p.telf_mob, p.telf_fix, p.poblacio,
           p.data_naix, p.nacionalitat,
           d.rol AS rol_directiva
    FROM persones p
    INNER JOIN professors pr ON pr.dni = p.dni
    LEFT JOIN directiva d    ON d.codi_prof = pr.codi_prof
    WHERE p.dni = ?
    LIMIT 1
");
$stmt->bind_param("s", $dni_professor);
$stmt->execute();
$prof = $stmt->get_result()->fetch_assoc();
$stmt->close();

if (!$prof) {
    echo json_encode(["ok" => false, "error" => "Professor no trobat"]);
    exit;
}

// ── Assignatures ──────────────────────────────────────────────
$stmt2 = $conn->prepare("
    SELECT a.nom, a.codi
    FROM prof_assignatura pa
    INNER JOIN assignatures a ON a.codi = pa.id_assignatura
    WHERE pa.id_codiprof = ?
    ORDER BY a.nom
");
$stmt2->bind_param("s", $prof["codi_prof"]);
$stmt2->execute();
$assignatures = $stmt2->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt2->close();

// ── Resposta nivell 1 (bàsic) ────────────────────────────────
$resposta = [
    "ok"           => true,
    "nivell"       => $nivell,
    "nom"          => $prof["nom"],
    "cognom"       => $prof["cognom"],
    "email"        => $prof["email"],
    "ruta_foto"    => $prof["ruta_foto"],
    "dedicacio"    => $prof["dedicacio"],
    "rol_directiva" => $prof["rol_directiva"],
    "assignatures" => $assignatures
];

// ── Dades addicionals nivell 2+ (directiva i admin) ──────────
if ($nivell >= 2) {
    // Contractes
    $stmt3 = $conn->prepare("
        SELECT c.data_alta, c.data_baix, c.vinculacio_laboral,
               ce.nom AS nom_centre
        FROM contractes c
        INNER JOIN professors pr ON pr.codi_prof = c.codi_prof
        INNER JOIN centres ce    ON ce.codi = c.codi_centre
        WHERE pr.dni = ?
        ORDER BY c.data_alta DESC
    ");
    $stmt3->bind_param("s", $dni_professor);
    $stmt3->execute();
    $contractes = $stmt3->get_result()->fetch_all(MYSQLI_ASSOC);
    $stmt3->close();

    // Historial absències
    $stmt4 = $conn->prepare("
        SELECT tipus, motius, justificat, justificant
        FROM historic_professors
        INNER JOIN professors pr ON pr.codi_prof = historic_professors.codi_prof
        WHERE pr.dni = ?
        ORDER BY id DESC
    ");
    $stmt4->bind_param("s", $dni_professor);
    $stmt4->execute();
    $absencies = $stmt4->get_result()->fetch_all(MYSQLI_ASSOC);
    $stmt4->close();

    $resposta["dni"]        = $prof["dni"];
    $resposta["telf_mob"]   = $prof["telf_mob"];
    $resposta["telf_fix"]   = $prof["telf_fix"];
    $resposta["poblacio"]   = $prof["poblacio"];
    $resposta["data_naix"]  = $prof["data_naix"];
    $resposta["nacionalitat"] = $prof["nacionalitat"];
    $resposta["contractes"] = $contractes;
    $resposta["absencies"]  = $absencies;
}

echo json_encode($resposta);