package com.example.evalis.feature.login

import android.widget.Toast
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
import androidx.compose.ui.unit.dp
import com.example.evalis.core.data.GestorSQLExternModern
import com.example.network.UnsafeSSL
import org.json.JSONObject
import java.net.URLEncoder
import kotlin.concurrent.thread

@Composable
fun RegisterScreen(onSuccess: () -> Unit) {
    var dni by remember { mutableStateOf("") }
    var pass by remember { mutableStateOf("") }

    Box(
        modifier = Modifier.fillMaxSize().padding(24.dp)
    ) {
        Column(
            modifier = Modifier.fillMaxWidth().align(Alignment.TopCenter),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(stringResource(R.string.reg_button))

            OutlinedTextField(
                value = dni,
                onValueChange = { dni = it },
                label = { Text("DNI") },
                singleLine = true,
                keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next),
                modifier = Modifier.fillMaxWidth().padding(top = 15.dp)
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

            RegisterButton(
                pass = pass,
                dni = dni,
                onSuccess = onSuccess,
                modifier = Modifier.fillMaxWidth()
            )
        }
    }
}

// Preview eliminado — EvalisTheme está en :app, no accesible desde feature:login

@Composable
fun RegisterButton(
    dni: String,
    pass: String,
    onSuccess: () -> Unit,
    modifier: Modifier = Modifier
) {
    val context = LocalContext.current
    val BASE_URL = GestorSQLExternModern.SqlInfo.BASE_URL

    Button(
        modifier = modifier,
        onClick = {
            val d = URLEncoder.encode(dni, "UTF-8")
            val p = URLEncoder.encode(pass, "UTF-8")
            val url = "${BASE_URL}/crear_password.php"
            val params = "dni=$d&password=$p"

            thread {
                try {
                    UnsafeSSL.ignoreSSLErrors()
                    val gestor = GestorSQLExternModern()
                    val obj: JSONObject? = gestor.connectarObjPOST(url, params)

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
                            if (potEntrar) {
                                onSuccess()
                                Toast.makeText(
                                    context,
                                    context.getString(R.string.user_reg), // ← fix: getString()
                                    Toast.LENGTH_SHORT
                                ).show()
                            } else {
                                Toast.makeText(
                                    context,
                                    context.getString(R.string.error_reg1), // ← fix: getString()
                                    Toast.LENGTH_SHORT
                                ).show()
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
        Text(stringResource(R.string.reg_button))
    }
}