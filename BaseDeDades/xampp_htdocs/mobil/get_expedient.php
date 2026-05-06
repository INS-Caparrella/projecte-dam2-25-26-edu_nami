<?php
require_once 'vendor/autoload.php'; // x generar pdf
use Dompdf\Dompdf;

$dni   = isset($_GET['dni'])   ? $_GET['dni']   : "";
$cicle = isset($_GET['cicle']) ? $_GET['cicle']  : "";

if ($dni === "" || $cicle === "") {
    http_response_code(400);
    exit;
}

// Connexió
$mysqli = new mysqli("localhost", "root", "", "projecte_evalis", 3307);
if ($mysqli->connect_errno) {
    http_response_code(500);
    exit;
}
$mysqli->set_charset("utf8mb4");

include "validar_token.php";

// DADES ALUMNE
$sql = "SELECT p.nom, p.cognom, p.dni, e.nia, e.nom_grup
        FROM persones p
        JOIN estudiants e ON e.dni = p.dni
        WHERE p.dni = ?";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("s", $dni);
$stmt->execute();
$res = $stmt->get_result();
$alumne = $res->fetch_assoc();

if (!$alumne) {
    http_response_code(404);
    exit;
}

// 2. DADES CICLE
$sql2 = "SELECT nom_cicle, finalitzat, nota_final, data_inici, data_fi
         FROM historic_estudiants
         WHERE nia = ? AND nom_cicle = ?";
$stmt2 = $mysqli->prepare($sql2);
$stmt2->bind_param("is", $alumne['nia'], $cicle);
$stmt2->execute();
$res2 = $stmt2->get_result();
$historic = $res2->fetch_assoc();

if (!$historic) {
    http_response_code(404);
    exit;
}

$anyInici = date('Y', strtotime($historic['data_inici']));
$anyFi    = $historic['data_fi'] ? date('Y', strtotime($historic['data_fi'])) : ($anyInici + 1);
$curs     = $anyInici . '-' . $anyFi;

$sql3 = "SELECT DISTINCT
                a.codi AS codi_assignatura, 
                a.nom AS nom_assignatura,
                COALESCE(r.id, 0) AS id_ra, 
                COALESCE(r.ra, 1) AS num_ra,
                er.nota
         FROM assignatures_cicle ac
         JOIN assignatures a ON a.codi = ac.id_assignatura
         LEFT JOIN ras r ON r.codi_assignatura = a.codi
         LEFT JOIN estudiants_ras er ON er.id_ra = r.id AND er.nia = ?
         WHERE ac.nom_cicle = ?
           AND (er.nia IS NOT NULL 
                OR r.data_inici BETWEEN ? AND ?
                OR r.id IS NULL)
         ORDER BY a.codi, num_ra";

$dataInici = $historic['data_inici']; 
$dataFi    = $historic['data_fi'] ?: date('Y-m-d', strtotime($historic['data_inici'] . ' +1 year'));

$stmt3 = $mysqli->prepare($sql3);
$stmt3->bind_param("isss", $alumne['nia'], $cicle, $dataInici, $dataFi);
$stmt3->execute();
$res3 = $stmt3->get_result();

$ras = [];
while ($row = $res3->fetch_assoc()) {
    $ras[] = $row;
}

$mysqli->close();

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

$finalitzatText = $historic['finalitzat'] ? 'Sí' : 'No';
$notaFinal      = $historic['nota_final'] !== null ? $historic['nota_final'] : '-';

$html = '<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  body        { font-family: Google Sans, Roboto, Arial, sans-serif; font-size: 11px; color: #222; margin: 20px; }
  h1          { text-align: center; font-size: 16px; margin-bottom: 4px; }
  h2          { text-align: center; font-size: 12px; color: #555; margin-top: 0; }
  h3          { font-size: 12px; margin: 6px 0; }
  h4          { font-size: 11px; margin: 4px 0; color: #444; }
  p           { margin: 2px 0; }
  hr          { border: none; border-top: 1px solid #aaa; margin: 10px 0; }
  .logo       { width: 80px; }
  .layout     { width: 100%; border-collapse: collapse; }
  .layout td  { vertical-align: top; padding: 4px 6px; }
  table.dades { width: 100%; border-collapse: collapse; margin-top: 16px; }
  table.dades th { background-color: #2c5f9e; color: white; padding: 7px 8px; text-align: left; font-size: 11px; }
  table.dades td { border: 1px solid #ccc; padding: 6px 8px; }
  .nota-ok    { color: #1a7a1a; font-weight: bold; }
  .nota-fail  { color: #c0392b; font-weight: bold; }
  .info-box   { border: 1px solid #aaa; border-radius: 4px; padding: 8px 12px; margin: 10px 0; }
  .peu        { margin-top: 30px; font-size: 10px; color: #888; text-align: center; }
  .assig-cap  { background-color: #e8f0fb; font-weight: bold; }
  .nota-modul { background-color: #f9f9f9; border-top: 2px solid #ccc; font-style: italic; }
</style>
</head>
<body>

<table class="layout">
  <tr>
    <td style="text-align: center;">
      <h1>Expedient Acadèmic</h1>
      <h2>Certificat de cicle formatiu finalitzat &nbsp;|&nbsp; Curs acadèmic: ' . $curs . '</h2>
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

<h3>El centre certifica que l\'alumne/a</h3>
<table class="layout">
  <tr>
    <td style="width: 40%;"><h4>Nom i cognoms</h4><p>' . htmlspecialchars($alumne['nom'] . ' ' . $alumne['cognom']) . '</p></td>
    <td style="width: 25%;"><h4>DNI</h4><p>' . htmlspecialchars($alumne['dni']) . '</p></td>
    <td style="width: 25%;"><h4>NIA</h4><p>' . $alumne['nia'] . '</p></td>
  </tr>
</table>

<hr>

<h3>Matriculat/a al cicle formatiu</h3>
<table class="layout">
  <tr>
    <td style="width: 20%;"><h4>Codi</h4><p>777</p></td>
    <td style="width: 40%;"><h4>Nom</h4><p>' . htmlspecialchars($cicle) . '</p></td>
    <td style="width: 20%;"><h4>Estudi finalitzat</h4><p>' . $finalitzatText . '</p></td>
  </tr>
</table>

<div class="info-box">
  <table class="layout">
    <tr><td><b>Nota final:</b> ' . $notaFinal . '</td></tr>
  </table>
</div>

<h3>Qualificacions</h3>
<table class="dades">
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

$html .= '</tbody></table>
<p class="peu">Document generat el ' . date('d/m/Y H:i') . '</p>
</body>
</html>';

use Dompdf\Options;
$options = new Options();
$options->set('defaultFont', 'DejaVu Sans');
$options->set('isRemoteEnabled', true);
$options->set('chroot', 'C:/xampp/htdocs');
$dompdf = new Dompdf($options);
$dompdf->loadHtml($html, 'UTF-8');
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();

$nomFitxer = 'expedient_' . $dni . '_' . preg_replace('/\s+/', '_', $cicle) . '.pdf';
header('Content-Type: application/pdf');
header('Content-Disposition: attachment; filename="' . $nomFitxer . '"');
echo $dompdf->output();
?>