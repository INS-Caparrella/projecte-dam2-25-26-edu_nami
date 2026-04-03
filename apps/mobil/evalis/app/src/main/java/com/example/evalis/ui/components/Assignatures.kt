package com.example.evalis.ui.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

import com.example.evalis.R
import com.example.evalis.ui.screens.AssigAlumne

@Composable
fun Assignatures(llista:List<AssigAlumne>){
    Column{
        Text(text= ("Assignatures"),fontWeight= FontWeight.Bold)
        HorizontalDivider(modifier = Modifier.padding(top=4.dp, bottom = 8.dp))
        llista.forEach { assignatura -> ItemTournament(assignatura) }
    }
}

@Composable
fun ItemTournament(assignatura: AssigAlumne){
    Row(horizontalArrangement = Arrangement.spacedBy(12.dp), verticalAlignment = Alignment.CenterVertically){

        Row(modifier= Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween){
            Text(text = assignatura.nom,fontWeight= FontWeight.SemiBold)
            Text(text=assignatura.aula)
        }

    }
}