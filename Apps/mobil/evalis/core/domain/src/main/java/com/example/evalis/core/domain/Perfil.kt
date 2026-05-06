package com.example.evalis.core.domain

data class Perfil(
    val nom: String,
    val cognom: String,
    val dataNaix: String,
    val email: String,
    val telefon: String,
    val poblacio: String,
    val rutaFoto: String,
    val nomGrup: String,
    val nomCicle: String,
    val grado: String,
    val treballant: Boolean,
    val empresa: String
)