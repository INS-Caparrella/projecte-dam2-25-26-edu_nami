package com.example.evalis

import android.content.Intent
import android.os.Bundle
import android.text.style.URLSpan
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.text.input.InputTransformation.Companion.keyboardOptions
import androidx.compose.material3.Button
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ModifierLocalBeyondBoundsLayout
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.evalis.ui.theme.EvalisTheme
import org.json.JSONObject
import java.net.URLEncoder
import kotlin.concurrent.thread


class LoginActivity : ComponentActivity() {
    private var is_logged: Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            EvalisTheme {
                LoginScreen(

                    onSuccess = {
                        startActivity(Intent(this, HomeActivity::class.java))
                        is_logged = true
                        finish()
                    }
                )

            }
        }
    }

    @Composable
    fun LoginScreen(hardcodeuser: String, hardcodepass: String, onSuccess: () -> Unit) {
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
                Text("Login")

                OutlinedTextField(
                    value = user,
                    onValueChange = { user = it },
                    label = { Text("Usuari") },
                    singleLine = true,
                    keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next),
                    modifier = Modifier.fillMaxWidth()
                )
                OutlinedTextField(
                    value = pass,
                    onValueChange = { pass = it },
                    label = { Text("Contrasenya") },
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
                    modifier = Modifier.fillMaxWidth()

                )
                    Text("Entrar")
            }
        }
    }

    @Preview(showBackground = true, showSystemUi = true)
    @Composable
    fun PreviewLoginScreen() {
        EvalisTheme {
            LoginScreen(
                hardcodeuser = "admin",
                hardcodepass = "1234",
                onSuccess = {}
            )
        }
    }
}
@Composable
fun LoginButton(user:String, pass:String, onSuccess: () -> Unit, modifier: Modifier=Modifier){
    val context = LocalContext.current

    Button(
        modifier=modifier,
        onClick={
            val baseUrl = "https://192.168.1.39"
            val method="POST"

            val u= URLEncoder.encode(user, "UTF-8")
            val p= URLEncoder.encode(pass, "UTF-8")
            var url = ""
            val params="user=$u&pass=$p"

            if (method=="GET") {
                url = "$baseUrl/login.php?user=$u&pass=$p"
            }
            else if (method=="POST"){
                url = "$baseUrl/login.php"
            }
            thread {
                try {
                    UnsafeSSL.ignoreSSLErrors()
                    val gestor=GestorSQLExternModern()
                    val obj: JSONObject?=if(method=="GET"){
                        gestor.connectarObj(url)
                    } else {
                        gestor.connectarObjPOST(url, params)
                    }
                    (context as? ComponentActivity)?.runOnUiThread {
                        if (obj==null){
                            val missatgeError=gestor.lastError
                                ?: "sense resposta o error desconegut (revisa URL, port i JSON"

                            Toast.makeText(context,
                                "error en la connexió: $missatgeError",
                                Toast.LENGTH_LONG).show()
                        } else {
                            val potEntrar = obj.optBoolean("pot_entrar", false)
                            if (potEntrar){
                                onSuccess()
                            } else{
                                Toast.makeText(context,
                                    "usuari o contrasenya incorrectes", Toast.LENGTH_SHORT)
                                    .show()
                            }
                        }
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                    (context as? ComponentActivity)?.runOnUiThread {
                        Toast.makeText(context,
                            "error inesperat: ${e.message}",
                            Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }
    ) {
        Text("Entrar")
    }

}