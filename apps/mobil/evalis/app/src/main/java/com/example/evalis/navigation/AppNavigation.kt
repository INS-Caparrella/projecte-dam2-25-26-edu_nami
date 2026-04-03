package com.example.evalis.navigation

import androidx.compose.runtime.Composable
import com.example.evalis.ui.screens.login.LoginScreen

import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.evalis.ThemeMode
import com.example.evalis.ui.components.OptionsList
import com.example.evalis.ui.screens.*
import com.example.evalis.ui.screens.login.RegisterScreen

@Composable
fun AppNavigation(
    themeMode: ThemeMode,
    onThemeChange: (ThemeMode) -> Unit
) {
    val navController = rememberNavController()

    NavHost(
        navController = navController,
        startDestination = "login"
    ) {
        composable("login") {
            LoginScreen(
                onRegister={navController.navigate("register")},
                onSuccess = { navController.navigate("menu")}

            )
        }

        composable("menu") {
            val initialMode = ThemeMode.SYSTEM

            MenuScreen(
                themeMode = themeMode,
                onThemeChange = onThemeChange,
                option = OptionsList.all()
            )
        }

        composable("register") {
            RegisterScreen(
                onSuccess = { navController.navigate("login")}
            )
        }
    }
}
