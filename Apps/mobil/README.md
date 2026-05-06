# EVALIS — Aplicación Android (Kotlin)

Aplicación móvil para alumnos del sistema académico **EVALIS**, desarrollada en **Kotlin** con **Jetpack Compose**.  
Permite consultar expediente, boletines, profesores, estadísticas y recibir notificaciones, conectándose al backend PHP/MariaDB.

---

## 1. Funcionamiento general

EVALIS se compone de:

- **Base de datos**: almacena toda la información académica.
- **API REST en PHP**: gestiona autenticación, notas, expedientes y PDFs.
- **App Android**: interfaz para alumnos con acceso mediante token.

La app **no crea usuarios**. Los alumnos se registran automáticamente al ser añadidos a la base de datos.

---

## 2. Registro y autenticación

### Creación automática del usuario (trigger)

Cuando un alumno se inserta en la tabla **`persones`**, la base de datos ejecuta el trigger:

AFTER INSERT ON persones → generarUsuari

Este trigger:

- Crea un usuario en **`usuaris`**.
- Genera un **username único**.
- Deja la contraseña como **NULL**.
- El alumno **no puede iniciar sesión todavía**.

### Activación de la cuenta (Registro en la app)

En la pantalla de Login, el alumno usa **“Registrarse”**:

Debe introducir:

- **DNI**
- **Nueva contraseña**

El backend verifica que:

- El DNI existe en `usuaris`.
- La contraseña está NULL.

Si es correcto, guarda la nueva contraseña con **bcrypt** y activa la cuenta.

### Inicio de sesión

- La app envía un POST a `login.php`.
- Si es correcto, recibe un **token de 64 caracteres** (válido 10 horas).
- El token se guarda en `SessionData` y `SharedPreferences`.
- Todas las peticiones posteriores requieren token.

---

## 3. Funcionalidades principales

- Consulta del **perfil personal**.
- Lista de **profesores** del ciclo.
- Descarga de **boletines** y **expedientes** en PDF.
- Estadísticas académicas (gráficos).
- Subida de **foto de perfil** desde la cámara.
- Notificaciones de nuevos documentos.
- Tema claro/oscuro y soporte multilenguaje (CA/ES/EN/FR).

---

## 4. Arquitectura de la app

Modularización:

| Módulo | Contenido |
|--------|-----------|
| `core:domain` | Data classes |
| `core:data` | HTTP, SessionData, BASE_URL |
| `core:network` | UnsafeSSL |
| `feature:login` | Login y Registro |
| `feature:profs` | Profesores |
| `feature:expedient` | Expediente y boletines |
| `app` | Navegación y pantallas principales |

---

## 5. Endpoints utilizados (resumen)

- `login.php` — Autenticación  
- `crear_password.php` — Registro (activar cuenta)  
- `get_perfil.php` — Perfil del alumno  
- `get_profs.php` / `get_prof.php` — Profesores  
- `get_estudis.php` / `get_cursos.php` — Estudios y cursos  
- `get_butlleti.php` / `get_expedient.php` — PDFs  
- `pfp_mobil.php` — Subida de foto  
- `send_notifs.php` — Notificaciones  

---

## 6. Pantallas principales

- **Login / Registro**: activación de cuenta mediante DNI + contraseña nueva.  
- **Profesores**: lista filtrable con foto, email y asignaturas.  
- **Expediente y boletines**: descarga de PDFs generados en el servidor.  
- **Perfil**: datos personales y estadísticas con gráficos.  
- **Cámara**: captura, recorte y subida de foto (<300 KB).  
- **Notificaciones**: worker periódico que detecta nuevos documentos.

---

## 7. Temas 

- Tema claro, oscuro o seguir el sistema.  
