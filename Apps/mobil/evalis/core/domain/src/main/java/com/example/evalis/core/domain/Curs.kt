package com.example.evalis.core.domain

data class Curs(
    val curs: String,
    val finalitzat: Boolean,
    val notaFinal: String?,
    val actual: Boolean,
    val dataInici: String,
    val dataFi: String?
)