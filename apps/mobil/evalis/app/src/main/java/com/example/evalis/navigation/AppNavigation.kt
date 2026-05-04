package com.example.evalis.navigation

import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import com.example.evalis.ui.screens.login.LoginScreen
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.evalis.HomeScreen
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
                onRegister = { navController.navigate("register") },
                onSuccess = { navController.navigate("menu") }
            )
        }

        composable("menu") {
            MenuScreen(
                themeMode = themeMode,
                onThemeChange = onThemeChange,
                option = OptionsList.all(),
                onLogout = {
                    navController.navigate("login") {
                        popUpTo("login") { inclusive = true }
                    }
                }
            )
        }

        composable("register") {
            RegisterScreen(
                onSuccess = {
                    navController.navigate("login") {
                        popUpTo("login") { inclusive = true }
                    }
                }
            )
        }

        composable("settings") {
            SettingsScreen(themeMode, onThemeChange, navController)
        }

        composable("home") {
            HomeScreen(
                themeMode = themeMode,
                onThemeChange = onThemeChange,
                options = OptionsList.all(),
                navController = navController
            )
        }

        composable("estudi") {
            EstudiScreen(navController = navController, onSessionExpired = {
                navController.navigate("login"){
                    popUpTo("login"){inclusive=true}
                }
            })
        }

        composable("profs") {
            ProfsScreen(
                navController = navController,
                onSessionExpired = { navController.navigate("login") {
                    popUpTo("login") { inclusive = true }
                }}
            )
        }

        composable("profDetail/{profId}/{dni}") { backStackEntry ->
            val profId = backStackEntry.arguments?.getString("profId") ?: ""
            val dni = backStackEntry.arguments?.getString("dni") ?: ""
            Text("Prof Detail: $profId - DNI: $dni")
        }
    }
}