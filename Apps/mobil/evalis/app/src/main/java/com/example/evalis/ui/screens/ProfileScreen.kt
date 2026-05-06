package com.example.evalis.ui.screens

import android.Manifest
import android.content.ContentValues
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.widget.Toast
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.nativeCanvas
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import coil.request.ImageRequest
import com.example.evalis.core.data.GestorSQLExternModern
import com.example.evalis.core.data.GestorSQLExternModern.SqlInfo.BASE_URL
import com.example.evalis.core.data.SessionData
import com.example.evalis.core.domain.Perfil
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MultipartBody
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.asRequestBody
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream

data class CicleStats(
    val nomCicle: String,
    val percentatge: Int,
    val notaMitja: Float,
    val totalCursos: Int,
    val acabat: Boolean,
    val cursos: List<CursStats>
)

data class CursStats(
    val grado: String,
    val finalitzat: Boolean,
    val percentatge: Int,
    val notaFinal: Float?
)

@Composable
fun ProfileScreen() {
    val context = LocalContext.current
    var perfil by remember { mutableStateOf<Perfil?>(null) }
    var cicles by remember { mutableStateOf<List<CicleStats>>(emptyList()) }
    var isLoading by remember { mutableStateOf(true) }
    var error by remember { mutableStateOf("") }
    var fotoUrl by remember { mutableStateOf("") }
    var uploading by remember { mutableStateOf(false) }
    var showDialog by remember { mutableStateOf(false) }
    var cameraUri by remember { mutableStateOf<Uri?>(null) }

    val permLauncher =
        rememberLauncherForActivityResult(ActivityResultContracts.RequestPermission()) { granted ->
            if (granted) showDialog = true
            else Toast.makeText(context, "Cal permís de càmera", Toast.LENGTH_SHORT).show()
        }

    val cameraLauncher =
        rememberLauncherForActivityResult(ActivityResultContracts.TakePicture()) { success ->
            if (success && cameraUri != null) {
                uploading = true
                CoroutineScope(Dispatchers.IO).launch {
                    val file = processarFoto(context, cameraUri!!)
                    val novaRuta = file?.let { pujarFoto(it) }
                    withContext(Dispatchers.Main) {
                        if (novaRuta != null) {
                            fotoUrl = "$BASE_URL$novaRuta?t=${System.currentTimeMillis()}"
                            Toast.makeText(context, "Foto actualitzada", Toast.LENGTH_SHORT).show()
                        } else {
                            Toast.makeText(context, "Error pujant la foto", Toast.LENGTH_SHORT)
                                .show()
                        }
                        uploading = false
                    }
                }
            }
        }

    LaunchedEffect(Unit) {
        val result = withContext(Dispatchers.IO) {
            try {
                GestorSQLExternModern().connectarObj("${BASE_URL}/get_perfil.php?dni=${SessionData.dni}&token=${SessionData.token}")
            } catch (e: Exception) {
                null
            }
        }
        if (result == null || result.has("error")) {
            error = result?.optString("error") ?: "Error carregant el perfil"
        } else {
            val ruta = result.optString("ruta_foto")
            fotoUrl = if (ruta.startsWith("/")) "$BASE_URL$ruta" else ruta
            perfil = Perfil(
                nom = result.optString("nom"), cognom = result.optString("cognom"),
                dataNaix = result.optString("data_naix"), email = result.optString("email"),
                telefon = result.optString("telf_mob"), poblacio = result.optString("poblacio"),
                rutaFoto = ruta, nomGrup = result.optString("nom_grup"),
                nomCicle = result.optString("nom_cicle"), grado = result.optString("grado"),
                treballant = result.optBoolean("treballant"), empresa = result.optString("empresa")
            )
        }

        val stats = withContext(Dispatchers.IO) {
            try {
                GestorSQLExternModern().connectarObj("${BASE_URL}/get_estadistiques.php?token=${SessionData.token}")
            } catch (e: Exception) {
                null
            }
        }
        if (stats != null && !stats.has("error")) {
            val arr = stats.optJSONArray("cicles")
            cicles = (0 until (arr?.length() ?: 0)).map { i ->
                val c = arr!!.getJSONObject(i)  // ← 'c' se define aquí dentro del map
                val cursosArr = c.optJSONArray("cursos")
                val cursos = (0 until (cursosArr?.length() ?: 0)).map { j ->
                    val cu = cursosArr!!.getJSONObject(j)
                    CursStats(
                        grado = cu.optString("grado"),
                        finalitzat = cu.optBoolean("finalitzat"),
                        percentatge = cu.optInt("percentatge"),
                        notaFinal = if (cu.isNull("nota_final")) null else cu.optDouble("nota_final")
                            .toFloat()
                    )
                }
                CicleStats(
                    nomCicle = c.optString("nom_cicle"),
                    percentatge = c.optInt("percentatge"),
                    notaMitja = if (c.isNull("nota_mitja")) 0f else c.optDouble("nota_mitja")
                        .toFloat(),
                    totalCursos = c.optInt("total_cursos"),
                    acabat = c.optBoolean("acabat"),
                    cursos = cursos
                )
            }
        }
        isLoading = false
    }

    if (showDialog) {
        AlertDialog(
            onDismissRequest = { showDialog = false },
            title = { Text("Canviar foto") },
            text = { Text("Vols fer una foto nova amb la càmera?") },
            confirmButton = {
                TextButton(onClick = {
                    showDialog = false
                    crearUriCamera(context).also { cameraUri = it; cameraLauncher.launch(it) }
                }) { Text("Càmera") }
            },
            dismissButton = { TextButton(onClick = { showDialog = false }) { Text("Cancel·lar") } }
        )
    }

    Scaffold { inner ->
        Box(Modifier
            .padding(inner)
            .fillMaxSize()) {
            when {
                isLoading -> CircularProgressIndicator(Modifier.align(Alignment.Center))
                error.isNotEmpty() -> Text(
                    error,
                    Modifier.align(Alignment.Center),
                    color = MaterialTheme.colorScheme.error
                )

                perfil != null -> Column(
                    Modifier
                        .fillMaxSize()
                        .verticalScroll(rememberScrollState())
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    Box(contentAlignment = Alignment.BottomEnd) {
                        AsyncImage(
                            model = ImageRequest.Builder(context).data(fotoUrl).crossfade(true)
                                .build(),
                            contentDescription = "Foto",
                            modifier = Modifier
                                .size(120.dp)
                                .clip(CircleShape)
                                .clickable(enabled = !uploading) { permLauncher.launch(Manifest.permission.CAMERA) },
                            contentScale = ContentScale.Crop
                        )
                        if (uploading) CircularProgressIndicator(Modifier.size(24.dp))
                        else Icon(
                            Icons.Default.Edit,
                            null,
                            Modifier
                                .size(28.dp)
                                .clip(CircleShape)
                                .padding(4.dp)
                        )
                    }

                    Text(
                        "${perfil!!.cognom}, ${perfil!!.nom}",
                        style = MaterialTheme.typography.titleLarge,
                        fontWeight = FontWeight.Bold
                    )
                    Spacer(Modifier.height(4.dp))

                    ProfileRow("DNI", SessionData.dni)
                    ProfileRow("Data de naixement", perfil!!.dataNaix)
                    ProfileRow("Email", perfil!!.email)
                    ProfileRow("Telèfon", perfil!!.telefon)
                    ProfileRow("Població", perfil!!.poblacio)

                    Spacer(Modifier.height(4.dp))
                    Text(
                        "Estudis",
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.Bold
                    )
                    ProfileRow("Cicle", perfil!!.nomCicle)
                    ProfileRow("Grau", perfil!!.grado)
                    ProfileRow("Grup", perfil!!.nomGrup)

                    if (perfil!!.treballant && perfil!!.empresa.isNotBlank()) {
                        Spacer(Modifier.height(4.dp))
                        Text(
                            "FCT",
                            style = MaterialTheme.typography.titleMedium,
                            fontWeight = FontWeight.Bold
                        )
                        ProfileRow("Empresa", perfil!!.empresa)
                    }

                    if (cicles.isNotEmpty()) {
                        Spacer(Modifier.height(4.dp))
                        Text(
                            "Estadístiques",
                            style = MaterialTheme.typography.titleMedium,
                            fontWeight = FontWeight.Bold
                        )
                        HorizontalDivider(Modifier.padding(vertical = 8.dp))
                        cicles.forEach { CicleStatsCard(it) }
                    }
                }
            }
        }
    }
}

