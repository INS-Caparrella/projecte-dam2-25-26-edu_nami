# EVALIS — Backend API (PHP)

API REST en PHP per al sistema de gestió acadèmica **EVALIS**. Tots els endpoints retornen JSON i es connecten a una base de dades MariaDB via XAMPP.

---

## Configuració

- **Servidor:** XAMPP (Apache + MariaDB)
- **Port BD:** 3307
- **Base de dades:** `projecte_evalis`
- **Usuari BD:** `root` (sense contrasenya)
- **Ruta base:** `https://<IP_SERVIDOR>/`

---

## Endpoints

### `login.php`
Autenticació d'usuaris.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| POST | `username`, `password` | Valida credencials, crea sessió i registra el log |

**Resposta OK:**
```json
{
  "pot_entrar": true,
  "dni": "12345678A",
  "rol": "professor",
  "nom": "Marc",
  "cognom": "Serra Puig",
  "ruta_foto": "img/profs/prof01.png",
  "token": "abc123...",
  "expires": "2026-05-06 10:00:00",
  "grup": "DAM2A",
  "grups": ["DAM2A"],
  "rol_directiva": "Cap d'estudis"
}
```

---

### `notes.php`
Gestió de notes dels alumnes per RA.

| Mètode | `accio` | Paràmetres | Descripció |
|--------|---------|-----------|------------|
| GET | `assignatures` | `dni` | Assignatures del professor |
| GET | `assignatures_all` | — | Totes les assignatures (admin/director) |
| GET | `vista_notes_all` | `id_assignatura`, `nom_grup` | Alumnes i notes de tots els RAs |
| GET | `grups_assignatura` | `id_assignatura` | Grups que cursen l'assignatura |
| POST | `guardar` | `id_ra`, `nia`, `nota` | Desa una nota (INSERT o UPDATE) |
| POST | `tancar_proces` | `id_assignatura`, `dni` | Tanca el procés d'avaluació |

---

### `periode.php`
Gestió dels períodes d'avaluació (trimestres).

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| GET | `curs` | Llista els 3 trimestres del curs |
| POST | `id_periode`, `accio` (`obrir`/`tancar`), `dni` | Obre o tanca un trimestre |

> Només poden obrir/tancar períodes els usuaris amb rol `director`, `administrador` o `Cap d'estudis`.

---

### `crear_acta.php`
Crea o recupera una acta d'avaluació.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| POST | `id_assignatura`, `dni_prof`, `curs`, `trimestre`, `grup` | Crea l'acta si no existeix, o retorna la existent |

> Si `trimestre = 0` (període tancat), cerca l'acta existent per curs i grup.

---

### `nota_final.php`
Desa la nota final d'un alumne a una acta.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| POST | `id_acta`, `nia`, `nota` | INSERT o UPDATE de la nota final a `acta_notes` |

---

### `acta.php`
Consulta i correcció de notes d'una acta tancada.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| GET | `id_acta` | Notes de tots els alumnes d'una acta |
| POST | `id_acta`, `dni_prof`, `nia`, `valor_nou`, `motiu` | Aplica una correcció (requereix permisos de director/cap d'estudis) |

> Les correccions queden registrades a `historic_actes` i marquen l'acta com a `corregida = 1`.

---

### `dades_acta.php`
Retorna totes les dades necessàries per generar el PDF d'una acta.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| GET | `id_acta`, `dni` | Acta + RAs + alumnes + professors + historial de correccions |

> Requereix que `dni` tingui rol `director`, `administrador` o `Cap d'estudis`.

---

### `fitxa_professor.php`
Fitxa d'un professor amb dades segons el nivell d'accés.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| GET | `dni_consultor`, `dni_professor` | Retorna dades bàsiques o completes segons el rol |

**Nivells d'accés:**
- **Nivell 1** (professor): nom, email, assignatures, dedicació
- **Nivell 2** (directiva/director): + DNI, telèfon, data naix, contractes, absències
- **Nivell 3** (administrador): igual que nivell 2 però de tots els centres

---

### `lista_prof.php`
Llista de professors visibles per al consultant.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| GET | `dni_consultor` | Professors del centre (o de tots si és admin) |

---

### `orla.php`
Dades per a l'orla de professors.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| GET | — | Tots els professors amb nom, foto, càrrec, email i departament |

---

### `exportar_csv.php`
Exporta els alumnes d'un grup a CSV.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| GET | `nom_grup` | Retorna nom, cognoms, DNI, grup i cicle dels alumnes actius |

---

### `export_logs.php`
Exporta el registre de logins.

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| GET | `dni_consultor`, `limit` (opcional, màx. 2000) | Últims N registres de login amb IP i resultat |

> Requereix rol `director`, `administrador` o `Cap d'estudis`.

---

### `graduar_alumne.php`
Processa la graduació d'un alumne.

| Mètode | `accio` | Paràmetres | Descripció |
|--------|---------|-----------|------------|
| POST/GET | `comprovar` | `nia` | Comprova si l'alumne ha aprovat tot el cicle |
| POST | `graduar` | `nia` | Esborra les dades i mou l'alumne a l'historial |

---

### `crear_password.php`
Estableix la contrasenya d'un usuari nou (primer accés).

| Mètode | Paràmetres | Descripció |
|--------|-----------|------------|
| POST | `dni`, `password` | Hash bcrypt i UPDATE a `usuaris` (només si `password IS NULL`) |

---

### `get_estudis.php` · `get_prof.php` · `get_profs.php` · `get_expedient.php`
Endpoints auxiliars que requereixen token de sessió (`validar_token.php`). S'usen des de l'app mòbil.

---

## Estructura de carpetes

```
htdocs/
├── login.php
├── notes.php
├── periode.php
├── crear_acta.php
├── nota_final.php
├── acta.php
├── dades_acta.php
├── fitxa_professor.php
├── lista_prof.php
├── orla.php
├── exportar_csv.php
├── export_logs.php
├── graduar_alumne.php
├── crear_password.php
├── get_estudis.php
├── get_prof.php
├── get_profs.php
├── get_expedient.php
└── img/
    └── profs/
        ├── prof01.png
        └── ...
```

---

## Notes de seguretat

- Les contrasenyes es guarden amb `password_hash()` (bcrypt).
- Els tokens de sessió es generen amb `bin2hex(random_bytes(32))`.
- Totes les queries usen `prepared statements` per evitar SQL injection.
- El servidor usa HTTPS amb certificat autofirmat (entorn de desenvolupament).
- Els endpoints sensibles (correccions, logs, graduació) verifiquen el rol abans d'executar.