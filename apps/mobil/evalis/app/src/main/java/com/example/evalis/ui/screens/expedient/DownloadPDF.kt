package com.example.evalis.ui.screens.expedient

import android.content.Context
import android.os.Environment
import android.os.Looper
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

            if (connection.responseCode != 200) {
                android.os.Handler(Looper.getMainLooper()).post { onResult(false) }
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

            val downloadManager = context.getSystemService(Context.DOWNLOAD_SERVICE) as android.app.DownloadManager
            downloadManager.addCompletedDownload(
                fileName,
                "Expedient acadèmic",
                true,
                "application/pdf",
                file.absolutePath,
                file.length(),
                true
            )

            android.os.Handler(Looper.getMainLooper()).post { onResult(true) }

        } catch (e: Exception) {
            android.util.Log.e("PDF", "Error: ${e.message}")
            android.os.Handler(Looper.getMainLooper()).post { onResult(false) }
        }
    }
}