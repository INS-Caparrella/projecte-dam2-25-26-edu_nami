-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-01-2026 a las 17:24:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `projecte_evalis`
--
CREATE DATABASE IF NOT EXISTS `projecte_evalis` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `projecte_evalis`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `alumnesGrup`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `alumnesGrup` (IN `grup` VARCHAR(11))   BEGIN
    SELECT p.nom,p.cognom,p.dni, TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) AS edat
    FROM persones p
    JOIN estudiants e ON e.dni=p.dni 
    WHERE e.nom_grup = grup
    ORDER BY p.nom,p.cognom;
END$$

DROP PROCEDURE IF EXISTS `llistatMajorsEdatEstudiants`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llistatMajorsEdatEstudiants` ()   BEGIN
    SELECT p.nom AS nom,p.cognom AS cognom, TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) AS edat
    FROM persones p JOIN estudiants e ON e.dni = p.dni
    WHERE TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) >= 18
    ORDER BY p.nom,p.cognom;
END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `intentsLogin`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `intentsLogin` (`userId` INT, `rang1` DATETIME, `rang2` DATETIME) RETURNS INT(11)  BEGIN
    DECLARE result INT DEFAULT 0;

    SELECT COUNT(*) INTO result
    FROM logs_login l
    WHERE l.id_user = userId
      AND l.data BETWEEN rang1 AND rang2;

    RETURN result;
END$$

DROP FUNCTION IF EXISTS `majorEdat`$$
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
-- Estructura de tabla para la tabla `administradors`
--

DROP TABLE IF EXISTS `administradors`;
CREATE TABLE `administradors` (
  `id` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `id_user` int(11) NOT NULL,
  `dades` tinyint(1) NOT NULL,
  `superadmin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administradors`
--

INSERT INTO `administradors` (`id`, `dni`, `id_user`, `dades`, `superadmin`) VALUES
(11, '22334455L', 11, 1, 1),
(12, '33445566M', 12, 1, 0),
(13, '44556677N', 13, 0, 0),
(14, '55667788P', 14, 1, 0),
(15, '66778899Q', 15, 1, 0),
(16, '77889900R', 16, 0, 0),
(17, '88990011S', 17, 1, 0),
(18, '99001122T', 18, 1, 1),
(19, '10111213U', 19, 0, 0),
(20, '12131415V', 20, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin_centre`
--

DROP TABLE IF EXISTS `admin_centre`;
CREATE TABLE `admin_centre` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `codi_centre` int(11) NOT NULL,
  `backup` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `admin_centre`
--

