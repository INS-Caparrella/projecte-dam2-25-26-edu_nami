plugins {
    alias(libs.plugins.android.library)

}

android {
    namespace = "com.example.evalis.core.domain"
    compileSdk = 35


    defaultConfig {
        minSdk = 24

    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }



}

dependencies {

}