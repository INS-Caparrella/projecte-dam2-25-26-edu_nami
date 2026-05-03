package com.example.evalis.ui.screens

import androidx.compose.runtime.Composable
import androidx.navigation.NavController
import com.example.evalis.ThemeMode
import com.example.evalis.ThemeSettings

@Composable
fun SettingsScreen(themeMode: ThemeMode, onThemeChange: (ThemeMode) -> Unit, navController: NavController) {
    ThemeSettings(selectedMode = themeMode, onModeSelected = onThemeChange)
}