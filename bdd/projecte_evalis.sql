-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Temps de generació: 19-11-2025 a les 19:55:52
-- Versió del servidor: 10.4.32-MariaDB
-- Versió de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de dades: `plataforma_evalis`
--

DELIMITER $$
--
-- Procediments
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alumnesGrup` (IN `grup` VARCHAR(11))   BEGIN
    SELECT p.nom,p.cognom,p.dni, TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) AS edat
    FROM persones p
    JOIN estudiants e ON e.dni=p.dni 
    WHERE e.nom_grup = grup
    ORDER BY p.nom,p.cognom;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llistatMajorsEdatEstudiants` ()   BEGIN
    SELECT p.nom AS nom,p.cognom AS cognom, TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) AS edat
    FROM persones p JOIN estudiant e ON e.dni = p.dni
    WHERE TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) >= 18
    ORDER BY p.nom,p.cognom;
END$$

--
-- Funcions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `intentsLogin` (`userId` INT, `rang1` DATETIME, `rang2` DATETIME) RETURNS INT(11)  BEGIN
    DECLARE result INT DEFAULT 0;

    SELECT COUNT(*) INTO result
    FROM logs_login l
    WHERE l.id_user = userId
      AND l.dia BETWEEN rang1 AND rang2;

    RETURN result;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `majorEdat` (`dni` VARCHAR(9)) RETURNS TINYINT(1)  BEGIN
    DECLARE edat INT;
    DECLARE major BOOLEAN DEFAULT FALSE;

    SELECT TIMESTAMPDIFF(YEAR, data_naix, CURDATE()) 
    INTO edat FROM persones p 
    WHERE p.dni = dni;

    IF edat IS NOT NULL AND edat >= 18 THEN
        SET major = TRUE;
    END IF;

    RETURN major;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de la taula `administradors`
--

