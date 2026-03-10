package com.example.evalis.navigation

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.runtime.Composable
import com.example.evalis.ui.screens.login.LoginScreen

import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.evalis.HomeScreen
import com.example.evalis.ThemeMode
import com.example.evalis.ui.screens.*
import com.example.evalis.ui.screens.login.RegisterScreen

@Composable
fun AppNavigation() {
    val navController = rememberNavController()

    NavHost(
        navController = navController,
        startDestination = "login"
    ) {
        composable("login") {
            LoginScreen(
                onRegister={navController.navigate("register")},
                onSuccess = { navController.navigate("home")}

            )
        }

        composable("home") {
            val initialMode = ThemeMode.SYSTEM

            HomeScreen(
                themeMode = initialMode,
                onThemeChange =
            )
        }

        composable("register") {
            RegisterScreen(
                onSuccess = { navController.navigate("login")}
            )
        }
    }
}
