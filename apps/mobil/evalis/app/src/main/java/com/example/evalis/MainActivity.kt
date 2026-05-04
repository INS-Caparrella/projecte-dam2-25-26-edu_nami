package com.example.evalis

import android.content.pm.PackageManager
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.example.evalis.ui.theme.EvalisTheme

import com.example.evalis.navigation.*
import android.os.*
import androidx.activity.*
import androidx.activity.compose.setContent
import androidx.annotation.RequiresApi
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.*
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import com.example.evalis.ui.components.NotificationHelper
import com.example.evalis.ui.components.Polling
import java.util.concurrent.TimeUnit

class MainActivity : ComponentActivity() {
    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Demana permis per a enviar notificacions
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (checkSelfPermission(android.Manifest.permission.POST_NOTIFICATIONS)
                != PackageManager.PERMISSION_GRANTED
            ) {
                requestPermissions(
                    arrayOf(android.Manifest.permission.POST_NOTIFICATIONS),
                    100
                )
            }
        }

        NotificationHelper.createNotificationChannel(this)


        val request = PeriodicWorkRequestBuilder<Polling>(15, TimeUnit.MINUTES).build()
        // Worker periódico (cada 15 min)
        val periodic = PeriodicWorkRequestBuilder<Polling>(15, TimeUnit.MINUTES).build()
        WorkManager.getInstance(this).enqueueUniquePeriodicWork(
            "polling_evalis",
            ExistingPeriodicWorkPolicy.UPDATE,
            periodic
        )

        // Worker inmediato para pruebas
        val immediate = OneTimeWorkRequestBuilder<Polling>().build()
        WorkManager.getInstance(this).enqueue(immediate)

        val prefs = getSharedPreferences("settings", MODE_PRIVATE)
        val savedMode = prefs.getString("theme_mode", ThemeMode.SYSTEM.name)
        val initialMode = ThemeMode.valueOf(savedMode!!)


        //Probar notificació
        getSharedPreferences("notifs", MODE_PRIVATE).edit().clear().apply()

        setContent {
            var themeMode by remember { mutableStateOf(initialMode) }

            val darkTheme = when (themeMode) {
                ThemeMode.LIGHT -> false
                ThemeMode.DARK -> true
                ThemeMode.SYSTEM -> isSystemInDarkTheme()
            }

            EvalisTheme(darkTheme = darkTheme) {
                AppNavigation(
                    themeMode = themeMode,
                    onThemeChange = {
                        themeMode = it
                        prefs.edit()
                            .putString("theme_mode", it.name)
                            .apply()
                    }

                )
            }
        }

    }
}

