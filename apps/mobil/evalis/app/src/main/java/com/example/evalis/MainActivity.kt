package com.example.evalis

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
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.*

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


        val prefs = getSharedPreferences("settings", MODE_PRIVATE)
        val savedMode = prefs.getString("theme_mode", ThemeMode.SYSTEM.name)
        val initialMode = ThemeMode.valueOf(savedMode!!)

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