@Composable
fun ProfileRow(label: String, value: String) {
    Column {
        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            Text(label, fontWeight = FontWeight.SemiBold)
            Text(value.ifBlank { "-" }, color = MaterialTheme.colorScheme.onSurfaceVariant)
        }
        HorizontalDivider(Modifier.padding(top = 8.dp))
    }
}

@Composable
fun CicleStatsCard(cicle: CicleStats) {
    Column(Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(cicle.nomCicle, fontWeight = FontWeight.SemiBold)

        cicle.cursos.forEach { curs ->
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                DonutChart(curs.percentatge, Modifier.size(80.dp))
                Column {
                    // Mostrar grado solo si no está finalizado
                    Text(
                        text = curs.grado,
                        style = MaterialTheme.typography.labelMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Text(
                        text = "${curs.percentatge}% completat",
                        fontWeight = FontWeight.Bold,
                        color = colorForPercentatge(curs.percentatge)
                    )
                    curs.notaFinal?.let {
                        Text(
                            text = "Nota: ${"%.1f".format(it)}",
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
            }
        }

        if (cicle.notaMitja > 0) {
            Text(
                text = "Nota mitjana: ${"%.1f".format(cicle.notaMitja)}",
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
        Spacer(Modifier.height(4.dp))
    }
}

@Composable
fun DonutChart(percentatge: Int, modifier: Modifier = Modifier) {
    val color = colorForPercentatge(percentatge)
    val anim = remember { androidx.compose.animation.core.Animatable(0f) }
    LaunchedEffect(percentatge) {
        anim.animateTo(
            percentatge / 100f,
            androidx.compose.animation.core.tween(1000)
        )
    }

    Canvas(modifier) {
        val sw = size.minDimension * 0.15f
        val r = (size.minDimension - sw) / 2
        val c = androidx.compose.ui.geometry.Offset(size.width / 2, size.height / 2)
        val tl = androidx.compose.ui.geometry.Offset(c.x - r, c.y - r)
        val rect = androidx.compose.ui.geometry.Size(r * 2, r * 2)
        val stroke = Stroke(sw, cap = StrokeCap.Round)

        drawArc(
            Color.LightGray.copy(alpha = 0.3f),
            -90f,
            360f,
            false,
            style = stroke,
            topLeft = tl,
            size = rect
        )
        drawArc(color, -90f, 360f * anim.value, false, style = stroke, topLeft = tl, size = rect)
        drawContext.canvas.nativeCanvas.drawText(
            "$percentatge%", c.x, c.y + size.minDimension * 0.08f,
            android.graphics.Paint().apply {
                textAlign = android.graphics.Paint.Align.CENTER
                textSize = size.minDimension * 0.2f
                isFakeBoldText = true
                this.color = android.graphics.Color.DKGRAY
            })
    }
}

@Composable
fun BarraProgres(percentatge: Int) {
    val anim = remember { androidx.compose.animation.core.Animatable(0f) }
    LaunchedEffect(percentatge) {
        anim.animateTo(
            percentatge / 100f,
            androidx.compose.animation.core.tween(1000)
        )
    }

    Text(
        "Progrés del cicle",
        style = MaterialTheme.typography.bodySmall,
        color = MaterialTheme.colorScheme.onSurfaceVariant
    )
    Box(
        Modifier
            .fillMaxWidth()
            .height(12.dp)
            .clip(RoundedCornerShape(6.dp))
            .background(Color.LightGray.copy(alpha = 0.3f))
    ) {
        Box(
            Modifier
                .fillMaxWidth(anim.value)
                .fillMaxHeight()
                .clip(RoundedCornerShape(6.dp))
                .background(colorForPercentatge(percentatge))
        )
    }
}

@Composable
fun colorForPercentatge(percentatge: Int): Color = when {
    percentatge >= 75 -> Color(0xFF4CAF50)
    percentatge >= 40 -> Color(0xFFFF9800)
    else -> Color(0xFFF44336)
}

fun crearUriCamera(context: Context): Uri {
    val tempFile = File(context.cacheDir, "temp_photo.jpg")
    return androidx.core.content.FileProvider.getUriForFile(
        context,
        "${context.packageName}.fileprovider",
        tempFile
    )
}

fun processarFoto(context: Context, uri: Uri): File? {
    return try {
        var bitmap =
            BitmapFactory.decodeStream(context.contentResolver.openInputStream(uri)) ?: return null
        val min = minOf(bitmap.width, bitmap.height)
        bitmap = Bitmap.createBitmap(
            bitmap,
            (bitmap.width - min) / 2,
            (bitmap.height - min) / 2,
            min,
            min
        )
        if (bitmap.width > 600) bitmap = Bitmap.createScaledBitmap(bitmap, 600, 600, true)

        val baos = ByteArrayOutputStream()
        var quality = 90
        do {
            baos.reset(); bitmap.compress(Bitmap.CompressFormat.JPEG, quality, baos); quality -= 10
        } while (baos.size() > 300 * 1024 && quality > 10)

        val tempFile = File(context.cacheDir, "perfil_upload.jpg")
        FileOutputStream(tempFile).use { it.write(baos.toByteArray()) }

        val values = ContentValues().apply {
            put(MediaStore.Images.Media.DISPLAY_NAME, "perfil_${System.currentTimeMillis()}.jpg")
            put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
                put(MediaStore.Images.Media.RELATIVE_PATH, "Pictures/Evalis")
        }
        context.contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)
            ?.let { mUri ->
                context.contentResolver.openOutputStream(mUri)?.use { it.write(baos.toByteArray()) }
            }
        tempFile
    } catch (e: Exception) {
        e.printStackTrace(); null
    }
}

fun pujarFoto(file: File): String? {
    return try {
        val body = MultipartBody.Builder().setType(MultipartBody.FORM)
            .addFormDataPart("dni", SessionData.dni)
            .addFormDataPart("token", SessionData.token)
            .addFormDataPart("foto", file.name, file.asRequestBody("image/jpeg".toMediaType()))
            .build()
        val response = OkHttpClient().newCall(
            Request.Builder().url("${BASE_URL}/pfp_mobil.php").post(body).build()
        ).execute()
        val json = org.json.JSONObject(response.body?.string() ?: return null)
        if (json.optBoolean("ok")) json.optString("ruta_foto") else null
    } catch (e: Exception) {
        e.printStackTrace(); null
    }
}