package com.example.evalis

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
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountBox
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Home
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.evalis.ui.components.Option
import com.example.evalis.ui.components.OptionsListItem


enum class ThemeMode {
    LIGHT, DARK, SYSTEM
}


enum class AppDestinations(
    val label: String,
    val icon: ImageVector,
) {
    HOME("Home", Icons.Default.Home),
    FAVORITES("Favorites", Icons.Default.Favorite),
    PROFILE("Profile", Icons.Default.AccountBox),
}

@Composable
fun HomeScreen(themeMode: ThemeMode, onThemeChange: (ThemeMode) -> Unit, options:List<Option>, navController: NavController) {

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
    ) {

        Text(
            modifier = Modifier.padding(24.dp),
            text=stringResource(R.string.login_aviso),
        )

        LazyColumn(verticalArrangement = Arrangement.spacedBy(10.dp)) {
            items(options){ op-> OptionsListItem(op, navController) }
        }

        Spacer(modifier = Modifier.height(24.dp))

        ThemeSettings(
            selectedMode = themeMode,
            onModeSelected = onThemeChange
        )

        Spacer(modifier = Modifier.height(24.dp))


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



