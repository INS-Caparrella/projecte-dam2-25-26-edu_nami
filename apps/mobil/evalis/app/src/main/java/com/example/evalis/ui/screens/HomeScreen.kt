package com.example.evalis.ui.screens

import android.content.Context.MODE_PRIVATE
import androidx.activity.compose.setContent
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
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
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.example.evalis.R
import com.example.evalis.ThemeMode
import com.example.evalis.ThemeOption
import com.example.evalis.ThemeSettings
import androidx.compose.ui.focus.focusModifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewScreenSizes
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.evalis.R
import com.example.evalis.ui.theme.EvalisTheme

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

        ThemeOption(
            stringResource(R.string.tema_claro),
            ThemeMode.LIGHT,
            selectedMode,
            onModeSelected
        )
        ThemeOption(stringResource(R.string.tema_oscuro), ThemeMode.DARK, selectedMode, onModeSelected)
        ThemeOption(stringResource(R.string.tema_sistema), ThemeMode.SYSTEM, selectedMode, onModeSelected)

    }
fun HomeScreen() {

    val navController = rememberNavController()
    val drawerState = rememberDrawerState(initialValue = DrawerValue.Closed)
    val scope = rememberCoroutineScope()

    ModalNavigationDrawer(
        drawerState = drawerState,
        drawerContent = {
            ModalDrawerSheet {
                NavigationDrawerItem(
                    label = { Text(stringResource(R.string.inicio))  },
                    selected = false,
                    onClick = {
                        navController.navigate("home")
                        scope.launch { drawerState.close() }
                    }
                )
                NavigationDrawerItem(
                    label = { Text(stringResource(R.string.favoritos)) },
                    selected = false,
                    onClick = {
                        navController.navigate("favorites")
                        scope.launch { drawerState.close() }
                    }
                )
                NavigationDrawerItem(
                    label = { Text(stringResource(R.string.perfil)) },
                    selected = false,
                    onClick = {
                        navController.navigate("profile")
                        scope.launch { drawerState.close() }
                    }
                )
            }
        }
    ) {
        Scaffold(
            topBar = {
                TopAppBar(
                    title = { Text(stringResource(R.string.menu)) },
                    navigationIcon = {
                        IconButton(onClick = {
                            scope.launch { drawerState.open() }
                        }) {
                            Icon(Icons.Default.Menu, contentDescription = "Menu")
                        }
                    }
                )
            }
        ) { padding ->

            NavHost(
                navController = navController,
                startDestination = "home",
                modifier = Modifier.padding(padding)
            ) {
                composable("home") { HomeScreen() }

            }
        }
    }
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

fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = stringResource(R.string.saludo, name),
        modifier = modifier
    )
}

@Preview(name="Phone", showBackground = true, device="spec:width=411dp,height=891dp,dpi=420")
@Composable
fun HomeScreen(themeMode: ThemeMode, onThemeChange: (ThemeMode) -> Unit) {


    val darkTheme = when (themeMode) {
        ThemeMode.LIGHT -> false
        ThemeMode.DARK -> true
        ThemeMode.SYSTEM -> isSystemInDarkTheme()
    }


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