package com.example.evalis.feature.profs

import android.os.Handler
import android.os.Looper
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Card
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.example.evalis.core.data.GestorSQLExternModern
import com.example.evalis.core.data.GestorSQLExternModern.SqlInfo.BASE_URL
import com.example.evalis.core.data.SessionData
import com.example.evalis.core.domain.Prof
import org.json.JSONArray
import kotlin.concurrent.thread

var isLoading by mutableStateOf(true)
val profState = mutableStateListOf<Prof>()

object ProfsList {
    fun placeholders(): List<Prof> = listOf(
        Prof("", "Loading...", "", "", ""),
        Prof("", "Loading...", "", "", ""),
        Prof("", "Loading...", "", "", "")
    )
}

@Composable
fun ProfsScreen(navController: NavController, onSessionExpired: () -> Unit) {
    LaunchedEffect(Unit) {
        profState.clear()
        profState.addAll(ProfsList.placeholders())
        carregarProfDesDeServidor(SessionData.dni, navController, onSessionExpired)
    }

    Scaffold(modifier = Modifier.fillMaxWidth()) { inner ->
        Column(
            modifier = Modifier
                .padding(inner)
                .fillMaxSize()
                .padding(16.dp)
        ) {
            Text(
                text = stringResource(R.string.profs_label),
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold
            )
            Spacer(Modifier.height(12.dp))
            SearchView(profs = profState, navController = navController)
        }
    }
}

private fun carregarProfDesDeServidor(
    dniAlumne: String,
    navController: NavController,
    onSessionExpired: () -> Unit
) {
    isLoading = true
    thread {
        try {
            val gestor = GestorSQLExternModern()
            val arr: JSONArray? =
                gestor.connectar("${BASE_URL}/get_profs.php?dni=$dniAlumne&token=${SessionData.token}")

            Handler(Looper.getMainLooper()).post {
                if (arr == null && gestor.lastError == "Token expirado") {
                    onSessionExpired()
                    return@post
                }

                if (arr == null) {
                    profState.clear()
                    profState.add(Prof("", "Sense connexió", "", "", ""))
                    isLoading = false
                    return@post
                }

                profState.clear()

                for (i in 0 until arr.length()) {
                    val obj = arr.getJSONObject(i)
                    val id = obj.optString("codi_prof")
                    val name = obj.optString("nom")
                    val surname = obj.optString("cognom")
                    val email = obj.optString("email")
                    val rutaRel = obj.optString("ruta_foto")
                    val urlFoto = if (rutaRel.startsWith("/")) "${BASE_URL}$rutaRel" else rutaRel

                    if (id != "") {
                        profState.add(Prof(id, name, surname, urlFoto, email))
                    }
                }

                if (profState.isEmpty()) {
                    profState.add(Prof("", "No hi ha dades", "", "", ""))
                }

                isLoading = false
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}

@Composable
fun ProfsListItem(prof: Prof, isLoading: Boolean, navController: NavController) {
    val clickableEnabled = !isLoading && prof.id != ""

    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(enabled = clickableEnabled) {
                navController.navigate("profDetail/${prof.id}/${SessionData.dni}")
            }
    ) {
        Row(
            modifier = Modifier.fillMaxWidth().padding(12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            AsyncImage(
                model = prof.imageUrl,
                contentDescription = "${prof.surname}, ${prof.name}",
                modifier = Modifier.size(56.dp).clip(CircleShape),
                contentScale = ContentScale.Crop,
                placeholder = painterResource(R.drawable.placeholder),
                error = painterResource(R.drawable.placeholder),
                fallback = painterResource(R.drawable.placeholder)
            )
            Spacer(Modifier.width(12.dp))
            Text(
                text = "${prof.surname}, ${prof.name}",
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
        }
    }
}

@Composable
fun SearchView(profs: List<Prof>, navController: NavController) {
    var textSearch by remember { mutableStateOf("") }

    Column(modifier = Modifier.fillMaxSize()) {
        TextField(
            modifier = Modifier.fillMaxWidth(),
            value = textSearch,
            onValueChange = { textSearch = it },
            placeholder = { Text(text = "Professor/a") },
            maxLines = 1,
            singleLine = true,
            textStyle = TextStyle(color = Color.Black, fontSize = 20.sp),
            trailingIcon = {
                Icon(imageVector = Icons.Default.Search, contentDescription = null)
            },
            shape = RoundedCornerShape(8.dp),
            colors = TextFieldDefaults.colors(
                focusedIndicatorColor = Color.Transparent,
                unfocusedIndicatorColor = Color.Transparent
            )
        )

        val filtrats = profs.filter {
            it.name.contains(textSearch, ignoreCase = true) ||
                    it.surname.contains(textSearch, ignoreCase = true)
        }

        Spacer(Modifier.height(21.dp))

        LazyColumn(
            modifier = Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(filtrats) { prof ->
                ProfsListItem(prof = prof, isLoading = isLoading, navController = navController)
            }
        }
    }
}