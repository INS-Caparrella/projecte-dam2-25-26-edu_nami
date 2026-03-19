package com.example.evalis.ui.screens

import android.content.Intent
import android.os.Bundle
import android.os.Looper
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
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
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import com.example.evalis.GestorSQLExternModern
import com.example.evalis.R
import com.example.evalis.ui.screens.login.SessionData
import org.json.JSONArray
import kotlin.concurrent.thread

var isLoading by mutableStateOf(true)
val profState = mutableStateListOf<Prof>()
private const val BASE_URL = "http://192.168.16.100"

data class Prof(
    val id: Int,
    val name: String,
    val surname: String,
    val imageUrl: String,
    val email: String
)

object ProfsList {
    fun placeholders(): List<Prof> = listOf(
        Prof(-1, "Loading...", "", "", ""),
        Prof(-1, "Loading...", "", "", ""),
        Prof(-1, "Loading...", "", "", "")
    )
}

@Composable
private fun ProfsList(profs: List<Prof>, isLoading: Boolean) {
    LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        items(profs) { p -> ProfsListItem(p, isLoading) }
    }
}

@Composable
fun ProfsListItem(prof: Prof, isLoading: Boolean) {
    val context = LocalContext.current
    val clickableEnabled = !isLoading && prof.id >= 0

    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(enabled = clickableEnabled) {

            },
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            AsyncImage(
                model = prof.imageUrl,
                contentDescription = "${prof.surname},${prof.name}",
                modifier = Modifier
                    .size(56.dp)
                    .clip(CircleShape),
                contentScale = ContentScale.Crop,
                placeholder = painterResource(R.drawable.placeholder),
                error = painterResource(R.drawable.placeholder),
                fallback = painterResource(R.drawable.placeholder)
            )
            Spacer(Modifier.width(12.dp))
            Text(
                text = "${prof.surname},${prof.name}",
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
        }

    }
}

@Composable
fun ProfsScreen() {

    profState.clear()
    profState.addAll(ProfsList.placeholders())

    carregarProfsDesDeServidor(SessionData.dni)

    Scaffold(modifier = Modifier.fillMaxWidth()) { inner ->
        Column(
            modifier = Modifier
                .padding(inner)
                .fillMaxSize()
                .padding(16.dp)
        ) {
            Text(
                text = stringResource(R.string.profs),
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold
            )
            Spacer(Modifier.height(12.dp))

            ProfsList(
                isLoading = isLoading,
                profs = profState
            )
        }
    }

}

private fun carregarProfsDesDeServidor(dniAlumne: String) {
    isLoading = true
    thread {
        try {
            val gestor = GestorSQLExternModern()
            val arr: JSONArray? = gestor.connectar("$BASE_URL/get_profs.php?dni=$dniAlumne")

            android.os.Handler(Looper.getMainLooper()).post {

                if (arr == null) {
                    profState.clear()
                    profState.add(Prof(-1, "Sense connexió", "", "", ""))
                    isLoading = false
                    return@post
                }

                profState.clear()

                for (i in 0 until arr.length()) {
                    val obj = arr.getJSONObject(i)

                    val id = obj.optString("dni", "-1").toIntOrNull() ?: -1
                    val name = obj.optString("nom")
                    val surname = obj.optString("cognom")
                    val email = obj.optString("email")

                    val urlFoto = ""

                    if (id >= 0) {
                        profState.add(Prof(id, name, surname, urlFoto, email))
                    }
                }

                if (profState.isEmpty()) {
                    profState.add(Prof(-1, "No hi ha dades", "", "", ""))
                }

                isLoading = false
            }

        } catch (e: Exception) {
        }
    }
}


