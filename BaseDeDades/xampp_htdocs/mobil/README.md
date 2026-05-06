# API PHP — Evalis

## Connexió i autenticació

### `validar_token.php`
Include reutilitzable. Verifica que el token de sessió sigui vàlid i no hagi expirat. Registra la consulta a `logs_consultes`.
- **Requereix**: `$mysqli` inicialitzat + `token` via GET o POST
- **Exposa**: `$dni_user` (DNI de l'usuari autenticat)

---

### `login.php`
**POST** — Autentica un usuari i crea una sessió.
- **Params POST**: `username`, `password`
- **Retorna**: `pot_entrar`, `dni`, `rol`, `nom`, `cognom`, `ruta_foto`, `token`, `expires`, `grup`, `grups`
- **Notes**: Registra intents a `logs_login`. Gestiona professors (retorna grups assignats).

---

## Perfil i estadístiques

### `get_perfil.php`
**GET** — Dades personals i acadèmiques de l'alumne autenticat.
- **Params**: `token`
- **Retorna**: `nom`, `cognom`, `data_naix`, `email`, `telf_mob`, `poblacio`, `ruta_foto`, `nom_grup`, `nom_cicle`, `grado`, `treballant`, `empresa`

---

### `get_estadistiques.php`
**GET** — Estadístiques de progrés per cicle de l'alumne autenticat.
- **Params**: `token`
- **Retorna**: llista de `cicles` amb `nom_cicle`, `total_cursos`, `percentatge`, `nota_mitja`, `acabat`, i array de `cursos` (grado, finalitzat, percentatge, nota_final)
- **Notes**: Combina dades del `historic_estudiants` amb el curs actual de `estudiants`. El percentatge es calcula per temps transcorregut (292 dies = 1 curs). Màxim 99% si el curs encara no ha acabat.

---

### `pfp_mobil.php`
**POST** (multipart) — Puja i actualitza la foto de perfil de l'alumne.
- **Params POST**: `dni`, `token`, `foto` (fitxer JPEG, màx 300 KB)
- **Retorna**: `ok`, `ruta_foto`
- **Notes**: Desa a `/img/alumns/perfil_{dni}.jpg`. Actualitza `persones.ruta_foto`.

---

## Professors

### `get_profs.php`
**GET** — Llista de professors del cicle de l'alumne.
- **Params**: `dni`, `token`
- **Retorna**: array de `{ codi_prof, nom, cognom, email, ruta_foto }`
- **Notes**: Filtra pels professors que imparteixen assignatures del cicle de l'alumne.

---

### `get_prof.php`
**GET** — Detall d'un professor concret amb les seves assignatures.
- **Params**: `dni`, `codi_prof`, `token`
- **Retorna**: `{ codi_prof, nom, cognom, email, ruta_foto, assignatures: [{ nom_assignatura, aula }] }`
- **Notes**: Les assignatures es filtren per les que imparteix al cicle de l'alumne que consulta.

---

## Expedient acadèmic

### `get_estudis.php`
**GET** — Cicles (actual i historials) de l'alumne.
- **Params**: `dni`, `token`
- **Retorna**: array amb `{ actual, historic: [{ cicleH, tots_finalitzats, es_actual }] }`
- **Notes**: `tots_finalitzats` = true si tots els cursos del cicle estan aprovats (nota ≥ 5).

---

### `get_cursos.php`
**GET** — Cursos d'un cicle concret (historials + actual).
- **Params**: `dni`, `cicle`, `token`
- **Retorna**: `{ nom, dni, nia, grup, cicle, cursos: [{ curs, data_inici, data_fi, finalitzat, nota_final, actual }] }`
- **Notes**: Inclou el curs actual si el cicle coincideix amb el de `estudiants`.

---

### `get_expedient.php`
**GET** — Genera PDF de l'expedient acadèmic d'un cicle finalitzat.
- **Params**: `dni`, `cicle`, `token`
- **Retorna**: fitxer PDF (Content-Disposition: attachment)
- **Conté**: dades del centre, alumne, cicle, nota final i taula de qualificacions agrupada per assignatura amb RAs i nota final de mòdul.
- **Notes**: Usa Dompdf. Només mostra el primer registre de `historic_estudiants` per al cicle.

---

### `get_butlleti.php`
**GET** — Genera PDF del butlletí de notes d'un curs concret.
- **Params**: `dni`, `cicle`, `data_inici`, `token`
- **Retorna**: fitxer PDF (Content-Disposition: attachment)
- **Conté**: dades del centre, alumne, curs i taula de qualificacions per assignatura amb RAs.
- **Notes**: Distingeix entre curs històric i curs actual (`esActual`). Si el curs és actual i no té notes, mostra missatge informatiu. Filtra les notes de `estudiants_ras` per rang de dates del curs.

---

## Notificacions

### `send_notifs.php`
**GET** — Comprova si l'alumne té butlletí o expedient disponible.
- **Params**: `nia`
- **Retorna**: text pla: `expedient`, `butlleti` o `ninguno`
- **Lògica**:
  1. Si té algun cicle amb tots els cursos finalitzats i aprovats → `expedient`
  2. Si té algun registre a `historic_estudiants` → `butlleti`
  3. Altrament → `ninguno`
- **Notes**: No requereix token (usat per Polling en background).

---

## Resum d'endpoints

| Endpoint | Mètode | Auth | Retorna |
|---|---|---|---|
| `login.php` | POST | ❌ | JSON sessió |
| `get_perfil.php` | GET | token | JSON perfil |
| `get_estadistiques.php` | GET | token | JSON estadístiques |
| `pfp_mobil.php` | POST | token | JSON ok/error |
| `get_profs.php` | GET | token | JSON llista profs |
| `get_prof.php` | GET | token | JSON detall prof |
| `get_estudis.php` | GET | token | JSON cicles |
| `get_cursos.php` | GET | token | JSON cursos cicle |
| `get_expedient.php` | GET | token | PDF expedient |
| `get_butlleti.php` | GET | token | PDF butlletí |
| `send_notifs.php` | GET | ❌ | Text: expedient/butlleti/ninguno |