CREATE TABLE `administradors` (
  `id` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `id_user` int(11) NOT NULL,
  `dades` tinyint(1) NOT NULL,
  `superadmin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `admin_centre`
--

CREATE TABLE `admin_centre` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `codi_centre` int(11) NOT NULL,
  `backup` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `assignatures`
--

CREATE TABLE `assignatures` (
  `codi` varchar(25) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `assignatures_cicle`
--

CREATE TABLE `assignatures_cicle` (
  `id` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `assistencia`
--

CREATE TABLE `assistencia` (
  `id` int(11) NOT NULL,
  `codi_prof` varchar(20) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL,
  `nom_grup` varchar(25) NOT NULL,
  `hora_inici` time NOT NULL,
  `hora_fin` time NOT NULL,
  `observacio` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `centres`
--

CREATE TABLE `centres` (
  `codi` int(11) NOT NULL,
  `nom` varchar(256) NOT NULL,
  `data_inaug` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `cicles`
--

CREATE TABLE `cicles` (
  `nom` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `contractes`
--

CREATE TABLE `contractes` (
  `id` int(11) NOT NULL,
  `codi_prof` varchar(20) NOT NULL,
  `codi_centre` int(11) NOT NULL,
  `data_alta` date NOT NULL,
  `data_baix` date NOT NULL,
  `vinculacio_laboral` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `directiva`
--

CREATE TABLE `directiva` (
  `rol` varchar(25) NOT NULL,
  `codi_prof` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `estudiants`
--

CREATE TABLE `estudiants` (
  `nia` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `nom_grup` varchar(25) NOT NULL,
  `nom_cicle` varchar(25) NOT NULL,
  `cursant` tinyint(1) NOT NULL,
  `repetidor` tinyint(1) NOT NULL,
  `treballant` tinyint(1) NOT NULL,
  `empresa` varchar(256) NOT NULL,
  `actiu` tinyint(1) NOT NULL DEFAULT 1,
  `data_inici` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadors `estudiants`
--
DELIMITER $$
CREATE TRIGGER `estudiantHistoric` AFTER UPDATE ON `estudiants` FOR EACH ROW BEGIN
    DECLARE fin BOOLEAN DEFAULT FALSE;

    IF OLD.actiu = TRUE AND NEW.actiu = FALSE THEN

        SELECT MIN(er.nota) >= 5
        INTO fin
        FROM estudiants_ras er
        WHERE er.nia = NEW.nia;

        INSERT INTO historic_estudiants (nia, nom_cicle, fin, data_inici, date_fin)
        VALUES (NEW.nia, NEW.nom_cicle, fin, NEW.data_inici, CURDATE());

        DELETE FROM estudiants WHERE nia = NEW.nia;

    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de la taula `estudiants_ras`
--

CREATE TABLE `estudiants_ras` (
  `id` int(11) NOT NULL,
  `id_ra` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nota` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `grup_classe`
--

CREATE TABLE `grup_classe` (
  `nom` varchar(25) NOT NULL,
  `aula` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `historic_estudiants`
--

CREATE TABLE `historic_estudiants` (
  `id` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `finalitzat` tinyint(1) NOT NULL,
  `nota_final` decimal(10,0) DEFAULT NULL,
  `data_inici` date NOT NULL,
  `data_fi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `historic_fct`
--

CREATE TABLE `historic_fct` (
  `id` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `empreses` varchar(256) NOT NULL,
  `hores` int(11) NOT NULL,
  `finalitzat` tinyint(1) NOT NULL,
  `observacions` varchar(256) NOT NULL,
  `incidencies` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `historic_professors`
--

CREATE TABLE `historic_professors` (
  `id` int(11) NOT NULL,
  `codi_prof` varchar(20) NOT NULL,
  `tipus` varchar(50) NOT NULL,
  `motius` varchar(125) NOT NULL,
  `justificat` tinyint(1) NOT NULL,
  `justificant` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `logs_consultes`
--

CREATE TABLE `logs_consultes` (
  `id` int(11) NOT NULL,
  `token` int(11) NOT NULL,
  `consulta` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `logs_login`
--

CREATE TABLE `logs_login` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `ip` int(12) NOT NULL,
  `login` tinyint(1) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `persones`
--

CREATE TABLE `persones` (
  `dni` varchar(9) NOT NULL,
  `nom` varchar(25) NOT NULL,
  `cognom` varchar(50) NOT NULL,
  `data_naix` date NOT NULL,
  `poblacio` varchar(25) NOT NULL,
  `codi_postal` int(5) NOT NULL,
  `nacionalitat` varchar(25) NOT NULL,
  `municipi_naix` varchar(25) NOT NULL,
  `telf_mob` int(9) NOT NULL,
  `telf_fix` int(9) NOT NULL,
  `email` varchar(50) NOT NULL,
  `ruta_foto` int(125) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadors `persones`
--
DELIMITER $$
CREATE TRIGGER `generarUsuari` AFTER INSERT ON `persones` FOR EACH ROW BEGIN
    DECLARE usernameN VARCHAR(50);
    SET usernameN = CONCAT(NEW.nom, LEFT(NEW.cognom, 1));

    INSERT INTO usuaris (username, dni, password)
    VALUES (
        usernameN,
        NEW.dni,
        SHA2(NEW.dni, 256)
    );
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `valid_email` BEFORE INSERT ON `persones` FOR EACH ROW BEGIN
	IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'email no vàlid';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de la taula `professors`
--

CREATE TABLE `professors` (
  `codi_prof` varchar(20) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `dedicacio` enum('professor','tutor de grup','tutor FCT','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `prof_assignatura`
--

CREATE TABLE `prof_assignatura` (
  `id` int(11) NOT NULL,
  `id_codiprof` varchar(20) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `ras`
--

CREATE TABLE `ras` (
  `id` int(11) NOT NULL,
  `codi_assignatura` varchar(25) NOT NULL,
  `data_inici` date NOT NULL,
  `data_fin` date NOT NULL,
  `nota` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `sessions`
--

CREATE TABLE `sessions` (
  `token` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `username` varchar(11) NOT NULL,
  `data_inici` date NOT NULL,
  `data_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `usuaris`
--

CREATE TABLE `usuaris` (
  `id_user` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `username` varchar(11) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índexs per a les taules bolcades
--

--
-- Índexs per a la taula `administradors`
--
ALTER TABLE `administradors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_admindni` (`dni`),
  ADD KEY `fk_adminuser` (`id_user`);

--
-- Índexs per a la taula `admin_centre`
--
ALTER TABLE `admin_centre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_adminid` (`admin_id`),
  ADD KEY `fk_codicentre` (`codi_centre`);

--
-- Índexs per a la taula `assignatures`
--
ALTER TABLE `assignatures`
  ADD PRIMARY KEY (`codi`);

--
-- Índexs per a la taula `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_nomcicle` (`nom_cicle`),
  ADD KEY `fk_cicleassignatura` (`id_assignatura`);

--
-- Índexs per a la taula `assistencia`
--
ALTER TABLE `assistencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_codiprofeass` (`codi_prof`),
  ADD KEY `fk_codiass` (`id_assignatura`),
  ADD KEY `fk_nomgrup` (`nom_grup`);

--
-- Índexs per a la taula `centres`
--
ALTER TABLE `centres`
  ADD PRIMARY KEY (`codi`);

--
-- Índexs per a la taula `cicles`
--
ALTER TABLE `cicles`
  ADD PRIMARY KEY (`nom`);

--
-- Índexs per a la taula `contractes`
--
ALTER TABLE `contractes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_codip` (`codi_prof`),
  ADD KEY `fk_codic` (`codi_centre`);

--
-- Índexs per a la taula `directiva`
--
ALTER TABLE `directiva`
  ADD PRIMARY KEY (`rol`),
  ADD KEY `fk_codiprof` (`codi_prof`);

--
-- Índexs per a la taula `estudiants`
--
ALTER TABLE `estudiants`
  ADD PRIMARY KEY (`nia`),
  ADD KEY `fk_dnies` (`dni`),
  ADD KEY `fk_nomgrupes` (`nom_grup`),
  ADD KEY `fk_cicles` (`nom_cicle`) USING BTREE;

--
-- Índexs per a la taula `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idra` (`id_ra`),
  ADD KEY `fk_niaa` (`nia`);

--
-- Índexs per a la taula `grup_classe`
--
ALTER TABLE `grup_classe`
  ADD PRIMARY KEY (`nom`);

--
-- Índexs per a la taula `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_niaes` (`nia`),
  ADD KEY `fk_nomciclee` (`nom_cicle`);

--
-- Índexs per a la taula `historic_fct`
--
ALTER TABLE `historic_fct`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_niah` (`nia`);

--
-- Índexs per a la taula `historic_professors`
--
ALTER TABLE `historic_professors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_codipr` (`codi_prof`);

--
-- Índexs per a la taula `logs_consultes`
--
ALTER TABLE `logs_consultes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_token` (`token`);

--
-- Índexs per a la taula `logs_login`
--
ALTER TABLE `logs_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_iduserl` (`id_user`);

--
-- Índexs per a la taula `persones`
--
ALTER TABLE `persones`
  ADD PRIMARY KEY (`dni`),
  ADD KEY `dni` (`dni`);

--
-- Índexs per a la taula `professors`
--
ALTER TABLE `professors`
  ADD PRIMARY KEY (`codi_prof`),
  ADD KEY `fk_dniprof` (`dni`);

--
-- Índexs per a la taula `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_codiprofe` (`id_codiprof`),
  ADD KEY `fk_idassignatura` (`id_assignatura`);

--
-- Índexs per a la taula `ras`
--
ALTER TABLE `ras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assignaturaid` (`codi_assignatura`);

--
-- Índexs per a la taula `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`token`),
  ADD KEY `fk_iduser` (`id_user`);

--
-- Índexs per a la taula `usuaris`
--
ALTER TABLE `usuaris`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `fk_usuaridni` (`dni`);

--
-- AUTO_INCREMENT per les taules bolcades
--

--
-- AUTO_INCREMENT per la taula `administradors`
--
ALTER TABLE `administradors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `admin_centre`
--
ALTER TABLE `admin_centre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `assistencia`
--
ALTER TABLE `assistencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `contractes`
--
ALTER TABLE `contractes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `historic_fct`
--
ALTER TABLE `historic_fct`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `historic_professors`
--
ALTER TABLE `historic_professors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `logs_consultes`
--
ALTER TABLE `logs_consultes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `logs_login`
--
ALTER TABLE `logs_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `ras`
--
ALTER TABLE `ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la taula `usuaris`
--
ALTER TABLE `usuaris`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restriccions per a les taules bolcades
--

--
-- Restriccions per a la taula `administradors`
--
ALTER TABLE `administradors`
  ADD CONSTRAINT `fk_admindni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_adminuser` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `admin_centre`
--
ALTER TABLE `admin_centre`
  ADD CONSTRAINT `fk_adminid` FOREIGN KEY (`admin_id`) REFERENCES `administradors` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_codicentre` FOREIGN KEY (`codi_centre`) REFERENCES `centres` (`codi`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  ADD CONSTRAINT `fk_cicleassignatura` FOREIGN KEY (`id_assignatura`) REFERENCES `assignatures` (`codi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomcicle` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `assistencia`
--
ALTER TABLE `assistencia`
  ADD CONSTRAINT `fk_codiass` FOREIGN KEY (`id_assignatura`) REFERENCES `assignatures` (`codi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_codiprofeass` FOREIGN KEY (`codi_prof`) REFERENCES `professors` (`codi_prof`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomgrup` FOREIGN KEY (`nom_grup`) REFERENCES `grup_classe` (`nom`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `contractes`
--
ALTER TABLE `contractes`
  ADD CONSTRAINT `fk_codic` FOREIGN KEY (`codi_centre`) REFERENCES `centres` (`codi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_codip` FOREIGN KEY (`codi_prof`) REFERENCES `professors` (`codi_prof`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `directiva`
--
ALTER TABLE `directiva`
  ADD CONSTRAINT `fk_codiprof` FOREIGN KEY (`codi_prof`) REFERENCES `professors` (`codi_prof`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restriccions per a la taula `estudiants`
--
ALTER TABLE `estudiants`
  ADD CONSTRAINT `fk_ciclees` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dnies` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomgrupes` FOREIGN KEY (`nom_grup`) REFERENCES `grup_classe` (`nom`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  ADD CONSTRAINT `fk_idra` FOREIGN KEY (`id_ra`) REFERENCES `ras` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_niaa` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  ADD CONSTRAINT `fk_niaes` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomciclee` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `historic_fct`
--
ALTER TABLE `historic_fct`
  ADD CONSTRAINT `fk_niah` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `historic_professors`
--
ALTER TABLE `historic_professors`
  ADD CONSTRAINT `fk_codipr` FOREIGN KEY (`codi_prof`) REFERENCES `professors` (`codi_prof`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `logs_consultes`
--
ALTER TABLE `logs_consultes`
  ADD CONSTRAINT `fk_token` FOREIGN KEY (`token`) REFERENCES `sessions` (`token`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `logs_login`
--
ALTER TABLE `logs_login`
  ADD CONSTRAINT `fk_iduserl` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `professors`
--
ALTER TABLE `professors`
  ADD CONSTRAINT `fk_dniprof` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  ADD CONSTRAINT `fk_codiprofe` FOREIGN KEY (`id_codiprof`) REFERENCES `professors` (`codi_prof`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_idassignatura` FOREIGN KEY (`id_assignatura`) REFERENCES `assignatures` (`codi`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `ras`
--
ALTER TABLE `ras`
  ADD CONSTRAINT `fk_assignaturaid` FOREIGN KEY (`codi_assignatura`) REFERENCES `assignatures` (`codi`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `fk_iduser` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`) ON UPDATE CASCADE;

--
-- Restriccions per a la taula `usuaris`
--
ALTER TABLE `usuaris`
  ADD CONSTRAINT `fk_usuaridni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
