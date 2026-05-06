# EVALIS — Backend API (PHP)

Backend en PHP para la plataforma académica **EVALIS**, utilizada por las aplicaciones Android y Desktop. Proporciona una API REST que devuelve datos en formato JSON y se conecta a una base de datos MariaDB mediante XAMPP.

---

## Configuración del entorno

- Servidor: XAMPP (Apache + MariaDB)
- Puerto BD: 3307
- Base de datos: `projecte_evalis`
- Usuario BD: `root` (sin contraseña)
- URL base del backend: `https://<IP_SERVIDOR>/`

---

## Funciones principales del backend

- Autenticación de usuarios con roles (alumno, profesor, tutor, directiva, administrador).
- Gestión de notas por RA/UF.
- Creación y cierre de períodos de evaluación.
- Generación y consulta de actas.
- Corrección de notas con registro histórico.
- Exportación de datos (CSV, logs).
- Consulta de expedientes, profesores y estudios.
- Seguridad mediante tokens de sesión y contraseñas con bcrypt.

---

## Endpoints principales (resumen)

### Autenticación
`login.php`  
Valida credenciales, genera token y devuelve datos del usuario.

### Notas
`notes.php`  
Consultar asignaturas, ver notas por grupo y guardar notas.

### Períodos
`periode.php`  
Abrir o cerrar trimestres (solo directiva/administración).

### Actas
`crear_acta.php`, `acta.php`, `nota_final.php`, `dades_acta.php`  
Crear actas, consultar notas, aplicar correcciones y obtener datos para PDF.

### Profesores
`fitxa_professor.php`, `lista_prof.php`, `orla.php`  
Consultar fichas, listados y datos para la orla.

### Exportaciones
`exportar_csv.php`, `export_logs.php`  
Exportación de alumnos y registros de login.

### Otros
`graduar_alumne.php`, `crear_password.php`, `get_expedient.php`, etc.

---

## Seguridad

- Contraseñas almacenadas con `password_hash()` (bcrypt).
- Tokens generados con `random_bytes()` y validados en cada petición.
- Consultas preparadas para evitar SQL injection.
- Roles verificados en endpoints sensibles.
- Recomendado usar HTTPS (certificado autofirmado en desarrollo).

---

## Cómo usar la aplicación (Android / Desktop)

### 1. Inicio de sesión
El usuario introduce su **nombre de usuario y contraseña**.  
El backend valida las credenciales y devuelve un **token de sesión**, que la app almacena para futuras peticiones.

### 2. Navegación según el rol
Cada usuario ve opciones distintas:

- **Alumno:** boletín, expediente, profesores, notificaciones.
- **Profesor:** grupos asignados, introducción de notas, actas.
- **Tutor / Directiva:** apertura/cierre de períodos, correcciones, estadísticas.
- **Administrador:** acceso ampliado a datos y exportaciones.

### 3. Consultas y acciones
La app realiza peticiones al backend enviando el **token**.  
Ejemplos:
- Ver asignaturas → `notes.php?accio=assignatures`
- Guardar nota → POST a `notes.php?accio=guardar`
- Obtener expediente → `get_expedient.php?nia=...`

### 4. Cierre de sesión
La app elimina el token local y el backend marca la sesión como finalizada.

