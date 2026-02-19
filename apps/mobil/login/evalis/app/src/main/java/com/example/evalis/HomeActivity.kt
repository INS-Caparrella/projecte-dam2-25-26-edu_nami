package com.example.evalis

import android.R.style.Theme
import android.content.res.Resources
import android.os.Bundle
import android.provider.MediaStore
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ModifierLocalBeyondBoundsLayout
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.LineHeightStyle
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.evalis.ui.theme.EvalisTheme
import java.nio.file.WatchEvent

enum class ThemeMode{
    LIGHT, DARK, SYSTEM
}

class HomeActivity : ComponentActivity() {

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

            EvalisTheme(darkTheme = darkTheme){
                HomeScreen(
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


    @Composable
    fun ThemeSettings(selectedMode: ThemeMode, onModeSelected:(ThemeMode)-> Unit
    ) {
        Column(
            modifier = Modifier.fillMaxSize()
                .padding(24.dp)
        ) {
            Text(
            text = stringResource(R.string.tema_app),
                style = MaterialTheme.typography.titleLarge
            )
            Spacer(modifier = Modifier.height(16.dp))

            ThemeOption(stringResource(R.string.tema_claro), ThemeMode.LIGHT, selectedMode, onModeSelected)
            ThemeOption(stringResource(R.string.tema_oscuro), ThemeMode.DARK, selectedMode, onModeSelected)
            ThemeOption(stringResource(R.string.tema_sistema), ThemeMode.SYSTEM, selectedMode, onModeSelected)

        }
    }

    @Composable
    fun ThemeOption(text: String, mode: ThemeMode, selectedMode: ThemeMode, onModeSelected: (ThemeMode) -> Unit){
        Row(
           modifier = Modifier.fillMaxWidth()
               .clickable() { onModeSelected(mode) }
               .padding(vertical = 8.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            RadioButton(
                selected = (mode == selectedMode),
                onClick = { onModeSelected(mode) }
            )
            Spacer(modifier = Modifier.width(8.dp))

            Text(text = text)
        }
    }
    @Composable
    fun HomeScreen(themeMode: ThemeMode, onThemeChange: (ThemeMode) -> Unit) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(24.dp),
        ) {
            Text(stringResource(R.string.login_aviso))

            Spacer(modifier = Modifier.height(24.dp))

            ThemeSettings(
                selectedMode = themeMode,
                onModeSelected = onThemeChange
            )
        }
    }