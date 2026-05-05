package com.example.expedient.reports

import android.app.DownloadManager
import android.content.Context
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.util.Log
import java.io.File
import java.net.HttpURLConnection
import java.net.URL
import kotlin.concurrent.thread

fun baixarPDF(
    context: Context,
    url: String,
    fileName: String,
    onResult: (success: Boolean) -> Unit
) {
    thread {
        try {
            val connection = URL(url).openConnection() as HttpURLConnection
            connection.connectTimeout = 10000
            connection.readTimeout = 15000
            connection.connect()

            val responseCode = connection.responseCode
            Log.d("PDF", "Response code: $responseCode")
            Log.d("PDF", "Content-Type: ${connection.contentType}")  // <-- mira esto
            Log.d("PDF", "Content-Length: ${connection.contentLength}")

            if (responseCode != 200) {
                Handler(Looper.getMainLooper()).post { onResult(false) }
                return@thread
            }

            // Verifica que sea realmente un PDF
            if (!connection.contentType.contains("pdf")) {  // <-- si no es PDF, falla
                Log.e("PDF", "El servidor no devuelve un PDF: ${connection.contentType}")
                Handler(Looper.getMainLooper()).post { onResult(false) }

                // Justo después de comprobar el contentType, antes del return@thread
                val errorBody = connection.inputStream.bufferedReader().readText()
                Log.e("PDF", "Respuesta del servidor: $errorBody")

                return@thread
            }

            if (connection.responseCode != 200) {
                Handler(Looper.getMainLooper()).post { onResult(false) }
                return@thread
            }

            val downloadsDir = Environment.getExternalStoragePublicDirectory(
                Environment.DIRECTORY_DOWNLOADS
            )
            val file = File(downloadsDir, fileName)

            connection.inputStream.use { input ->
                file.outputStream().use { output ->
                    input.copyTo(output)
                }
            }

            val downloadManager = context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
            downloadManager.addCompletedDownload(
                fileName,
                "Expedient acadèmic",
                true,
                "application/pdf",
                file.absolutePath,
                file.length(),
                true
            )

            Handler(Looper.getMainLooper()).post { onResult(true) }

        } catch (e: Exception) {
            Log.e("PDF", "Error: ${e.message}")
            Handler(Looper.getMainLooper()).post { onResult(false) }
        }
    }
}