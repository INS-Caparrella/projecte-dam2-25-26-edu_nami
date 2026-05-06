[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=20693981&assignment_repo_type=AssignmentRepo)

# Plataforma EVALIS  
Proyecto DAM2 – Institut Caparrella (Curso 2025–2026)

EVALIS es una plataforma académica orientada a centralizar la gestión de notas, expedientes y procesos de evaluación de los centros educativos de FP. El proyecto incluye dos aplicaciones que comparten la misma base de datos:

- Aplicación móvil Android (Kotlin)
- Aplicación de escritorio (VB.NET)

## Funciones principales

- Autenticación de usuarios con roles (alumnos, profesores, tutores, directiva, administradores).
- Consulta de datos académicos: boletines, expedientes, historial y promociones.
- Introducción y gestión de notas por parte del profesorado.
- Notificaciones de nuevas notas al alumnado.
- Gestión de grupos, asignaturas, UF/RA y períodos de evaluación.
- Exportación de datos (PDF, CSV, JSON, XML) según el rol.
- Registro de inicios de sesión y seguridad basada en tokens.
- Soporte para fotos de perfil y datos personales.
- Estadísticas y gráficos académicos.

## Arquitectura del proyecto

- Base de datos MySQL/MariaDB (XAMPP).
- Backend en PHP para la app móvil.
- Conexión directa a la base de datos desde la app de escritorio.
- Comunicación mediante JSON entre Android y el servidor.
- Diseño orientado a objetos y UML (clases, secuencia y casos de uso).

## Tecnologías usadas

- Android Studio (Kotlin)
- Visual Studio (VB.NET)
- XAMPP con Apache + MySQL/MariaDB
- GitHub para el control de versiones
