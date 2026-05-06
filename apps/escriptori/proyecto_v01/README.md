# EVALIS — Aplicación de escritorio (VB.NET)

Aplicación Windows Forms desarrollada en VB.NET (.NET 8) para la gestión académica del sistema **EVALIS**. Se comunica con el backend PHP mediante peticiones HTTP/HTTPS y muestra la información según el rol del usuario autenticado.

---

## Requisitos

- .NET 8 (Windows)
- NuGet packages:
  - `Newtonsoft.Json` — parseo de JSON
  - `PuppeteerSharp` — generación de PDFs (descarga Chromium en la primera ejecución, ~150 MB)
  - `MySqlConnector` — importado pero no usado directamente (la BD se accede vía PHP)
- Servidor XAMPP activo con la API PHP en `https://192.168.1.134`

---

## Estructura del proyecto

```
proyecto_v01/
├── LogIn/
│   ├── LogIn.vb              — Formulario de login
│   └── UnsafeSSL.vb          — Cliente HTTP que ignora certificados autofirmados
├── Conexion/
│   └── BaseUrl.vb            — URLs centralizadas de todos los endpoints
├── Notas/
│   ├── FormNotas.vb          — Pantalla principal de introducción de notas
│   ├── AbrirEvaluacion.vb    — Gestión de períodos de evaluación (abrir/cerrar trimestres)
│   ├── SeleccionarAsignatura.vb — Diálogo para elegir asignatura (y grupo si es admin)
│   └── GestorGraduacion.vb   — Lógica de graduación de alumnos
├── Archivos/
│   ├── CargarFotos.vb        — Descarga fotos desde el servidor y las muestra en PictureBox
│   ├── ConstruirHtml.vb      — Convierte HTML a PDF usando PuppeteerSharp
│   ├── GenerarActaPDF.vb     — Genera el PDF del acta de evaluación
│   ├── ExportarCSV.vb        — Exporta la lista de alumnos de un grupo a .csv
│   ├── ExportarJSON.vb       — Exporta el listado de profesores a .json
│   └── ExportarXML.vb        — Exporta el registro de logins a .xml
├── FormPrincipal.vb          — Ventana principal con menú lateral por iconos
├── FormFicha.vb              — Ficha de profesor con datos según nivel de acceso
└── OrlaProfesores.vb         — Orla visual de todos los profesores del centro
```

---

## Clases principales

### `LogIn` + `LoginResult`
Formulario de autenticación. Realiza un POST a `login.php` y construye un objeto `LoginResult` con todos los datos del usuario:

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `canEnter` | Boolean | Si las credenciales son válidas |
| `dni` | String | DNI del usuario |
| `rol` | String | `professor`, `director`, `administrador` |
| `rolDirectiva` | String | Rol en la directiva (`Cap d'estudis`, etc.) |
| `name` / `surname` | String | Nombre y apellidos |
| `rutaFoto` | String | Ruta relativa de la foto (`img/profs/prof01.png`) |
| `grup` | String | Grupo asignado (si es profesor con un solo grupo) |
| `grups` | List(Of String) | Todos los grupos del profesor |
| `token` | String | Token de sesión (64 hex chars) |

---

### `FormPrincipal`
Ventana principal de la aplicación. Contiene un `ToolStrip` lateral con iconos y un panel central donde se cargan los `UserControl` o se abren formularios secundarios.

**Visibilidad de botones según rol:**

| Botón | Descripción | Visible para |
|-------|-------------|--------------|
| `btnFicha` | Ficha de profesor | Todos |
| `btnGrades` | Introducir notas | Todos |
| `btnOrlas` | Orla de profesores | Todos |
| `btnOpenT` | Gestionar períodos de evaluación | Admin / Director / Cap d'estudis |
| `btnCSV` | Exportar clase a CSV | Admin / Director / Cap d'estudis |
| `btnJSON` | Exportar profesores a JSON | Admin / Director / Cap d'estudis |
| `btnXML` | Exportar log de logins a XML | Admin / Director / Cap d'estudis |

---

### `FormNotas`
Pantalla de introducción de notas. Muestra los alumnos del grupo con una columna por cada RA de la asignatura seleccionada.

