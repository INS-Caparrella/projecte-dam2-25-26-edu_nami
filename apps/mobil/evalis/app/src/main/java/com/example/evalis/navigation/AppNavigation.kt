package com.example.evalis.navigation

import androidx.compose.runtime.Composable
import com.example.evalis.ui.screens.HomeScreen
import com.example.evalis.ui.screens.login.LoginScreen

import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.evalis.ui.screens.HomeScreen
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
            HomeScreen()
        }

        composable("register") {
            RegisterScreen(
                onSuccess = { navController.navigate("login")}
            )
        }
    }
}
