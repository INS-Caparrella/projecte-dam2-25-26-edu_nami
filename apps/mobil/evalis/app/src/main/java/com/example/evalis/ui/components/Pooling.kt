package com.example.evalis.ui.components

import android.Manifest
import android.content.Context
import android.util.Log
import androidx.annotation.RequiresPermission
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.example.evalis.core.data.GestorSQLExternModern.SqlInfo.BASE_URL
import com.example.network.UnsafeSSL
import java.net.URL

class Polling(appContext: Context, params: WorkerParameters) : Worker(appContext, params) {

    @RequiresPermission(Manifest.permission.POST_NOTIFICATIONS)
    override fun doWork(): Result {
        val nia = applicationContext
            .getSharedPreferences("session", Context.MODE_PRIVATE)
            .getInt("nia", -1)

        if (nia == -1) {
            Log.d("Polling", "NIA no trobat, skip")
            return Result.success()
        }

        return try {
            UnsafeSSL.ignoreSSLErrors()
            val resposta = URL("${BASE_URL}/send_notifs.php?nia=$nia").readText().trim()
            Log.d("Polling", "NIA=$nia resposta=$resposta")

            when (resposta) {
                "butlleti" -> NotificationHelper.mostrar(
                    applicationContext,
                    "Nou butlletí disponible",
                    "Ja pots descarregar el teu butlletí"
                )
                "expedient" -> NotificationHelper.mostrar(
                    applicationContext,
                    "Expedient disponible",
                    "El teu expedient acadèmic ja està llest"
                )
                else -> Log.d("Polling", "Sense novetats: $resposta")
            }
            Result.success()
        } catch (e: Exception) {
            Log.e("Polling", "Error: ${e.message}")
            Result.failure()
        }
    }
}