**Flujo:**
1. Carga el período de evaluación activo (`periode.php`)
2. Crea o recupera el acta del trimestre actual (`crear_acta.php`)
3. Carga los alumnos y sus notas (`notes.php → vista_notes_all`)
4. El profesor introduce notas por RA — la media se calcula en tiempo real
5. Al guardar, persiste en `estudiants_ras` y `acta_notes`
6. Al cerrar el proceso, bloquea la edición definitivamente
7. Si el período está cerrado y el usuario tiene permisos, aparece el botón **Corregir** por fila

---

### `AbrirEvaluacion`
`UserControl` que muestra los 3 trimestres del curso en un `DataGridView`. Permite al cap d'estudis o director abrir o cerrar un trimestre. Al abrir uno, los demás se cierran automáticamente.

---

### `SeleccionarAsignatura`
Diálogo de selección antes de abrir `FormNotas`.

- **Profesor:** solo ve sus asignaturas asignadas (con su grupo ya vinculado)
- **Admin/Director:** ve todas las asignaturas y debe seleccionar también el grupo

---

### `FormFicha`
Ficha de profesor. Lista todos los profesores visibles según el rol del usuario y muestra sus datos al seleccionarlos.

**Datos visibles:**
- **Nivel 1** (cualquier profesor): nombre, email, asignaturas, dedicación, foto
- **Nivel 2** (directiva/director): + DNI, teléfono, fecha de nacimiento, contratos, historial de ausencias

---

### `OrlaProfesores`
Muestra una cuadrícula visual con la foto, nombre, cargo, email y departamento de cada profesor del centro. Las fotos se descargan asíncronamente del servidor.

---

### `GestorGraduacion`
Clase auxiliar que gestiona la graduación de un alumno al guardar notas:

1. Llama a `graduar_alumne.php?accio=comprovar` para verificar si aprobó todo
2. Si es así, muestra un diálogo de confirmación con la nota media ponderada
3. El usuario elige dónde guardar el PDF del expediente académico
4. Genera el PDF con `PuppeteerSharp`
5. Llama a `graduar_alumne.php?accio=graduar` para eliminar los datos de la BD y moverlos al histórico

---

### Clases de exportación

| Clase | Formato | Endpoint | Permisos |
|-------|---------|----------|---------|
| `ExportarCSV` | `.csv` | `exportar_csv.php` | Admin / Director / Cap d'estudis |
| `ExportarJSON` | `.json` | `lista_prof.php` | Admin / Director / Cap d'estudis |
| `ExportarXML` | `.xml` | `export_logs.php` | Admin / Director / Cap d'estudis |

---

### `CargarFotos`
Descarga imágenes del servidor XAMPP via HTTP y las muestra en un `PictureBox`. Tiene dos modos:
- `loadAsync` — espera el resultado (usar con `Await`)
- `loadBackground` — dispara en segundo plano sin bloquear la UI

---

### `ConstruirHtml` + `GenerarActaPDF`
Generación de PDFs del acta de evaluación:
1. `GenerarActaPDF.generarAsync(idActa)` obtiene los datos del acta vía `dades_acta.php`
2. Construye el HTML del acta con tabla de alumnos, notas por RA, profesores y espacio para firmas
3. `ConstruirHtml.htmlToPdfAsync(html)` usa PuppeteerSharp (Chromium headless) para convertir el HTML a PDF
4. Guarda el PDF en el escritorio

---

### `BaseUrl`
Centraliza todas las URLs de la API. Cambiar `BASE_URL` afecta a toda la aplicación.

```vb
Public Const BASE_URL As String = "https://192.168.1.134"
```

---

## Seguridad

- `UnsafeSSL` desactiva la validación del certificado SSL — **solo para desarrollo** con XAMPP y certificado autofirmado. En producción debe eliminarse.
- Los tokens de sesión se generan en el servidor y se incluyen en las respuestas de login, pero actualmente no se envían en cada petición (sin middleware de autenticación por token en los endpoints).
- Los alumnos (`rol = "alumne"`) tienen acceso denegado al intentar hacer login.