<?php
// Genera butlletí de notes d'un curs
require_once 'vendor/autoload.php';
use Dompdf\Dompdf;
use Dompdf\Options;

$dni       = isset($_GET['dni'])        ? $_GET['dni']        : "";
$cicle     = isset($_GET['cicle'])      ? $_GET['cicle']      : "";
$dataInici = isset($_GET['data_inici']) ? $_GET['data_inici'] : "";

if ($dni === "" || $cicle === "" || $dataInici === "") {
    http_response_code(400);
    exit;
}

$mysqli = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($mysqli->connect_errno) {
    http_response_code(500);
    exit;
}
$mysqli->set_charset("utf8mb4");

include "validar_token.php";

$sql = "SELECT p.nom, p.cognom, p.dni, e.nia, e.nom_grup
        FROM persones p
        JOIN estudiants e ON e.dni = p.dni
        WHERE p.dni = ?";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("s", $dni);
$stmt->execute();
$alumne = $stmt->get_result()->fetch_assoc();

if (!$alumne) {
    http_response_code(404);
    exit;
}

// curs actual
$sql2 = "SELECT grado, finalitzat, nota_final, data_inici, data_fi
         FROM historic_estudiants
         WHERE nia = ? AND nom_cicle = ? AND data_inici = ?";
$stmt2 = $mysqli->prepare($sql2);
$stmt2->bind_param("iss", $alumne['nia'], $cicle, $dataInici);
$stmt2->execute();
$curs = $stmt2->get_result()->fetch_assoc();

// diferenciar curs actual de historic
$esActual = false;
if (!$curs) {
    $sql2b = "SELECT data_inici, nom_grup
              FROM estudiants
              WHERE nia = ? AND nom_cicle = ? AND data_inici = ?";
    $stmt2b = $mysqli->prepare($sql2b);
    $stmt2b->bind_param("iss", $alumne['nia'], $cicle, $dataInici);
    $stmt2b->execute();
    $cursActual = $stmt2b->get_result()->fetch_assoc();
    if ($cursActual) {
        $esActual = true;
        $curs = [
            "grado"      => null,
            "finalitzat" => false,
            "nota_final" => null,
            "data_inici" => $cursActual['data_inici'],
            "data_fi"    => null
        ];
    } else {
        http_response_code(404);
        exit;
    }
}

$anyInici  = date('Y', strtotime($curs['data_inici']));
$anyFi     = $curs['data_fi'] ? date('Y', strtotime($curs['data_fi'])) : ($anyInici + 1);
$cursText  = $anyInici . '-' . $anyFi;
$grau      = $curs['grado'] ?? 'En curs';
$notaFinal = $curs['nota_final'] ?? '-';
$dataFi    = $curs['data_fi'] ?? date('Y-m-d', strtotime($dataInici . ' +1 year'));

// ras i notes curs
$sql3 = "SELECT DISTINCT
                a.codi AS codi_assignatura,
                a.nom AS nom_assignatura,
                COALESCE(r.ra, 1) AS num_ra,
                er.nota
         FROM assignatures_cicle ac
         JOIN assignatures a ON a.codi = ac.id_assignatura
         LEFT JOIN ras r ON r.codi_assignatura = a.codi
         LEFT JOIN estudiants_ras er ON er.id_ra = r.id
             AND er.nia = ?
             AND er.data_inici >= ?
             AND er.data_inici <= ?
         WHERE ac.nom_cicle = ?
         ORDER BY a.codi, num_ra";

$stmt3 = $mysqli->prepare($sql3);
$stmt3->bind_param("isss", $alumne['nia'], $dataInici, $dataFi, $cicle);
$stmt3->execute();
$res3 = $stmt3->get_result();

$ras = [];
while ($row = $res3->fetch_assoc()) {
    $ras[] = $row;
}

$mysqli->close();

//agrupació ras
$assignatures = [];
foreach ($ras as $ra) {
    $codi = $ra['codi_assignatura'];
    if (!isset($assignatures[$codi])) {
        $assignatures[$codi] = ['nom' => $ra['nom_assignatura'], 'ras' => []];
    }
    $assignatures[$codi]['ras'][] = $ra;
}
foreach ($assignatures as $codi => &$assig) {
    $notes = array_filter(array_column($assig['ras'], 'nota'), fn($n) => $n !== null);
    $assig['nota_final'] = count($notes) > 0 ? round(array_sum($notes) / count($notes), 1) : null;
}
unset($assig);

$finalitzatText = $curs['finalitzat'] ? 'Sí' : ($esActual ? 'En curs' : 'No');

