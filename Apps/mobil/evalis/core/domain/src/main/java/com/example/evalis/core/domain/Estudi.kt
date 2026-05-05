package com.example.evalis.core.domain

data class Estudi(
    val name: String,
    val isHistoric: Boolean = false,
    val teHistoric: Boolean = false,
    val totsFinalitzats: Boolean = false
)
