package com.example.expedient

import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.evalis.core.data.GestorSQLExternModern
import com.example.evalis.core.data.GestorSQLExternModern.SqlInfo.BASE_URL
import com.example.evalis.core.data.SessionData
import com.example.evalis.core.domain.Estudi
import com.example.evalis.core.domain.R
import com.example.expedient.reports.baixarPDF
import org.json.JSONArray
import org.json.JSONObject
import kotlin.concurrent.thread

val estudiState = mutableStateListOf<Estudi>()
var estudiIsLoading by mutableStateOf(true)


object EstudiList {
    fun placeholders(): List<Estudi> = listOf(
        Estudi("Loading..."),
        Estudi("Loading..."),
        Estudi("Loading..."),
        
    )
}

@Composable
private fun EstudisList(Estudi: List<Estudi>, isLoading: Boolean, navController: NavController) {
    LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        items(Estudi) { p -> EstudiListItem(p, estudiIsLoading, navController) }
    }


}

@Composable
fun EstudiListItem(estudi: Estudi, isLoading: Boolean, navController: NavController) {
    val context = LocalContext.current
    val clickableEnabled = !isLoading && estudi.name != ""

    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(enabled = clickableEnabled) {
                when {
                    estudi.totsFinalitzats && !estudi.teHistoric -> {
                        //expedient
                        val url = "${BASE_URL}/get_expedient.php" +
                                "?dni=${SessionData.dni}" +
                                "&cicle=${estudi.name}" +
                                "&token=${SessionData.token}"
                        baixarPDF(context, url, "expedient_${estudi.name}.pdf") { success ->
                            navController.navigate("expedientPDF/$success")
                        }
                    }
                    else -> {
                        //butlleti
                        navController.navigate("cursos/${estudi.name}")
                    }
                }
            }
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Spacer(Modifier.width(12.dp))
            Text(
                text = estudi.name,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
        }
    }
}

@Composable
fun StudiesScreen(navController: NavController, onSessionExpired: () -> Unit) {


    LaunchedEffect(Unit) {
        estudiState.clear()
        estudiState.addAll(EstudiList.placeholders())
        carregarEstudiDesDeServidor(SessionData.dni, navController, onSessionExpired)
    }

    Scaffold(modifier = Modifier.fillMaxWidth()) { inner ->
        Column(
            modifier = Modifier
                .padding(inner)
                .fillMaxSize()
                .padding(16.dp)
        ) {
            Text(
                text = stringResource(com.example.evalis.feature.expedient.R.string.estudi_label),
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold
            )
            Spacer(Modifier.height(20.dp))

            EstudisList(
                isLoading = estudiIsLoading,
                Estudi = estudiState,
                navController = navController
            )
        }
    }

}

private data class EstudiParsed(
    val name: String,
    val historic: List<Estudi>
)

private fun parsejarEstudis(obj: JSONObject): EstudiParsed {

    val name = obj.optString("actual")

    val historicArr = obj.optJSONArray("historic") ?: JSONArray()
    val historic = mutableListOf<Estudi>()

    for (i in 0 until historicArr.length()) {
        val t = historicArr.optJSONObject(i) ?: continue
        val cicleH = t.optString("cicleH")
        val totsFinalitzats = t.optBoolean("tots_finalitzats")
        val esActual = t.optBoolean("es_actual")
        if (cicleH.isNotBlank()) {
            historic.add(Estudi(cicleH, isHistoric = true, teHistoric = esActual, totsFinalitzats = totsFinalitzats))
        }
    }

    return EstudiParsed(name, historic)
}


private fun carregarEstudiDesDeServidor(dniAlumne: String,navController: NavController, onSessionExpired: () -> Unit) {
    estudiIsLoading = true
    Log.d("ESTUDI", "DNI: $dniAlumne")
    Log.d("ESTUDI", "Token: ${SessionData.token}")
    thread {
        try {
            val gestor = GestorSQLExternModern()
            val arr: JSONArray? = gestor.connectar("${BASE_URL}/get_estudis.php?dni=$dniAlumne&token=${SessionData.token}")

            Handler(Looper.getMainLooper()).post {

                if (arr == null && gestor.lastError == "Token expirado") {
                    onSessionExpired()
                    return@post
                }

                if (arr == null) {
                    estudiState.clear()
                    estudiState.add(Estudi("Sense connexió"))
                    estudiIsLoading = false
                    return@post
                }

                estudiState.clear()

                estudiState.clear()

                for (i in 0 until arr.length()) {
                    val obj = arr.getJSONObject(i)
                    val parsed = parsejarEstudis(obj)

                    // Cicle actual si no està al historic
                    val actualEsAlHistoric = parsed.historic.any { it.teHistoric }
                    if (!actualEsAlHistoric) {
                        estudiState.add(Estudi(parsed.name, isHistoric = false))
                    }

                    // Afegir historics
                    for (h in parsed.historic) {
                        estudiState.add(h)
                    }
                }


                if (estudiState.isEmpty()) {
                    estudiState.add(Estudi("No hi ha dades"))
                }

                estudiIsLoading = false
            }

        } catch (e: Exception) {
        }
    }
}



