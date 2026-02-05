package com.example.fragments

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
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
import androidx.compose.material3.adaptive.navigationsuite.NavigationSuiteScaffold
import androidx.compose.material3.adaptive.navigationsuite.NavigationSuiteType
import androidx.compose.material3.rememberDrawerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.focusModifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewScreenSizes
import com.example.fragments.ui.theme.FragmentsTheme
import kotlinx.coroutines.launch



class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            FragmentsTheme {
                FragmentsApp()
            }
        }
    }
}

//@PreviewScreenSizes
@Composable
fun FragmentsApp() {
    val drawerState= rememberDrawerState(initialValue = DrawerValue.Closed)
    val scope= rememberCoroutineScope()

    val isPhone= LocalConfiguration.current.screenHeightDp<600
    var currentDestination by rememberSaveable { mutableStateOf(AppDestinations.HOME) }

    if (isPhone) {
        ModalNavigationDrawer(
            drawerState = drawerState,
            drawerContent = {
                ModalDrawerSheet {
                    AppDestinations.entries.forEach { dest ->
                        NavigationDrawerItem(
                            icon = { Icon(dest.icon, contentDescription = dest.label) },
                            label = { Text(dest.label) },
                            selected = dest == currentDestination,
                            onClick = {
                                currentDestination = dest
                                scope.launch { drawerState.close() }
                            }
                        )
                    }
                }
            }
        ) {
            Scaffold(
            modifier = Modifier.fillMaxSize(),
            topBar = {
                TopAppBar(
                    title = { Text(currentDestination.label)},
                    navigationIcon = {
                        IconButton(onClick = {
                            scope.launch { drawerState.open() } })
                        {
                            Icon(Icons.Default.Menu, contentDescription = "Menu")
                        }
                    }
                )
            }
        ) {
            innerPadding ->
            Greeting(
                name="Android",
                modifier = Modifier.padding(innerPadding)
            )
        }
    }
 } else {
     NavigationSuiteScaffold(
         layoutType = NavigationSuiteType.NavigationDrawer,
         navigationSuiteItems = {
             AppDestinations.entries.forEach {
                 item(
                     icon = {
                         Icon(
                             it.icon,
                             contentDescription = it.label
                         )
                     },
                     label = { Text(it.label) },
                     selected = it == currentDestination,
                     onClick = { currentDestination = it }

                 )
             }
         }
     )
    }
    NavigationSuiteScaffold(
        layoutType = NavigationSuiteType.NavigationDrawer,
        navigationSuiteItems = {
            AppDestinations.entries.forEach {
                item(
                    icon = {
                        Icon(
                            it.icon,
                            contentDescription = it.label
                        )
                    },
                    label = { Text(it.label) },
                    selected = it == currentDestination,
                    onClick = { currentDestination = it }
                )
            }
        }
    ) {
        Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
            Greeting(
                name = "Android",
                modifier = Modifier.padding(innerPadding)
            )
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

@Preview(name="Phone", showBackground = true, device="spec:width=411dp,height=891dp,dpi=420")
@Composable
fun PreviewPhone(){
    FragmentsTheme {
        FragmentsApp()
    }
}

//@Preview(name="Tablet", showBackground = true, device = "spec:width=1280dp,height=800dp,dpi=240")
//@Composable
//fun PreviewTablet(){
//    FragmentsTheme {
//        FragmentsApp()
//    }
//}