$html = '<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  body        { font-family: DejaVu Sans, Arial, sans-serif; font-size: 11px; color: #222; margin: 20px; }
  h1          { text-align: center; font-size: 16px; margin-bottom: 4px; }
  h2          { text-align: center; font-size: 12px; color: #555; margin-top: 0; }
  h3          { font-size: 12px; margin: 6px 0; }
  h4          { font-size: 11px; margin: 4px 0; color: #444; }
  p           { margin: 2px 0; }
  hr          { border: none; border-top: 1px solid #aaa; margin: 10px 0; }
  .layout     { width: 100%; border-collapse: collapse; }
  .layout td  { vertical-align: top; padding: 4px 6px; }
  table.dades { width: 100%; border-collapse: collapse; margin-top: 16px; }
  table.dades th { background-color: #2c5f9e; color: white; padding: 7px 8px; text-align: left; font-size: 11px; }
  table.dades td { border: 1px solid #ccc; padding: 6px 8px; }
  .nota-ok    { color: #1a7a1a; font-weight: bold; }
  .nota-fail  { color: #c0392b; font-weight: bold; }
  .peu        { margin-top: 30px; font-size: 10px; color: #888; text-align: center; }
  .assig-cap  { background-color: #e8f0fb; font-weight: bold; }
  .nota-modul { background-color: #f9f9f9; border-top: 2px solid #ccc; font-style: italic; }
</style>
</head>
<body>

<table class="layout">
  <tr>
    <td style="text-align: center;">
      <h1>Butlletí de Notes</h1>
      <h2>' . htmlspecialchars($cicle) . ' &nbsp;|&nbsp; ' . $grau . ' &nbsp;|&nbsp; Curs: ' . $cursText . '</h2>
    </td>
  </tr>
</table>

<hr>

<h3>Dades del centre</h3>
<table class="layout">
  <tr>
    <td style="width: 25%;"><h4>Codi</h4><p>12345678</p></td>
    <td style="width: 40%;"><h4>Nom</h4><p>Institut Tècnic de Ponent</p></td>
    <td style="width: 35%;"><h4>Adreça</h4><p>Plaça de Sta. Anna, 4, 25003 Lleida</p></td>
  </tr>
</table>

<hr>

<h3>Dades de l\'alumne/a</h3>
<table class="layout">
  <tr>
    <td style="width: 40%;"><h4>Nom i cognoms</h4><p>' . htmlspecialchars($alumne['nom'] . ' ' . $alumne['cognom']) . '</p></td>
    <td style="width: 25%;"><h4>DNI</h4><p>' . htmlspecialchars($alumne['dni']) . '</p></td>
    <td style="width: 25%;"><h4>NIA</h4><p>' . $alumne['nia'] . '</p></td>
  </tr>
  <tr>
    <td style="width: 40%;"><h4>Grup</h4><p>' . htmlspecialchars($alumne['nom_grup']) . '</p></td>
    <td style="width: 25%;"><h4>Curs finalitzat</h4><p>' . $finalitzatText . '</p></td>
    <td style="width: 25%;"><h4>Nota del curs</h4><p>' . $notaFinal . '</p></td>
  </tr>
</table>

<hr>

<h3>Qualificacions</h3>';

if ($esActual && empty(array_filter($ras, fn($r) => $r['nota'] !== null))) {
    $html .= '<p>Encara no hi ha qualificacions disponibles per a aquest curs.</p>';
} else {
    $html .= '<table class="dades">
  <thead>
    <tr>
      <th style="width:55%">Assignatura / RA</th>
      <th style="width:20%">Núm. RA</th>
      <th style="width:25%">Nota</th>
    </tr>
  </thead>
  <tbody>';

    foreach ($assignatures as $codi => $assig) {
        $html .= '<tr class="assig-cap">
            <td colspan="3">' . htmlspecialchars($codi . ' — ' . $assig['nom']) . '</td>
        </tr>';

        foreach ($assig['ras'] as $ra) {
            $nota      = $ra['nota'] !== null ? $ra['nota'] : '-';
            $notaClass = $ra['nota'] !== null ? ($ra['nota'] >= 5 ? 'nota-ok' : 'nota-fail') : '';
            $html .= '<tr>
                <td style="padding-left:20px;">Resultat d\'aprenentatge ' . $ra['num_ra'] . '</td>
                <td>RA' . $ra['num_ra'] . '</td>
                <td class="' . $notaClass . '">' . $nota . '</td>
            </tr>';
        }

        $notaModul      = $assig['nota_final'] !== null ? $assig['nota_final'] : '-';
        $notaModulClass = $assig['nota_final'] !== null ? ($assig['nota_final'] >= 5 ? 'nota-ok' : 'nota-fail') : '';
        $html .= '<tr class="nota-modul">
            <td colspan="2" style="text-align:right;">Nota final del mòdul</td>
            <td class="' . $notaModulClass . '"><strong>' . $notaModul . '</strong></td>
        </tr>';
    }

    $html .= '</tbody></table>';
}

$html .= '<p class="peu">Document generat el ' . date('d/m/Y H:i') . '</p>
</body>
</html>';

$options = new Options();
$options->set('defaultFont', 'DejaVu Sans');
$options->set('isRemoteEnabled', true);
$options->set('chroot', 'C:/xampp/htdocs');
$dompdf = new Dompdf($options);
$dompdf->loadHtml($html, 'UTF-8');
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();

$nomFitxer = 'butlleti_' . $dni . '_' . preg_replace('/\s+/', '_', $cicle) . '_' . $anyInici . '.pdf';
header('Content-Type: application/pdf');
header('Content-Disposition: attachment; filename="' . $nomFitxer . '"');
echo $dompdf->output();
?>