INSERT INTO `admin_centre` (`id`, `admin_id`, `codi_centre`, `backup`) VALUES
(11, 11, 1, 1),
(12, 12, 2, 0),
(13, 13, 3, 0),
(14, 14, 4, 0),
(15, 15, 5, 0),
(16, 16, 6, 0),
(17, 17, 7, 0),
(18, 18, 8, 1),
(19, 19, 9, 0),
(20, 20, 10, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `assignatures`
--

DROP TABLE IF EXISTS `assignatures`;
CREATE TABLE `assignatures` (
  `codi` varchar(25) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `assignatures`
--

INSERT INTO `assignatures` (`codi`, `nom`) VALUES
('ASIG001', 'Programació'),
('ASIG002', 'Bases de Dades'),
('ASIG003', 'Gestió Empresarial'),
('ASIG004', 'Disseny Gràfic'),
('ASIG005', 'Mecànica Aplicada'),
('ASIG006', 'Ofimàtica'),
('ASIG007', 'Serveis i Atenció al Client'),
('ASIG008', 'Matemàtiques'),
('ASIG009', 'Informàtica Bàsica'),
('ASIG010', 'Ciències Naturals');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `assignatures_cicle`
--

DROP TABLE IF EXISTS `assignatures_cicle`;
CREATE TABLE `assignatures_cicle` (
  `id` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `assignatures_cicle`
--

INSERT INTO `assignatures_cicle` (`id`, `nom_cicle`, `id_assignatura`) VALUES
(1, 'CFGM Informàtica', 'ASIG001'),
(2, 'CFGS Desenvolupament', 'ASIG002'),
(3, 'Cicle Administració', 'ASIG003'),
(4, 'Cicle Imatge', 'ASIG004'),
(5, 'Cicle Mecànica', 'ASIG005'),
(6, 'Cicle Oficina', 'ASIG006'),
(7, 'Cicle Serveis', 'ASIG007'),
(8, 'Batxillerat', 'ASIG008'),
(9, 'FP Bàsica', 'ASIG009'),
(10, 'ESO', 'ASIG010');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `assistencia`
--

DROP TABLE IF EXISTS `assistencia`;
CREATE TABLE `assistencia` (
  `id` int(11) NOT NULL,
  `codi_prof` varchar(20) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL,
  `nom_grup` varchar(25) NOT NULL,
  `hora_inici` time NOT NULL,
  `hora_fin` time NOT NULL,
  `observacio` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `assistencia`
--

INSERT INTO `assistencia` (`id`, `codi_prof`, `id_assignatura`, `nom_grup`, `hora_inici`, `hora_fin`, `observacio`) VALUES
(1, 'PROF001', 'ASIG001', 'ASIX1A', '08:00:00', '09:00:00', 'Primera classe del curs'),
(2, 'PROF002', 'ASIG002', 'ASIX2A', '09:00:00', '10:00:00', 'Sessió pràctica informàtica'),
(3, 'PROF003', 'ASIG003', 'DAM1A', '10:00:00', '11:00:00', 'Explicació teoria'),
(4, 'PROF004', 'ASIG004', 'DAM2A', '11:00:00', '12:00:00', 'Treball en grup'),
(5, 'PROF005', 'ASIG005', 'DAW1A', '12:00:00', '13:00:00', 'Laboratori de mecànica'),
(6, 'PROF006', 'ASIG006', 'DAW2A', '13:00:00', '14:00:00', 'Ofimàtica aplicada'),
(7, 'PROF007', 'ASIG007', 'FPB1A', '14:00:00', '15:00:00', 'Pràctica de serveis'),
(8, 'PROF008', 'ASIG008', 'FPB2A', '15:00:00', '16:00:00', 'Matemàtiques Batxillerat'),
(9, 'PROF009', 'ASIG009', 'SMX1A', '16:00:00', '17:00:00', 'Informàtica FP Bàsica'),
(10, 'PROF010', 'ASIG010', 'SMX2A', '17:00:00', '18:00:00', 'Ciències Naturals ESO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centres`
--

DROP TABLE IF EXISTS `centres`;
CREATE TABLE `centres` (
  `codi` int(11) NOT NULL,
  `nom` varchar(256) NOT NULL,
  `data_inaug` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `centres`
--

INSERT INTO `centres` (`codi`, `nom`, `data_inaug`) VALUES
(1, 'Institut Escola Montjuïc', '1995-09-01'),
(2, 'Institut Joan Miró', '2000-01-15'),
(3, 'Institut Pau Claris', '1988-06-20'),
(4, 'Institut La Salle', '1992-03-10'),
(5, 'Institut Sant Jordi', '2005-09-05'),
(6, 'Institut Mediterrània', '2010-11-12'),
(7, 'Institut Llevant', '1998-05-18'),
(8, 'Institut Bellaterra', '2002-08-25'),
(9, 'Institut Turó Park', '1990-12-01'),
(10, 'Institut Vall d’Hebron', '1997-07-30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cicles`
--

DROP TABLE IF EXISTS `cicles`;
CREATE TABLE `cicles` (
  `nom` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cicles`
--

INSERT INTO `cicles` (`nom`) VALUES
('Batxillerat'),
('CFGM Informàtica'),
('CFGS Desenvolupament'),
('Cicle Administració'),
('Cicle Imatge'),
('Cicle Mecànica'),
('Cicle Oficina'),
('Cicle Serveis'),
('ESO'),
('FP Bàsica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contractes`
--

DROP TABLE IF EXISTS `contractes`;
CREATE TABLE `contractes` (
  `id` int(11) NOT NULL,
  `codi_prof` varchar(20) NOT NULL,
  `codi_centre` int(11) NOT NULL,
  `data_alta` date NOT NULL,
  `data_baix` date DEFAULT NULL,
  `vinculacio_laboral` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contractes`
--

INSERT INTO `contractes` (`id`, `codi_prof`, `codi_centre`, `data_alta`, `data_baix`, `vinculacio_laboral`) VALUES
(1, 'PROF001', 1, '2023-09-01', NULL, 'Contracte a temps complet'),
(2, 'PROF002', 2, '2023-09-01', NULL, 'Contracte parcial'),
(3, 'PROF003', 3, '2023-09-01', '2024-06-30', 'Contracte temporal'),
(4, 'PROF004', 4, '2022-09-01', NULL, 'Contracte a temps complet'),
(5, 'PROF005', 5, '2023-01-15', '2023-06-30', 'Contracte parcial'),
(6, 'PROF006', 6, '2023-09-01', NULL, 'Contracte a temps complet'),
(7, 'PROF007', 7, '2022-09-01', '2023-06-30', 'Contracte temporal'),
(8, 'PROF008', 8, '2023-09-01', NULL, 'Contracte a temps complet'),
(9, 'PROF009', 9, '2023-09-01', NULL, 'Contracte parcial'),
(10, 'PROF010', 10, '2022-09-01', '2023-06-30', 'Contracte a temps complet');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `directiva`
--

DROP TABLE IF EXISTS `directiva`;
CREATE TABLE `directiva` (
  `rol` varchar(25) NOT NULL,
  `codi_prof` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `directiva`
--

INSERT INTO `directiva` (`rol`, `codi_prof`) VALUES
('Director', 'PROF001'),
('Cap d’estudis', 'PROF002'),
('Coordinador CFGM', 'PROF003'),
('Coordinador CFGS', 'PROF004'),
('Secretari', 'PROF005'),
('Tresorer', 'PROF006'),
('Coordinador Batxillerat', 'PROF007'),
('Cap de FP Bàsica', 'PROF008'),
('Coordinador ESO', 'PROF009'),
('Coordinador DAW', 'PROF010');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiants`
--

DROP TABLE IF EXISTS `estudiants`;
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
-- Volcado de datos para la tabla `estudiants`
--

INSERT INTO `estudiants` (`nia`, `dni`, `nom_grup`, `nom_cicle`, `cursant`, `repetidor`, `treballant`, `empresa`, `actiu`, `data_inici`) VALUES
(10001, '22334455L', 'ASIX1A', 'CFGM Informàtica', 1, 0, 1, 'EmpresaTech', 1, '2023-09-01'),
(10002, '33445566M', 'ASIX2A', 'CFGS Desenvolupament', 1, 1, 0, 'SoftSolutions', 1, '2023-09-01'),
(10003, '44556677N', 'DAM1A', 'CFGS Desenvolupament', 1, 0, 0, 'DevStudio', 0, '2023-09-01'),
(10004, '55667788P', 'DAM2A', 'Cicle Administració', 1, 0, 1, 'AdminCorp', 1, '2023-09-01'),
(10005, '66778899Q', 'DAW1A', 'Cicle Imatge', 1, 1, 0, 'ImatgeLab', 1, '2023-09-01'),
(10006, '77889900R', 'DAW2A', 'Cicle Mecànica', 1, 0, 0, 'MecanicaPro', 1, '2023-09-01'),
(10007, '88990011S', 'FPB1A', 'Cicle Oficina', 1, 0, 1, 'OficinaPlus', 0, '2023-09-01'),
(10008, '99001122T', 'FPB2A', 'Cicle Serveis', 1, 0, 0, 'ServeisGlobal', 1, '2023-09-01'),
(10009, '10111213U', 'SMX1A', 'ESO', 1, 1, 0, 'ESOCenter', 1, '2023-09-01'),
(10010, '12131415V', 'SMX2A', 'FP Bàsica', 1, 0, 1, 'FPBasic', 1, '2023-09-01');

--
-- Disparadores `estudiants`
--
DROP TRIGGER IF EXISTS `estudiantHistoric`;
DELIMITER $$
CREATE TRIGGER `estudiantHistoric` AFTER UPDATE ON `estudiants` FOR EACH ROW BEGIN
    DECLARE fin BOOLEAN DEFAULT FALSE;

    IF OLD.actiu = TRUE AND NEW.actiu = FALSE THEN

        SELECT MIN(er.nota) >= 5
        INTO fin
        FROM estudiants_ras er
        WHERE er.nia = NEW.nia;

        INSERT INTO historic_estudiants (nia, nom_cicle, finalitzat, data_inici, data_fi)
        VALUES (NEW.nia, NEW.nom_cicle, fin, NEW.data_inici, CURDATE());

        DELETE FROM estudiants WHERE nia = NEW.nia;

    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiants_ras`
--

DROP TABLE IF EXISTS `estudiants_ras`;
CREATE TABLE `estudiants_ras` (
  `id` int(11) NOT NULL,
  `id_ra` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nota` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiants_ras`
--

INSERT INTO `estudiants_ras` (`id`, `id_ra`, `nia`, `nota`) VALUES
(1, 1, 10001, 9),
(2, 2, 10002, 8),
(3, 3, 10003, 7),
(4, 4, 10004, 10),
(5, 5, 10005, 4),
(6, 6, 10006, 9),
(7, 7, 10007, 8),
(8, 8, 10008, 7),
(9, 9, 10009, 10),
(10, 10, 10010, 9);

--
-- Disparadores `estudiants_ras`
--
DROP TRIGGER IF EXISTS `promocio_fp_insert`;
DELIMITER $$
CREATE TRIGGER `promocio_fp_insert` AFTER INSERT ON `estudiants_ras` FOR EACH ROW BEGIN
    DECLARE total_ras INT;
    DECLARE aprovades INT;

    SELECT COUNT(*) INTO total_ras
    FROM estudiants_ras
    WHERE nia = NEW.nia;

    SELECT COUNT(*) INTO aprovades
    FROM estudiants_ras
    WHERE nia = NEW.nia
      AND nota >= 5;

    IF total_ras > 0 AND total_ras = aprovades THEN
        UPDATE estudiants
        SET nom_grup = REPLACE(nom_grup, '1', '2')
        WHERE nia = NEW.nia
          AND nom_grup LIKE '%1';
    END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `promocio_fp_update`;
DELIMITER $$
CREATE TRIGGER `promocio_fp_update` AFTER UPDATE ON `estudiants_ras` FOR EACH ROW BEGIN
    DECLARE total_ras INT;
    DECLARE aprovades INT;

    SELECT COUNT(*) INTO total_ras
    FROM estudiants_ras
    WHERE nia = NEW.nia;

    SELECT COUNT(*) INTO aprovades
    FROM estudiants_ras
    WHERE nia = NEW.nia
      AND nota >= 5;

    IF total_ras > 0 AND total_ras = aprovades THEN
        UPDATE estudiants
        SET grup = REPLACE(grup, '1', '2')
        WHERE nia = NEW.nia
          AND grup LIKE '%1';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grup_classe`
--

DROP TABLE IF EXISTS `grup_classe`;
CREATE TABLE `grup_classe` (
  `nom` varchar(25) NOT NULL,
  `aula` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grup_classe`
--

INSERT INTO `grup_classe` (`nom`, `aula`) VALUES
('ASIX1A', 'A101'),
('ASIX2A', 'A102'),
('DAM1A', 'A401'),
('DAM2A', 'A402'),
('DAW1A', 'A201'),
('DAW2A', 'A202'),
('FPB1A', 'A501'),
('FPB2A', 'A502'),
('SMX1A', 'A301'),
('SMX2A', 'A302');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historic_estudiants`
--

DROP TABLE IF EXISTS `historic_estudiants`;
CREATE TABLE `historic_estudiants` (
  `id` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `finalitzat` tinyint(1) NOT NULL,
  `nota_final` decimal(10,0) DEFAULT NULL,
  `data_inici` date NOT NULL,
  `data_fi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historic_estudiants`
--

INSERT INTO `historic_estudiants` (`id`, `nia`, `nom_cicle`, `finalitzat`, `nota_final`, `data_inici`, `data_fi`) VALUES
(1, 10001, 'ESO', 1, 8, '2019-09-01', '2023-06-30'),
(2, 10002, 'Batxillerat', 1, 9, '2021-09-01', '2023-06-30'),
(3, 10003, 'CFGM Informàtica', 0, NULL, '2023-09-01', NULL),
(4, 10004, 'CFGS Desenvolupament', 0, NULL, '2023-09-01', NULL),
(5, 10005, 'Cicle Administració', 1, 4, '2022-09-01', '2023-06-30'),
(6, 10006, 'Cicle Imatge', 0, NULL, '2023-09-01', NULL),
(7, 10007, 'Cicle Mecànica', 1, 7, '2022-09-01', '2023-06-30'),
(8, 10008, 'Cicle Oficina', 0, NULL, '2023-09-01', NULL),
(9, 10009, 'FP Bàsica', 1, 6, '2022-09-01', '2023-06-30'),
(10, 10010, 'Cicle Serveis', 0, NULL, '2023-09-01', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historic_fct`
--

DROP TABLE IF EXISTS `historic_fct`;
CREATE TABLE `historic_fct` (
  `id` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `empreses` varchar(256) NOT NULL,
  `hores` int(11) NOT NULL,
  `finalitzat` tinyint(1) NOT NULL,
  `observacions` varchar(256) NOT NULL,
  `incidencies` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historic_fct`
--

INSERT INTO `historic_fct` (`id`, `nia`, `empreses`, `hores`, `finalitzat`, `observacions`, `incidencies`) VALUES
(1, 10003, 'Empresa C', 120, 0, 'Inici de pràctiques', ''),
(2, 10004, 'Empresa D', 150, 0, 'Inici de pràctiques', ''),
(3, 10006, 'Empresa F', 200, 1, 'Pràctiques acabades correctament', ''),
(4, 10007, 'Empresa G', 180, 1, 'Pràctiques acabades amb èxit', ''),
(5, 10008, 'Empresa H', 100, 0, 'En procés de pràctiques', ''),
(6, 10009, 'Empresa I', 220, 1, 'Pràctiques completades', ''),
(7, 10010, 'Empresa J', 140, 0, 'Pràctiques en curs', 'Retard en entrega de documents'),
(8, 10003, 'Empresa K', 120, 1, 'Pràctiques finalitzades', 'Incidència menor'),
(9, 10004, 'Empresa L', 150, 1, 'Pràctiques acabades', ''),
(10, 10006, 'Empresa M', 200, 0, 'Pràctiques en curs', 'Falta supervisió');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historic_professors`
--

DROP TABLE IF EXISTS `historic_professors`;
CREATE TABLE `historic_professors` (
  `id` int(11) NOT NULL,
  `codi_prof` varchar(20) NOT NULL,
  `tipus` varchar(50) NOT NULL,
  `motius` varchar(125) NOT NULL,
  `justificat` tinyint(1) NOT NULL,
  `justificant` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historic_professors`
--

INSERT INTO `historic_professors` (`id`, `codi_prof`, `tipus`, `motius`, `justificat`, `justificant`) VALUES
(1, 'PROF001', 'Baixa', 'Malaltia', 1, 'Informe mèdic'),
(2, 'PROF002', 'Permís', 'Assumptes personals', 1, 'Sol·licitud aprovada'),
(3, 'PROF003', 'Retard', 'Trànsit', 0, ''),
(4, 'PROF004', 'Baixa', 'Cita mèdica', 1, 'Certificat mèdic'),
(5, 'PROF005', 'Permís', 'Formació', 1, 'Justificant curs'),
(6, 'PROF006', 'Retard', 'Problemes familiars', 0, ''),
(7, 'PROF007', 'Baixa', 'Vacances', 1, 'Sol·licitud aprovada'),
(8, 'PROF008', 'Permís', 'Entrevista', 1, 'Carta empresa'),
(9, 'PROF009', 'Retard', 'Transport públic', 0, ''),
(10, 'PROF010', 'Baixa', 'Malaltia', 1, 'Informe mèdic');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_consultes`
--

DROP TABLE IF EXISTS `logs_consultes`;
CREATE TABLE `logs_consultes` (
  `id` int(11) NOT NULL,
  `token` int(11) NOT NULL,
  `consulta` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logs_consultes`
--

INSERT INTO `logs_consultes` (`id`, `token`, `consulta`) VALUES
(1, 1, 'Visualizó datos del estudiante 10001'),
(2, 2, 'Intentó acceso a notas del estudiante 10002'),
(3, 3, 'Actualizó asignatura ASIG003'),
(4, 4, 'Descargó informe de asistencia grupo 1rA'),
(5, 5, 'Consultó horario de DAM1A'),
(6, 6, 'Registró sesión FCT del estudiante 10006'),
(7, 7, 'Modificó contrato del profesor PROF007'),
(8, 8, 'Visualizó histórico de estudiantes repetidores'),
(9, 9, 'Consultó notas de la asignatura ASIG009'),
(10, 10, 'Registró incidencia en prácticas del estudiante 10010'),
(11, 11, 'Visualizó lista de usuarios activos'),
(12, 12, 'Intentó acceso a datos confidenciales'),
(13, 13, 'Actualizó asignatura ASIG013'),
(14, 14, 'Descargó informe de asistencia grupo DAW2A'),
(15, 15, 'Consultó horario de CFGM Informàtica'),
(16, 16, 'Registró sesión FCT del estudiante 10016'),
(17, 17, 'Modificó contrato del profesor PROF017'),
(18, 18, 'Visualizó histórico de estudiantes repetidores'),
(19, 19, 'Consultó notas de la asignatura ASIG019'),
(20, 20, 'Registró incidencia en prácticas del estudiante 10020'),
(21, 21, 'Visualizó lista de usuarios activos'),
(22, 22, 'Intentó acceso a datos confidenciales'),
(23, 23, 'Actualizó asignatura ASIG023'),
(24, 24, 'Descargó informe de asistencia grupo 1rB'),
(25, 25, 'Consultó horario de DAW1A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_login`
--

DROP TABLE IF EXISTS `logs_login`;
CREATE TABLE `logs_login` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `ip` int(12) NOT NULL,
  `login` tinyint(1) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logs_login`
--

INSERT INTO `logs_login` (`id`, `id_user`, `ip`, `login`, `data`) VALUES
(1, 1, 2147483647, 1, '2025-11-20 08:15:00'),
(2, 2, 2147483647, 0, '2025-11-20 08:20:00'),
(3, 3, 2147483647, 1, '2025-11-20 08:25:00'),
(4, 4, 2147483647, 1, '2025-11-20 08:30:00'),
(5, 5, 2147483647, 0, '2025-11-20 08:35:00'),
(6, 6, 2147483647, 1, '2025-11-20 08:40:00'),
(7, 7, 2147483647, 1, '2025-11-20 08:45:00'),
(8, 8, 2147483647, 0, '2025-11-20 08:50:00'),
(9, 9, 2147483647, 1, '2025-11-20 08:55:00'),
(10, 10, 2147483647, 1, '2025-11-20 09:00:00'),
(11, 11, 2147483647, 1, '2025-11-20 09:05:00'),
(12, 12, 2147483647, 0, '2025-11-20 09:10:00'),
(13, 13, 2147483647, 1, '2025-11-20 09:15:00'),
(14, 14, 2147483647, 1, '2025-11-20 09:20:00'),
(15, 15, 2147483647, 0, '2025-11-20 09:25:00'),
(16, 16, 2147483647, 1, '2025-11-20 09:30:00'),
(17, 17, 2147483647, 1, '2025-11-20 09:35:00'),
(18, 18, 2147483647, 0, '2025-11-20 09:40:00'),
(19, 19, 2147483647, 1, '2025-11-20 09:45:00'),
(20, 20, 2147483647, 1, '2025-11-20 09:50:00'),
(21, 21, 2147483647, 1, '2025-11-20 09:55:00'),
(22, 22, 2147483647, 0, '2025-11-20 10:00:00'),
(23, 23, 2147483647, 1, '2025-11-20 10:05:00'),
(24, 24, 2147483647, 1, '2025-11-20 10:10:00'),
(25, 25, 2147483647, 0, '2025-11-20 10:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persones`
--

DROP TABLE IF EXISTS `persones`;
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
  `ruta_foto` varchar(125) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persones`
--

INSERT INTO `persones` (`dni`, `nom`, `cognom`, `data_naix`, `poblacio`, `codi_postal`, `nacionalitat`, `municipi_naix`, `telf_mob`, `telf_fix`, `email`, `ruta_foto`) VALUES
('10111213U', 'Biel', 'Pascual Serra', '2005-08-02', 'Lleida', 25001, 'Espanyola', 'Lleida', 690112233, 973112233, 'biel.pascual@alumne.com', 'img/alum09.jpg'),
('11223344K', 'Eva', 'Torres Prat', '1987-06-14', 'Manresa', 8240, 'Espanyola', 'Manresa', 611223344, 938223344, 'eva.torres@centre.com', 'img/prof10.jpg'),
('12131415V', 'Emma', 'Vidal Torres', '2006-01-30', 'Manresa', 8240, 'Espanyola', 'Manresa', 691223344, 938223344, 'emma.vidal@alumne.com', 'img/alum10.jpg'),
('12345678A', 'Marc', 'Serra Puig', '1980-04-12', 'Barcelona', 8001, 'Espanyola', 'Barcelona', 612345678, 934567890, 'marc.serra@centre.com', 'img/prof01.jpg'),
('13141516W', 'Joan', 'Garriga Pons', '1970-05-11', 'Barcelona', 8002, 'Espanyola', 'Barcelona', 612334455, 934334455, 'joan.garriga@admin.com', 'img/admin01.jpg'),
('14151617X', 'Rosa', 'Molina Casals', '1968-10-08', 'Sabadell', 8203, 'Espanyola', 'Sabadell', 623445566, 937445566, 'rosa.molina@admin.com', 'img/admin02.png'),
('15161718Y', 'Albert', 'Ferrer Dalmau', '1972-01-27', 'Terrassa', 8222, 'Espanyola', 'Terrassa', 634556677, 937556677, 'albert.ferrer@admin.com', 'img/admin03.jpg'),
('16171819Z', 'Sílvia', 'Guardiola Vives', '1974-03-19', 'Girona', 17001, 'Espanyola', 'Girona', 645667788, 972667788, 'silvia.guardiola@admin.com', 'img/admin04.jpg'),
('17181920A', 'Ramon', 'Casals Vidal', '1969-09-03', 'Reus', 43201, 'Espanyola', 'Reus', 656778899, 977778899, 'ramon.casals@admin.com', 'img/admin05.jpg'),
('18192021B', 'Teresa', 'Roca Gallart', '1973-11-29', 'Lleida', 25001, 'Espanyola', 'Lleida', 667889900, 973889900, 'teresa.roca@admin.com', 'img/admin06.jpg'),
('19202122C', 'Francesc', 'Alba Puig', '1971-02-14', 'Manresa', 8240, 'Espanyola', 'Manresa', 678990011, 938990011, 'francesc.alba@admin.com', 'img/admin07.jpg'),
('20212223D', 'Helena', 'Vallès Mora', '1967-07-22', 'Badalona', 8911, 'Espanyola', 'Badalona', 689001122, 935001122, 'helena.valles@admin.com', 'img/admin08.jpg'),
('21222324E', 'Ricard', 'Solé Font', '1970-04-06', 'Mataró', 8301, 'Espanyola', 'Mataró', 690112244, 937112244, 'ricard.sole@admin.com', 'img/admin09.jpg'),
('22232425F', 'Lluïsa', 'Padró Estany', '1968-12-13', 'Cornellà', 8940, 'Espanyola', 'Cornellà', 691223355, 933223355, 'lluisa.padro@admin.com', 'img/admin10.jpg'),
('22334455L', 'Pol', 'Gómez Ruiz', '2005-02-18', 'Barcelona', 8015, 'Espanyola', 'Barcelona', 612112233, 934112233, 'pol.gomez@alumne.com', 'img/alum01.jpg'),
('23456789B', 'Anna', 'Ribas Soler', '1975-09-23', 'Girona', 17001, 'Espanyola', 'Girona', 622334455, 972334455, 'anna.ribas@centre.com', 'img/prof02.jpg'),
('33445566M', 'Aina', 'Martí Soler', '2006-11-05', 'Cornellà', 8940, 'Espanyola', 'Cornellà', 623221144, 933221144, 'aina.marti@alumne.com', 'img/alum02.jpg'),
('34567890C', 'Jordi', 'Casas Vila', '1982-01-15', 'Tarragona', 43001, 'Espanyola', 'Tarragona', 633221144, 977221144, 'jordi.casas@centre.com', 'img/prof03.jpg'),
('44556677N', 'Nil', 'Costa Riba', '2004-07-23', 'Sabadell', 8201, 'Espanyola', 'Sabadell', 634443322, 937443322, 'nil.costa@alumne.com', 'img/alum03.jpg'),
('45678901D', 'Marta', 'Puig Ferrer', '1978-11-04', 'Lleida', 25001, 'Espanyola', 'Lleida', 644552211, 973552211, 'marta.puig@centre.com', 'img/prof04.jpg'),
('55548601J', 'Nami', 'Diakite', '0000-00-00', '-', 0, '-', '-', 111111111, 111111111, 'admin@gmail.com', '-'),
('55667788P', 'Laia', 'Romero Gil', '2005-09-14', 'Terrassa', 8222, 'Espanyola', 'Terrassa', 645554433, 937554433, 'laia.romero@alumne.com', 'img/alum04.jpg'),
('56789012E', 'Pere', 'Anton López', '1985-03-29', 'Badalona', 8911, 'Espanyola', 'Badalona', 655441122, 935441122, 'pere.anton@centre.com', 'img/prof05.jpg'),
('66778899Q', 'Jan', 'Navarro Puig', '2006-03-09', 'Badalona', 8911, 'Espanyola', 'Badalona', 656665544, 935665544, 'jan.navarro@alumne.com', 'img/alum05.jpg'),
('67890123F', 'Laura', 'Sánchez Mora', '1979-07-08', 'Sabadell', 8201, 'Espanyola', 'Sabadell', 666332211, 937332211, 'laura.sanchez@centre.com', 'img/prof06.jpg'),
('77889900R', 'Clara', 'Ortiz Vila', '2004-12-27', 'Girona', 17001, 'Espanyola', 'Girona', 667776655, 972776655, 'clara.ortiz@alumne.com', 'img/alum06.jpg'),
('78901234G', 'Carles', 'Domènech Roca', '1983-12-19', 'Terrassa', 8222, 'Espanyola', 'Terrassa', 677221133, 937221133, 'carles.domenech@centre.com', 'img/prof07.jpg'),
('88990011S', 'Eric', 'Soler Llorens', '2005-04-11', 'Mataró', 8301, 'Espanyola', 'Mataró', 678887766, 937887766, 'eric.soler@alumne.com', 'img/alum07.jpg'),
('89012345H', 'Núria', 'Pérez Vidal', '1981-05-17', 'Mataró', 8301, 'Espanyola', 'Mataró', 688441122, 937441122, 'nuria.perez@centre.com', 'img/prof08.jpg'),
('90123456J', 'Xavier', 'Font Mir', '1974-10-30', 'Reus', 43201, 'Espanyola', 'Reus', 699554433, 977554433, 'xavier.font@centre.com', 'img/prof09.jpg'),
('99001122T', 'Iris', 'Reig Amat', '2006-10-21', 'Reus', 43201, 'Espanyola', 'Reus', 689998877, 977998877, 'iris.reig@alumne.com', 'img/alum08.jpg');

--
-- Disparadores `persones`
--
DROP TRIGGER IF EXISTS `generarUsuari`;
DELIMITER $$
CREATE TRIGGER `generarUsuari` AFTER INSERT ON `persones` FOR EACH ROW BEGIN
    DECLARE usernameBase VARCHAR(50);
    DECLARE usernameFinal VARCHAR(50);
    DECLARE cont INT DEFAULT 0;

    -- username = primera letra del nombre + apellido, en minúsculas
    SET usernameBase = CONCAT(
        LOWER(LEFT(NEW.nom, 1)),
        LOWER(NEW.cognom)
    );

    SET usernameFinal = usernameBase;

    -- Evitar usernames duplicados
    WHILE EXISTS (
        SELECT 1 FROM usuaris WHERE username = usernameFinal
    ) DO
        SET cont = cont + 1;
        SET usernameFinal = CONCAT(usernameBase, cont);
    END WHILE;

    -- Crear usuario SIN contraseña
    INSERT INTO usuaris (username, dni)
    VALUES (usernameFinal, NEW.dni);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `valid_email`;
DELIMITER $$
CREATE TRIGGER `valid_email` BEFORE INSERT ON `persones` FOR EACH ROW BEGIN
	IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$' THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'email no vàlid';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `professors`
--

DROP TABLE IF EXISTS `professors`;
CREATE TABLE `professors` (
  `codi_prof` varchar(20) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `dedicacio` enum('professor','tutor de grup','tutor FCT','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `professors`
--

INSERT INTO `professors` (`codi_prof`, `dni`, `dedicacio`) VALUES
('PROF001', '12345678A', 'professor'),
('PROF002', '23456789B', 'tutor de grup'),
('PROF003', '34567890C', 'professor'),
('PROF004', '45678901D', 'tutor FCT'),
('PROF005', '56789012E', 'professor'),
('PROF006', '67890123F', 'tutor de grup'),
('PROF007', '78901234G', 'professor'),
('PROF008', '89012345H', 'tutor FCT'),
('PROF009', '90123456J', 'professor'),
('PROF010', '11223344K', 'tutor de grup');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prof_assignatura`
--

DROP TABLE IF EXISTS `prof_assignatura`;
CREATE TABLE `prof_assignatura` (
  `id` int(11) NOT NULL,
  `id_codiprof` varchar(20) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prof_assignatura`
--

INSERT INTO `prof_assignatura` (`id`, `id_codiprof`, `id_assignatura`) VALUES
(1, 'PROF001', 'ASIG001'),
(2, 'PROF002', 'ASIG002'),
(3, 'PROF003', 'ASIG003'),
(4, 'PROF004', 'ASIG004'),
(5, 'PROF005', 'ASIG005'),
(6, 'PROF006', 'ASIG006'),
(7, 'PROF007', 'ASIG007'),
(8, 'PROF008', 'ASIG008'),
(9, 'PROF009', 'ASIG009'),
(10, 'PROF010', 'ASIG010');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ras`
--

DROP TABLE IF EXISTS `ras`;
CREATE TABLE `ras` (
  `id` int(11) NOT NULL,
  `codi_assignatura` varchar(25) NOT NULL,
  `data_inici` date NOT NULL,
  `data_fin` date NOT NULL,
  `nota` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ras`
--

INSERT INTO `ras` (`id`, `codi_assignatura`, `data_inici`, `data_fin`, `nota`) VALUES
(1, 'ASIG001', '2023-09-01', '2023-09-30', 9),
(2, 'ASIG002', '2023-09-01', '2023-09-30', 8),
(3, 'ASIG003', '2023-09-01', '2023-09-30', 7),
(4, 'ASIG004', '2023-09-01', '2023-09-30', 10),
(5, 'ASIG005', '2023-09-01', '2023-09-30', 4),
(6, 'ASIG006', '2023-09-01', '2023-09-30', 9),
(7, 'ASIG007', '2023-09-01', '2023-09-30', 8),
(8, 'ASIG008', '2023-09-01', '2023-09-30', 7),
(9, 'ASIG009', '2023-09-01', '2023-09-30', 10),
(10, 'ASIG010', '2023-09-01', '2023-09-30', 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `token` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `username` varchar(11) NOT NULL,
  `data_inici` date NOT NULL,
  `data_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`token`, `id_user`, `username`, `data_inici`, `data_fin`) VALUES
(1, 1, 'MarcS', '2025-11-01', '2025-11-01'),
(2, 2, 'AnnaR', '2025-11-02', NULL),
(3, 3, 'JordiC', '2025-11-03', '2025-11-03'),
(4, 4, 'MartaP', '2025-11-04', NULL),
(5, 5, 'PereA', '2025-11-05', '2025-11-05'),
(6, 6, 'LauraS', '2025-11-06', NULL),
(7, 7, 'CarlesD', '2025-11-07', '2025-11-07'),
(8, 8, 'NúriaP', '2025-11-08', NULL),
(9, 9, 'XavierF', '2025-11-09', '2025-11-09'),
(10, 10, 'EvaT', '2025-11-10', NULL),
(11, 11, 'PolG', '2025-11-11', '2025-11-11'),
(12, 12, 'AinaM', '2025-11-12', NULL),
(13, 13, 'NilC', '2025-11-13', '2025-11-13'),
(14, 14, 'LaiaR', '2025-11-14', NULL),
(15, 15, 'JanN', '2025-11-15', '2025-11-15'),
(16, 16, 'ClaraO', '2025-11-16', NULL),
(17, 17, 'EricS', '2025-11-17', '2025-11-17'),
(18, 18, 'IrisR', '2025-11-18', NULL),
(19, 19, 'BielP', '2025-11-19', '2025-11-19'),
(20, 20, 'EmmaV', '2025-11-20', NULL),
(21, 21, 'JoanG', '2025-11-21', '2025-11-21'),
(22, 22, 'RosaM', '2025-11-22', NULL),
(23, 23, 'AlbertF', '2025-11-23', '2025-11-23'),
(24, 24, 'SílviaG', '2025-11-24', NULL),
(25, 25, 'RamonC', '2025-11-25', '2025-11-25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuaris`
--

DROP TABLE IF EXISTS `usuaris`;
CREATE TABLE `usuaris` (
  `id_user` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `username` varchar(11) NOT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuaris`
--

INSERT INTO `usuaris` (`id_user`, `dni`, `username`, `password`) VALUES
(1, '12345678A', 'MarcS', ''),
(2, '23456789B', 'AnnaR', ''),
(3, '34567890C', 'JordiC', ''),
(4, '45678901D', 'MartaP', ''),
(5, '56789012E', 'PereA', ''),
(6, '67890123F', 'LauraS', ''),
(7, '78901234G', 'CarlesD', ''),
(8, '89012345H', 'NúriaP', ''),
(9, '90123456J', 'XavierF', ''),
(10, '11223344K', 'EvaT', ''),
(11, '22334455L', 'PolG', ''),
(12, '33445566M', 'AinaM', ''),
(13, '44556677N', 'NilC', ''),
(14, '55667788P', 'LaiaR', ''),
(15, '66778899Q', 'JanN', ''),
(16, '77889900R', 'ClaraO', ''),
(17, '88990011S', 'EricS', ''),
(18, '99001122T', 'IrisR', ''),
(19, '10111213U', 'BielP', ''),
(20, '12131415V', 'EmmaV', ''),
(21, '13141516W', 'JoanG', ''),
(22, '14151617X', 'RosaM', ''),
(23, '15161718Y', 'AlbertF', ''),
(24, '16171819Z', 'SílviaG', ''),
(25, '17181920A', 'RamonC', ''),
(26, '18192021B', 'TeresaR', 'b66e2c4b22c5d7dfe2b5'),
(27, '19202122C', 'FrancescA', ''),
(28, '20212223D', 'HelenaV', ''),
(29, '21222324E', 'RicardS', 'e88794475313fbacc133'),
(30, '22232425F', 'LluïsaP', ''),
(31, '55548601J', 'ndiakite', '$2y$10$i2UAj45cN/0yWxg6U1z97.aNqd569lmD49wc5B6rQykDWQTb9Ky3u');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administradors`
--
ALTER TABLE `administradors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_admindni` (`dni`),
  ADD KEY `fk_adminuser` (`id_user`);

--
-- Indices de la tabla `admin_centre`
--
ALTER TABLE `admin_centre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_adminid` (`admin_id`),
  ADD KEY `fk_codicentre` (`codi_centre`);

--
-- Indices de la tabla `assignatures`
--
ALTER TABLE `assignatures`
  ADD PRIMARY KEY (`codi`);

--
-- Indices de la tabla `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_nomcicle` (`nom_cicle`),
  ADD KEY `fk_cicleassignatura` (`id_assignatura`);

--
-- Indices de la tabla `assistencia`
--
ALTER TABLE `assistencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_codiprofeass` (`codi_prof`),
  ADD KEY `fk_codiass` (`id_assignatura`),
  ADD KEY `fk_nomgrup` (`nom_grup`);

--
-- Indices de la tabla `centres`
--
ALTER TABLE `centres`
  ADD PRIMARY KEY (`codi`);

--
-- Indices de la tabla `cicles`
--
ALTER TABLE `cicles`
  ADD PRIMARY KEY (`nom`);

--
-- Indices de la tabla `contractes`
--
ALTER TABLE `contractes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_codip` (`codi_prof`),
  ADD KEY `fk_codic` (`codi_centre`);

--
-- Indices de la tabla `directiva`
--
ALTER TABLE `directiva`
  ADD PRIMARY KEY (`rol`),
  ADD KEY `fk_codiprof` (`codi_prof`);

--
-- Indices de la tabla `estudiants`
--
ALTER TABLE `estudiants`
  ADD PRIMARY KEY (`nia`),
  ADD KEY `fk_dnies` (`dni`),
  ADD KEY `fk_nomgrupes` (`nom_grup`),
  ADD KEY `fk_cicles` (`nom_cicle`) USING BTREE;

--
-- Indices de la tabla `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idra` (`id_ra`),
  ADD KEY `fk_niaa` (`nia`);

--
-- Indices de la tabla `grup_classe`
--
ALTER TABLE `grup_classe`
  ADD PRIMARY KEY (`nom`);

--
-- Indices de la tabla `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_niaes` (`nia`),
  ADD KEY `fk_nomciclee` (`nom_cicle`);

--
-- Indices de la tabla `historic_fct`
--
ALTER TABLE `historic_fct`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_niah` (`nia`);

--
-- Indices de la tabla `historic_professors`
--
ALTER TABLE `historic_professors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_codipr` (`codi_prof`);

--
-- Indices de la tabla `logs_consultes`
--
ALTER TABLE `logs_consultes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_token` (`token`);

--
-- Indices de la tabla `logs_login`
--
ALTER TABLE `logs_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_iduserl` (`id_user`);

--
-- Indices de la tabla `persones`
--
ALTER TABLE `persones`
  ADD PRIMARY KEY (`dni`),
  ADD KEY `dni` (`dni`);

--
-- Indices de la tabla `professors`
--
ALTER TABLE `professors`
  ADD PRIMARY KEY (`codi_prof`),
  ADD KEY `fk_dniprof` (`dni`);

--
-- Indices de la tabla `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_codiprofe` (`id_codiprof`),
  ADD KEY `fk_idassignatura` (`id_assignatura`);

--
-- Indices de la tabla `ras`
--
ALTER TABLE `ras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assignaturaid` (`codi_assignatura`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`token`),
  ADD KEY `fk_iduser` (`id_user`);

--
-- Indices de la tabla `usuaris`
--
ALTER TABLE `usuaris`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `fk_usuaridni` (`dni`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administradors`
--
ALTER TABLE `administradors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `admin_centre`
--
ALTER TABLE `admin_centre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `assistencia`
--
ALTER TABLE `assistencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `contractes`
--
ALTER TABLE `contractes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `historic_fct`
--
ALTER TABLE `historic_fct`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `historic_professors`
--
ALTER TABLE `historic_professors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `logs_consultes`
--
ALTER TABLE `logs_consultes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `logs_login`
--
ALTER TABLE `logs_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `ras`
--
ALTER TABLE `ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuaris`
--
ALTER TABLE `usuaris`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administradors`
--
ALTER TABLE `administradors`
  ADD CONSTRAINT `fk_admindni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_adminuser` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `admin_centre`
--
ALTER TABLE `admin_centre`
  ADD CONSTRAINT `fk_adminid` FOREIGN KEY (`admin_id`) REFERENCES `administradors` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_codicentre` FOREIGN KEY (`codi_centre`) REFERENCES `centres` (`codi`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  ADD CONSTRAINT `fk_cicleassignatura` FOREIGN KEY (`id_assignatura`) REFERENCES `assignatures` (`codi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomcicle` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `assistencia`
--
ALTER TABLE `assistencia`
  ADD CONSTRAINT `fk_codiass` FOREIGN KEY (`id_assignatura`) REFERENCES `assignatures` (`codi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_codiprofeass` FOREIGN KEY (`codi_prof`) REFERENCES `professors` (`codi_prof`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomgrup` FOREIGN KEY (`nom_grup`) REFERENCES `grup_classe` (`nom`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `contractes`
--
ALTER TABLE `contractes`
  ADD CONSTRAINT `fk_codic` FOREIGN KEY (`codi_centre`) REFERENCES `centres` (`codi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_codip` FOREIGN KEY (`codi_prof`) REFERENCES `professors` (`codi_prof`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `directiva`
--
ALTER TABLE `directiva`
  ADD CONSTRAINT `fk_codiprof` FOREIGN KEY (`codi_prof`) REFERENCES `professors` (`codi_prof`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `estudiants`
--
ALTER TABLE `estudiants`
  ADD CONSTRAINT `fk_ciclees` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dnies` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomgrupes` FOREIGN KEY (`nom_grup`) REFERENCES `grup_classe` (`nom`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  ADD CONSTRAINT `fk_idra` FOREIGN KEY (`id_ra`) REFERENCES `ras` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_niaa` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  ADD CONSTRAINT `fk_niaes` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomciclee` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `historic_fct`
--
ALTER TABLE `historic_fct`
  ADD CONSTRAINT `fk_niah` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `historic_professors`
--
ALTER TABLE `historic_professors`
  ADD CONSTRAINT `fk_codipr` FOREIGN KEY (`codi_prof`) REFERENCES `professors` (`codi_prof`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `logs_consultes`
--
ALTER TABLE `logs_consultes`
  ADD CONSTRAINT `fk_token` FOREIGN KEY (`token`) REFERENCES `sessions` (`token`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `logs_login`
--
ALTER TABLE `logs_login`
  ADD CONSTRAINT `fk_iduserl` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `professors`
--
ALTER TABLE `professors`
  ADD CONSTRAINT `fk_dniprof` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  ADD CONSTRAINT `fk_codiprofe` FOREIGN KEY (`id_codiprof`) REFERENCES `professors` (`codi_prof`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_idassignatura` FOREIGN KEY (`id_assignatura`) REFERENCES `assignatures` (`codi`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ras`
--
ALTER TABLE `ras`
  ADD CONSTRAINT `fk_assignaturaid` FOREIGN KEY (`codi_assignatura`) REFERENCES `assignatures` (`codi`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `fk_iduser` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuaris`
--
ALTER TABLE `usuaris`
  ADD CONSTRAINT `fk_usuaridni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
