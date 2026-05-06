<?php
ob_start();
error_reporting(0);
ini_set('display_errors', 0);
header("Content-Type: application/json; charset=utf-8");

$host = "localhost"; $user = "root"; $pass = ""; $db = "projecte_evalis"; $port = 3307;
$mysqli = new mysqli($host, $user, $pass, $db, $port);
if ($mysqli->connect_error) { ob_clean(); echo json_encode(["error" => "Error de connexió"]); exit; }

require "validar_token.php";

$stmt = $mysqli->prepare("SELECT nia FROM estudiants WHERE dni = ? LIMIT 1");
$stmt->bind_param("s", $dni_user);
$stmt->execute();
$res = $stmt->get_result()->fetch_assoc();
$stmt->close();
if (!$res) { ob_clean(); echo json_encode(["error" => "Alumne no trobat"]); exit; }
$nia = $res["nia"];

$avui = new DateTime();
$cicles = [];

$stmt = $mysqli->prepare("
    SELECT nom_cicle, grado, finalitzat, nota_final, data_inici, data_fi
    FROM historic_estudiants
    WHERE nia = ?
    ORDER BY nom_cicle, data_inici
");
$stmt->bind_param("i", $nia);
$stmt->execute();
$historic = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();

foreach ($historic as $row) {
    $nom = $row["nom_cicle"];
    if (!isset($cicles[$nom])) $cicles[$nom] = ["cursos" => [], "notes" => []];

    if ($row["data_fi"]) {
        $pct = $row["finalitzat"] ? 100 : 0;
    } else {
        $inici = new DateTime($row["data_inici"]);
        $dies = $inici->diff($avui)->days;
        $pct = min(100, round($dies / 292 * 100));
    }

    $cicles[$nom]["cursos"][] = [
        "grado"      => $row["grado"],
        "finalitzat" => (bool)$row["finalitzat"],
        "percentatge"=> $pct,
        "nota_final" => $row["nota_final"]
    ];

    if ($row["nota_final"] !== null) {
        $cicles[$nom]["notes"][] = (float)$row["nota_final"];
    }
}

$stmt = $mysqli->prepare("
    SELECT nom_cicle, grado, data_inici FROM estudiants WHERE nia = ? LIMIT 1
");
$stmt->bind_param("i", $nia);
$stmt->execute();
$actual = $stmt->get_result()->fetch_assoc();
$stmt->close();

if ($actual) {
    $nom = $actual["nom_cicle"];
    if (!isset($cicles[$nom])) $cicles[$nom] = ["cursos" => [], "notes" => []];

    $inici = new DateTime($actual["data_inici"]);
    $dies  = $inici->diff($avui)->days;
    $pct   = min(99, round($dies / 292 * 100)); // máximo 99% si aún no ha acabado

    $cicles[$nom]["cursos"][] = [
        "grado"      => $actual["grado"],
        "finalitzat" => false,
        "percentatge"=> $pct,
        "nota_final" => null
    ];
}

$resultat = [];
foreach ($cicles as $nom => $data) {
    $cursos  = $data["cursos"];
    $notes   = $data["notes"];
    $total   = count($cursos);
    $pctMitja = $total > 0 ? round(array_sum(array_column($cursos, "percentatge")) / $total) : 0;
    $notaMitja = count($notes) > 0 ? round(array_sum($notes) / count($notes), 1) : null;
    $acabat  = $pctMitja === 100;

    $cursosOut = [];
    foreach ($cursos as $c) {
        $cursosOut[] = [
            "grado"      => $c["grado"],
            "finalitzat" => $c["finalitzat"],
            "percentatge"=> $c["percentatge"],
            "nota_final" => $c["nota_final"]
        ];
    }

    $resultat[] = [
        "nom_cicle"    => $nom,
        "total_cursos" => $total,
        "percentatge"  => $pctMitja,
        "nota_mitja"   => $notaMitja,
        "acabat"       => $acabat,
        "cursos"       => $cursosOut
    ];
}

ob_clean();
echo json_encode(["cicles" => $resultat]);