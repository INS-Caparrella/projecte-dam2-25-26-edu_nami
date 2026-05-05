package com.example.expedient

import android.os.Handler
import android.os.Looper
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.evalis.core.data.GestorSQLExternModern
import com.example.evalis.core.data.GestorSQLExternModern.SqlInfo.BASE_URL
import com.example.evalis.core.data.SessionData
import com.example.evalis.core.domain.Curs
import com.example.expedient.reports.baixarPDF
import java.net.URLEncoder
import kotlin.concurrent.thread

val cursosState = mutableStateListOf<Curs>()
var cursosIsLoading by mutableStateOf(true)
var cursosNomAlumne by mutableStateOf("")

@Composable
fun CursosScreen(cicle: String, navController: NavController, onSessionExpired: () -> Unit) {

    LaunchedEffect(cicle) {
        cursosState.clear()
        cursosIsLoading = true
        carregarCursosDesDeServidor(cicle, navController, onSessionExpired)
    }

    Scaffold(modifier = Modifier.fillMaxWidth()) { inner ->
        Column(
            modifier = Modifier
                .padding(inner)
                .fillMaxSize()
                .padding(16.dp)
        ) {
            Text(
                text = cicle,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold
            )
            if (cursosNomAlumne.isNotEmpty()) {
                Text(
                    text = cursosNomAlumne,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
            Spacer(Modifier.height(20.dp))

            if (cursosIsLoading) {
                CircularProgressIndicator(modifier = Modifier.align(Alignment.CenterHorizontally))
            } else {
                LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    items(cursosState) { curs ->
                        CursCard(curs = curs, cicle = cicle, navController = navController)
                    }
                }
            }
        }
    }
}

@Composable
fun CursCard(curs: Curs, cicle: String, navController: NavController) {
    val context = LocalContext.current

    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(
                text = curs.curs,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
            Spacer(Modifier.height(4.dp))

            when {
                curs.actual -> {
                    Text(
                        text = "En curs",
                        color = Color(0xFF2196F3),
                        style = MaterialTheme.typography.bodyMedium
                    )
                }
                curs.finalitzat -> {
                    Text(
                        text = "Finalitzat · Nota: ${curs.notaFinal ?: "-"}",
                        color = Color(0xFF4CAF50),
                        style = MaterialTheme.typography.bodyMedium
                    )
                    Spacer(Modifier.height(8.dp))
                    // En CursCard, canvia el botó:
                    Button(onClick = {
                        val url = "${BASE_URL}/get_butlleti.php" +  // era get_expedient.php
                                "?dni=${SessionData.dni}" +
                                "&cicle=${URLEncoder.encode(cicle, "UTF-8")}" +
                                "&data_inici=${curs.dataInici}" +
                                "&token=${SessionData.token}"
                        baixarPDF(context, url, "butlleti_${cicle}_${curs.curs}.pdf") { success ->
                            navController.navigate("expedientPDF/$success")
                        }
                    }) {
                        Text("Baixar butlletí")  // era "Baixar expedient"
                    }
                }
                else -> {
                    Text(
                        text = "Incomplet",
                        color = Color(0xFFF44336),
                        style = MaterialTheme.typography.bodyMedium
                    )
                }
            }
        }
    }
}

private fun carregarCursosDesDeServidor(
    cicle: String,
    navController: NavController,
    onSessionExpired: () -> Unit
) {
    thread {
        try {
            val gestor = GestorSQLExternModern()
            val url = "${BASE_URL}/get_cursos.php" +
                    "?dni=${SessionData.dni}" +
                    "&cicle=${URLEncoder.encode(cicle, "UTF-8")}" +
                    "&token=${SessionData.token}"

            val obj = gestor.connectarObj(url)

            Handler(Looper.getMainLooper()).post {
                if (obj == null && gestor.lastError == "Token expirado") {
                    onSessionExpired()
                    return@post
                }

                if (obj == null) {
                    cursosIsLoading = false
                    return@post
                }

                cursosNomAlumne = obj.optString("nom")

                val cursosArr = obj.optJSONArray("cursos")
                cursosState.clear()

                if (cursosArr != null) {
                    for (i in 0 until cursosArr.length()) {
                        val c = cursosArr.getJSONObject(i)
                        cursosState.add(
                            Curs(
                                curs = c.optString("curs"),
                                finalitzat = c.optBoolean("finalitzat"),
                                notaFinal = if (c.isNull("nota_final")) null else c.optString("nota_final"),
                                actual = c.optBoolean("actual"),
                                dataInici = c.optString("data_inici"),
                                dataFi = if (c.isNull("data_fi")) null else c.optString("data_fi")
                            )
                        )
                    }
                }

                cursosIsLoading = false
            }
        } catch (e: Exception) {
            Handler(Looper.getMainLooper()).post {
                cursosIsLoading = false
            }
        }
    }
}