package com.example.evalis.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import coil.request.ImageRequest
import com.example.evalis.GestorSQLExternModern
import com.example.evalis.ui.components.Assignatures
import com.example.evalis.ui.theme.EvalisTheme
import org.json.JSONArray
import org.json.JSONObject
import kotlin.concurrent.thread
import com.example.evalis.R
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext


private const val BASE_URL = "http://192.168.1.15"

data class AssigAlumne(
    val nom: String,
    val aula: String
)

@Composable
fun ProfsDetail(dni: String, profId: String, onClose: () -> Unit = {}) {

    var isLoading by remember { mutableStateOf(true) }
    var fullName by remember { mutableStateOf("Loading...") }
    var email by remember { mutableStateOf("Loading...") }
    var fotoUrl by remember { mutableStateOf("") }
    val assignatures = remember { mutableStateListOf<AssigAlumne>() }

    LaunchedEffect(profId) {
        isLoading = true

        val result = withContext(Dispatchers.IO) {
            try {
                val gestor = GestorSQLExternModern()
                gestor.connectar("$BASE_URL/get_prof.php?dni=$dni&codi_prof=$profId")
            } catch (e: Exception) {
                null
            }
        }

        val obj = result?.optJSONObject(0)

        if (obj != null) {
            val parsed = parsejarProf(obj)
            fullName = parsed.fullName
            email = parsed.email
            fotoUrl = parsed.fotoUrl

            assignatures.clear()
            assignatures.addAll(parsed.assignatures)
        }

        isLoading = false
    }


    EvalisTheme {
        Scaffold(modifier = Modifier.fillMaxSize()) { inner ->
            ProfCard(
                isLoading = isLoading,
                fullName = fullName,
                email = email,
                fotoUrl = fotoUrl,
                llistAssignatures = assignatures,
                modifier = Modifier
                    .padding(inner)
                    .verticalScroll(rememberScrollState())
                    .fillMaxSize()
                    .padding(16.dp),
                onClose = onClose
            )
        }
    }
}



private data class ParsedProf(
    val fullName: String,
    val email: String,
    val fotoUrl: String,
    val assignatures: List<AssigAlumne>
)

private fun parsejarProf(obj: JSONObject): ParsedProf {

    val name = obj.optString("nom")
    val surname = obj.optString("cognom")

    val fullName = "$surname, $name"

    val email = obj.optString("email").ifBlank { "-" }
    val url = obj.optString("ruta_foto")

    val fotoUrl= if(url.startsWith("/")) "${BASE_URL}$url" else url


    val assignaturesArr = obj.optJSONArray("assignatures") ?: JSONArray()
    val assignatures = mutableListOf<AssigAlumne>()

    for (i in 0 until assignaturesArr.length()) {
        val t = assignaturesArr.optJSONObject(i) ?: continue
        val name = t.optString("nom_assignatura")
        val aula = t.optString("aula")
        if (name.isNotBlank()) {
            assignatures.add(AssigAlumne(name, "Aula: $aula"))
        }
    }

    return ParsedProf(
        fullName, email, fotoUrl, assignatures
    )
}

@Composable
fun ProfCard(
    isLoading: Boolean,
    fullName: String,
    email: String,
    fotoUrl: String,
    llistAssignatures: List<AssigAlumne>,
    modifier: Modifier = Modifier,
    onClose: () -> Unit
) {
    val context = LocalContext.current

    Column(modifier = modifier, verticalArrangement = Arrangement.spacedBy(12.dp)) {

        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            Text(text = stringResource(R.string.prof_label), fontWeight = FontWeight.SemiBold)
            Text(text = fullName)
        }

        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            Text(text = stringResource(R.string.email_label), fontWeight = FontWeight.SemiBold)
            Text(text = email)
        }


        AsyncImage(
            model = ImageRequest.Builder(context).data(fotoUrl).crossfade(true).build(),
            contentDescription = "Foto del professor",
            modifier = Modifier.fillMaxWidth().height(300.dp),
            contentScale = ContentScale.Crop,
            placeholder = painterResource(R.drawable.placeholder_pfp),
            error = painterResource(R.drawable.placeholder_pfp),
            fallback = painterResource(R.drawable.placeholder_pfp)
        )


        Assignatures(llistAssignatures)

        Button(
            onClick = onClose,
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 16.dp),
            enabled = !isLoading
        ) {
            Text(text = stringResource(R.string.button_label))
        }
    }
}


