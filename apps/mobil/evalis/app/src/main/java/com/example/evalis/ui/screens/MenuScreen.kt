package com.example.evalis.ui.screens

import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountBox
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material3.DrawerValue
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ModalDrawerSheet
import androidx.compose.material3.ModalNavigationDrawer
import androidx.compose.material3.NavigationDrawerItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.*
import androidx.compose.material3.rememberDrawerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.evalis.HomeScreen
import com.example.evalis.ThemeMode
import com.example.evalis.ui.components.Option
import kotlinx.coroutines.launch


//@PreviewScreenSizes
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MenuScreen(themeMode: ThemeMode, option: (List<Option>), onThemeChange: (ThemeMode) -> Unit) {

    val navController = rememberNavController()
    val drawerState = rememberDrawerState(initialValue = DrawerValue.Closed)
    val scope = rememberCoroutineScope()


    ModalNavigationDrawer(
        drawerState = drawerState,
        drawerContent = {
            ModalDrawerSheet {
                NavigationDrawerItem(
                    label = { Text("Home") },
                    selected = false,
                    onClick = {
                        navController.navigate("home")
                        scope.launch { drawerState.close() }
                    }
                )
                NavigationDrawerItem(
                    label = { Text("Favorites") },
                    selected = false,
                    onClick = {
                        navController.navigate("favorites")
                        scope.launch { drawerState.close() }
                    }
                )
                NavigationDrawerItem(
                    label = { Text("Profile") },
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
                    title = { Text("Menu") },
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
                composable("home") { HomeScreen(themeMode, onThemeChange, options= option,navController)}
                composable("favorites") { Text("Favorites") }
                composable("profile") { Text("Profile") }
                composable("profs") { ProfsScreen(navController) }
                composable("profDetail/{profId}/{dni}") { backStackEntry ->
                    val profId = backStackEntry.arguments?.getString("profId") ?: ""
                    val dni = backStackEntry.arguments?.getString("dni") ?: ""
                    ProfsDetail(
                        dni = dni,
                        profId = profId,
                        onClose = { navController.popBackStack() }
                    )
                }



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
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

//@Preview(name="Phone", showBackground = true, device="spec:width=411dp,height=891dp,dpi=420")
//@Composable
//fun PreviewPhone(){
//    EvalisTheme() {
//
//    }
//}

//@Preview(name="Tablet", showBackground = true, device = "spec:width=1280dp,height=800dp,dpi=240")
//@Composable
//fun PreviewTablet(){
//    FragmentsTheme {
//        FragmentsApp()
//    }
//}

