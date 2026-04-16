package com.example.evalis.ui.screens.login

import android.content.Intent
import android.widget.Toast
import androidx.compose.ui.res.stringResource

import androidx.activity.ComponentActivity
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Button
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.evalis.GestorSQLExternModern
import com.example.evalis.R
import com.example.evalis.UnsafeSSL
import com.example.evalis.ui.theme.EvalisTheme
import org.json.JSONObject
import java.net.URLEncoder
import kotlin.concurrent.thread
import kotlin.jvm.java

object SessionData {
    var dni: String =""
    var token:String=""
}


@Composable
fun LoginScreen(  onRegister: () -> Unit,
                  onSuccess: () -> Unit) {

    var user by remember { mutableStateOf("") }
    var pass by remember { mutableStateOf("") }


    Box(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .align(Alignment.TopCenter),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        )
        {
            Text(
                text = stringResource(R.string.login_label)
            )

            OutlinedTextField(
                value = user,
                onValueChange = { user = it },
                label = { Text(stringResource(R.string.user_label)) },
                singleLine = true,
                keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next),
                modifier = Modifier.fillMaxWidth()
            )
            OutlinedTextField(
                value = pass,
                onValueChange = { pass = it },
                label = { Text(stringResource(R.string.pass_label)) },
                singleLine = true,
                visualTransformation = PasswordVisualTransformation(),
                keyboardOptions = KeyboardOptions(
                    keyboardType = KeyboardType.Password,
                    imeAction = ImeAction.Done
                ),
                modifier = Modifier.fillMaxWidth()
            )
            val context = LocalContext.current
            LoginButton(
                user = user,
                pass = pass,
                onSuccess = onSuccess,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 15.dp)
            )


            Button(
                onClick = { onRegister() },
                modifier = Modifier
                    .fillMaxWidth(),
                enabled = true
            ) {
                Text(
                    text = stringResource(R.string.reg_button)
                )
            }


        }
    }
}


@Composable
fun LoginButton(user: String, pass: String, onSuccess: () -> Unit, modifier: Modifier = Modifier) {
    val context = LocalContext.current

    Button(
        modifier = modifier,
        onClick = {
            val baseUrl = "https://192.168.1.15" //cambiar cada que se reinicie el pc
            val method = "POST"

            val u = URLEncoder.encode(user, "UTF-8")
            val p = URLEncoder.encode(pass, "UTF-8")
            var url = ""
            val params = "username=$u&password=$p"

            if (method == "GET") {
                url = "$baseUrl/login.php?username=$u&password=$p"
            } else if (method == "POST") {
                url = "$baseUrl/login.php"
            }
            thread {
                try {
                    UnsafeSSL.ignoreSSLErrors()
                    val gestor = GestorSQLExternModern()
                    val obj: JSONObject? = if (method == "GET") {
                        gestor.connectarObj(url)
                    } else {
                        gestor.connectarObjPOST(url, params)
                    }
                    (context as? ComponentActivity)?.runOnUiThread {
                        if (obj == null) {
                            val missatgeError = gestor.lastError
                                ?: context.getString(R.string.error_aviso1)

                            Toast.makeText(
                                context,
                                context.getString(R.string.error_aviso2, missatgeError),
                                Toast.LENGTH_LONG
                            ).show()
                        } else {
                            val potEntrar = obj.optBoolean("pot_entrar", false)
                            SessionData.dni = obj.optString("dni")
                            SessionData.token = obj.optString("token")


                            if (potEntrar) {
                                onSuccess()
                            } else {
                                Toast.makeText(
                                    context,
                                    context.getString(R.string.error_aviso3), Toast.LENGTH_SHORT
                                )
                                    .show()
                            }
                        }
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                    (context as? ComponentActivity)?.runOnUiThread {
                        Toast.makeText(
                            context,
                            context.getString(R.string.error_aviso4, e.message),
                            Toast.LENGTH_SHORT
                        ).show()
                    }
                }
            }
        }
    ) {
        Text(
            text = (stringResource(R.string.login_label))

        )
    }

}

//@Preview(showBackground = true, showSystemUi = true)
//@Composable
//fun PreviewLoginScreen() {
//    EvalisTheme {
//        LoginScreen {}
//    }
//}
