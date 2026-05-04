package com.example.evalis.ui.components

import android.content.Context
import android.content.pm.PackageInstaller
import android.util.Log
import androidx.work.Worker
import androidx.work.WorkerParameters
import androidx.work.ListenableWorker.Result
import com.example.evalis.model.GestorSQLExternModern.SqlInfo.BASE_URL
import com.example.evalis.ui.screens.login.SessionData
import java.net.URL

class Polling(appContext: Context, params: WorkerParameters) :
    Worker(appContext, params) {


    override fun doWork(): Result {

        val prefs = applicationContext.getSharedPreferences("notifs", Context.MODE_PRIVATE)
        val yaBoletin = prefs.getBoolean("boletin_notificado", false)
        val yaExpediente = prefs.getBoolean("expediente_notificado", false)

        val nia = applicationContext
            .getSharedPreferences("session", Context.MODE_PRIVATE)
            .getInt("nia", -1)

        if (nia == -1) return Result.success()

        val url = URL("${BASE_URL}/send_notifs.php?nia=$nia")

        val respuesta = url.readText()

        when (respuesta) {
            "butlleti" -> {
                if (!yaBoletin) {
                    NotificationHelper.mostrar(
                        applicationContext,
                        "Nuevo boletín disponible",
                        "Ya puedes descargar tu boletín"
                    )
                    prefs.edit().putBoolean("boletin_notificado", true).apply()
                }
            }

            "expedient" -> {
                if (!yaExpediente) {
                    NotificationHelper.mostrar(
                        applicationContext,
                        "Expediente disponible",
                        "Tu expediente académico ya está listo"
                    )
                    prefs.edit().putBoolean("expediente_notificado", true).apply()
                }
            }
        }
        android.util.Log.d("Polling", "Worker ejecutado, respuesta: $respuesta")

        return Result.success()
    }
}
