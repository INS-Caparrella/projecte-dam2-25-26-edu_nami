-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Temps de generació: 06-05-2026 a les 01:36:22
-- Versió del servidor: 10.4.32-MariaDB
-- Versió de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de dades: `projecte_evalis`
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
    FROM persones p JOIN estudiants e ON e.dni = p.dni
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
      AND l.data BETWEEN rang1 AND rang2;

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
-- Estructura de la taula `acta_avaluacio`
--

CREATE TABLE `acta_avaluacio` (
  `id` int(11) NOT NULL,
  `id_assignatura` varchar(20) NOT NULL,
  `nom_grup` varchar(20) NOT NULL,
  `trimestre` int(11) NOT NULL,
  `curs` varchar(9) NOT NULL,
  `obert_per` varchar(9) NOT NULL,
  `data_obertura` datetime NOT NULL,
  `data_tancament` datetime NOT NULL,
  `corregida` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `acta_avaluacio`
--

INSERT INTO `acta_avaluacio` (`id`, `id_assignatura`, `nom_grup`, `trimestre`, `curs`, `obert_per`, `data_obertura`, `data_tancament`, `corregida`) VALUES
(1, 'MP06', 'DAM2A', 1, '2026-2027', '12345678A', '2024-09-01 08:00:00', '2024-12-20 23:59:59', 0),
(2, 'MP07', 'DAM2A', 1, '2026-2027', '12345678A', '2024-09-01 08:00:00', '2024-12-20 23:59:59', 1),
(3, 'MP06', 'DAM2A', 2, '2026-2027', '12345678A', '2025-01-08 08:00:00', '2025-01-08 08:00:00', 0),
(4, 'MP08', 'DAM2A', 1, '2026-2027', '23456789B', '2024-09-01 08:00:00', '2024-12-20 23:59:59', 0),
(5, 'MP04', 'DAW1A', 1, '2026-2027', '11223344K', '2026-05-05 23:08:49', '2026-05-05 23:08:49', 0),
(6, 'MP07', 'DAW1A', 2, '2026-2027', '11223344K', '2026-05-05 23:27:05', '2026-05-05 23:27:05', 0),
(7, 'MP06', 'DAM1A', 1, '2026-2027', '12345678A', '2026-05-05 23:36:08', '2026-05-05 23:36:08', 0),
(8, 'MP14', 'CI2A', 2, '2026-2027', '11223344K', '2026-05-05 23:46:46', '2026-05-05 23:46:46', 0),
(9, 'MP07', 'DAW1A', 1, '2026-2027', '11223344K', '2026-05-05 23:47:15', '2026-05-05 23:47:15', 1),
(10, 'MP04', 'DAW2A', 1, '2026-2027', '11223344K', '2026-05-06 00:22:59', '2026-05-06 00:22:59', 0);

-- --------------------------------------------------------

--
-- Estructura de la taula `acta_notes`
--

CREATE TABLE `acta_notes` (
  `id` int(11) NOT NULL,
  `id_acta` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nota_final` decimal(10,0) NOT NULL,
  `repetidor` tinyint(1) NOT NULL,
  `treballant` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `acta_notes`
--

INSERT INTO `acta_notes` (`id`, `id_acta`, `nia`, `nota_final`, `repetidor`, `treballant`) VALUES
(1, 1, 1001, 8, 0, 0),
(2, 1, 1002, 8, 0, 0),
(3, 1, 1011, 6, 1, 0),
(4, 1, 1016, 9, 0, 0),
(5, 1, 1021, 6, 0, 1),
(6, 1, 1028, 7, 0, 0),
(7, 2, 1001, 9, 0, 0),
(8, 2, 1002, 8, 0, 0),
(9, 2, 1011, 4, 1, 0),
(10, 2, 1016, 9, 0, 0),
(11, 2, 1021, 7, 0, 1),
(12, 2, 1028, 6, 0, 0),
(13, 3, 1001, 8, 0, 0),
(14, 3, 1002, 8, 0, 0),
(15, 3, 1016, 9, 0, 0),
(16, 3, 1021, 6, 0, 1),
(17, 4, 1001, 7, 0, 0),
(18, 4, 1002, 8, 0, 0),
(19, 4, 1011, 6, 1, 0),
(20, 4, 1016, 8, 0, 0),
(21, 4, 1021, 5, 0, 1),
(22, 4, 1028, 6, 0, 0),
(23, 3, 1011, 5, 1, 0),
(24, 3, 1028, 7, 0, 0),
(25, 3, 1029, 6, 1, 0),
(26, 6, 1011, 7, 1, 0),
(27, 6, 1029, 5, 1, 0),
(28, 6, 1022, 9, 0, 0),
(29, 6, 1028, 6, 0, 0),
(30, 6, 1001, 8, 0, 0),
(31, 6, 1021, 7, 0, 1),
(32, 6, 1002, 8, 0, 0),
(33, 6, 1016, 9, 0, 0),
(34, 3, 1003, 4, 0, 0),
(35, 9, 1011, 7, 1, 0);

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

--
-- Bolcament de dades per a la taula `administradors`
--

INSERT INTO `administradors` (`id`, `dni`, `id_user`, `dades`, `superadmin`) VALUES
(21, '11223344K', 41, 1, 1),
(32, '12345678A', 32, 1, 0),
(33, '23456789B', 33, 1, 0),
(34, '32323232G', 72, 1, 0),
(35, '33323232H', 73, 1, 0),
(36, '34323232I', 74, 1, 0),
(39, '34567890C', 34, 1, 0),
(40, '35323232J', 75, 1, 0),
(41, '36323232K', 76, 1, 0),
(42, '45678901D', 35, 1, 0),
(43, '56789012E', 36, 1, 0),
(44, '67890123F', 37, 1, 0),
(45, '78901234G', 38, 1, 0),
(46, '89012345H', 39, 1, 0),
(47, '90123456I', 40, 1, 0);

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

--
-- Bolcament de dades per a la taula `admin_centre`
--

INSERT INTO `admin_centre` (`id`, `admin_id`, `codi_centre`, `backup`) VALUES
(33, 21, 1, 1),
(34, 32, 2, 0),
(35, 33, 3, 0),
(36, 39, 4, 0),
(37, 42, 5, 0),
(38, 43, 6, 0),
(39, 44, 7, 0),
(40, 45, 8, 0),
(41, 46, 9, 0),
(42, 47, 10, 0),
(43, 34, 11, 0);

-- --------------------------------------------------------

--
-- Estructura de la taula `assignatures`
--

CREATE TABLE `assignatures` (
  `codi` varchar(25) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `departament` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `assignatures`
--

INSERT INTO `assignatures` (`codi`, `nom`, `departament`) VALUES
('MP01', 'Sistemes Operatius Monolloc', 'Informàtica'),
('MP02', 'Ofimàtica i Arxiu', 'Informàtica'),
('MP03', 'Xarxes Locals', 'Informàtica'),
('MP04', 'Aplicacions Web', 'Informàtica'),
('MP05', 'Seguretat Informàtica', 'Informàtica'),
('MP06', 'Programació', 'Informàtica'),
('MP07', 'Bases de Dades', 'Informàtica'),
('MP08', 'Desenvolupament d\'Interfícies', 'Informàtica'),
('MP09', 'Programació de Serveis i Processos', 'Informàtica'),
('MP10', 'Sistemes de Gestió Empresarial', 'Informàtica'),
('MP11', 'Gestió Empresarial', 'Administració'),
('MP12', 'Comunicació Empresarial', 'Administració'),
('MP13', 'Tractament Comptable', 'Administració'),
('MP14', 'Comerç Internacional', 'Comerç'),
('MP15', 'Logística d\'Emmagatzematge', 'Comerç');

-- --------------------------------------------------------

--
-- Estructura de la taula `assignatures_cicle`
--

CREATE TABLE `assignatures_cicle` (
  `id` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `assignatures_cicle`
--

INSERT INTO `assignatures_cicle` (`id`, `nom_cicle`, `id_assignatura`) VALUES
(1, 'FP Basica Informatica', 'MP01'),
(2, 'FP Basica Informatica', 'MP02'),
(3, 'CFGM Sistemes Microinformatics i Xarxes', 'MP01'),
(4, 'CFGM Sistemes Microinformatics i Xarxes', 'MP03'),
(5, 'CFGM Sistemes Microinformatics i Xarxes', 'MP05'),
(6, 'CFGM Gestio Administrativa', 'MP11'),
(7, 'CFGM Gestio Administrativa', 'MP12'),
(8, 'CFGM Gestio Administrativa', 'MP13'),
(9, 'CFGS Desenvolupament Aplicacions Multiplataforma', 'MP06'),
(10, 'CFGS Desenvolupament Aplicacions Multiplataforma', 'MP07'),
(11, 'CFGS Desenvolupament Aplicacions Multiplataforma', 'MP08'),
(12, 'CFGS Desenvolupament Aplicacions Multiplataforma', 'MP09'),
(13, 'CFGS Desenvolupament Aplicacions Web', 'MP04'),
(14, 'CFGS Desenvolupament Aplicacions Web', 'MP06'),
(15, 'CFGS Desenvolupament Aplicacions Web', 'MP07'),
(16, 'CFGS Administracio de Sistemes Informatics en Xarxa', 'MP03'),
(17, 'CFGS Administracio de Sistemes Informatics en Xarxa', 'MP05'),
(18, 'CFGS Administracio de Sistemes Informatics en Xarxa', 'MP10'),
(19, 'CFGS Comerce Internacional', 'MP14'),
(20, 'CFGS Comerce Internacional', 'MP15');

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

--
-- Bolcament de dades per a la taula `assistencia`
--

INSERT INTO `assistencia` (`id`, `codi_prof`, `id_assignatura`, `nom_grup`, `hora_inici`, `hora_fin`, `observacio`) VALUES
(11, 'PROF01', 'MP06', 'DAM1A', '08:00:00', '10:00:00', ''),
(12, 'PROF01', 'MP07', 'DAM2A', '10:00:00', '12:00:00', ''),
(13, 'PROF02', 'MP08', 'DAM1A', '08:00:00', '10:00:00', ''),
(14, 'PROF03', 'MP03', 'SMX1A', '08:00:00', '10:00:00', ''),
(15, 'PROF03', 'MP05', 'ASIX1A', '10:00:00', '12:00:00', ''),
(16, 'PROF04', 'MP11', 'GA1A', '08:00:00', '10:00:00', ''),
(17, 'PROF05', 'MP01', 'FPB1A', '08:00:00', '10:00:00', ''),
(18, 'PROF06', 'MP04', 'DAW1A', '08:00:00', '10:00:00', ''),
(19, 'PROF07', 'MP13', 'GA2A', '10:00:00', '12:00:00', ''),
(20, 'PROF08', 'MP14', 'CI1A', '08:00:00', '10:00:00', ''),
(21, 'PROF09', 'MP03', 'ASIX2A', '08:00:00', '10:00:00', ''),
(22, 'PROF10', 'MP06', 'DAW2A', '10:00:00', '12:00:00', ''),
(23, 'PROF01', 'MP06', 'DAM2A', '08:00:00', '10:00:00', ''),
(24, 'PROF01', 'MP07', 'DAM1A', '10:00:00', '12:00:00', ''),
(25, 'PROF02', 'MP08', 'DAM2A', '08:00:00', '10:00:00', ''),
(26, 'PROF02', 'MP09', 'DAM2A', '12:00:00', '14:00:00', ''),
(27, 'PROF03', 'MP05', 'ASIX2A', '10:00:00', '12:00:00', ''),
(28, 'PROF03', 'MP01', 'FPB2A', '08:00:00', '10:00:00', ''),
(29, 'PROF04', 'MP12', 'GA1A', '10:00:00', '12:00:00', ''),
(31, 'PROF05', 'MP02', 'FPB2A', '10:00:00', '12:00:00', ''),
(32, 'PROF06', 'MP07', 'DAW2A', '08:00:00', '10:00:00', ''),
(33, 'PROF06', 'MP10', 'ASIX2A', '12:00:00', '14:00:00', ''),
(34, 'PROF07', 'MP14', 'CI2A', '08:00:00', '10:00:00', ''),
(35, 'PROF08', 'MP15', 'CI1A', '10:00:00', '12:00:00', ''),
(37, 'PROF11', 'MP09', 'DAM1A', '12:00:00', '14:00:00', ''),
(38, 'PROF11', 'MP10', 'ASIX1A', '14:00:00', '16:00:00', ''),
(39, 'PROF12', 'MP12', 'GA2A', '12:00:00', '14:00:00', ''),
(40, 'PROF13', 'MP15', 'CI2A', '12:00:00', '14:00:00', '');

-- --------------------------------------------------------

--
-- Estructura de la taula `centres`
--

CREATE TABLE `centres` (
  `codi` int(11) NOT NULL,
  `nom` varchar(256) NOT NULL,
  `data_inaug` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `centres`
--

INSERT INTO `centres` (`codi`, `nom`, `data_inaug`) VALUES
(1, 'Institut Tècnic de Ponent', '1995-09-01'),
(2, 'Institut Jaume Balmes', '1985-09-15'),
(3, 'Institut Josep Lladonosa', '1990-09-01'),
(4, 'Institut Caparrella', '1975-09-10'),
(5, 'Institut Maria Rúbies', '2000-09-05'),
(6, 'Institut Guindàvols', '1995-09-12'),
(7, 'Institut Escola del Treball', '1960-09-20'),
(8, 'Institut Torre Vicens', '2005-09-08'),
(9, 'Institut Manyanet', '1988-09-03'),
(10, 'Institut Migdia', '1978-09-17'),
(11, 'Institut Ronda', '1998-09-14');

-- --------------------------------------------------------

--
-- Estructura de la taula `cicles`
--

CREATE TABLE `cicles` (
  `nom` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `cicles`
--

INSERT INTO `cicles` (`nom`) VALUES
('CFGM Cuina Gastronomia'),
('CFGM Electricitat'),
('CFGM Fleca Pastisseria'),
('CFGM Gestio Administrativa'),
('CFGM Mecanitzat'),
('CFGM Perruqueria'),
('CFGM Sistemes Microinformatics i Xarxes'),
('CFGS Administracio de Sistemes Informatics en Xarxa'),
('CFGS Animacions 3D'),
('CFGS Comerce Internacional'),
('CFGS Desenvolupament Aplicacions Multiplataforma'),
('CFGS Desenvolupament Aplicacions Web'),
('CFGS Educacio Infantil'),
('CFGS Guionatge'),
('CFGS Integracio Social'),
('CFGS Màrqueting Publicitat'),
('FP Basica Informatica');

-- --------------------------------------------------------

--
-- Estructura de la taula `contractes`
--

CREATE TABLE `contractes` (
  `id` int(11) NOT NULL,
  `codi_prof` varchar(20) NOT NULL,
  `codi_centre` int(11) NOT NULL,
  `data_alta` date NOT NULL,
  `data_baix` date DEFAULT NULL,
  `vinculacio_laboral` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `contractes`
--

INSERT INTO `contractes` (`id`, `codi_prof`, `codi_centre`, `data_alta`, `data_baix`, `vinculacio_laboral`) VALUES
(1, 'PROF01', 1, '2020-09-01', NULL, 'Contracte a temps complet'),
(2, 'PROF02', 1, '2019-09-01', NULL, 'Contracte a temps complet'),
(3, 'PROF03', 1, '2021-09-01', NULL, 'Contracte a temps complet'),
(4, 'PROF04', 1, '2018-09-01', NULL, 'Contracte a temps complet'),
(5, 'PROF05', 1, '2022-09-01', NULL, 'Contracte parcial'),
(6, 'PROF06', 1, '2020-09-01', NULL, 'Contracte a temps complet'),
(7, 'PROF07', 1, '2019-09-01', '2024-06-30', 'Contracte temporal'),
(8, 'PROF08', 1, '2023-09-01', NULL, 'Contracte a temps complet'),
(9, 'PROF09', 1, '2021-09-01', NULL, 'Contracte parcial'),
(10, 'PROF10', 1, '2017-09-01', NULL, 'Contracte a temps complet'),
(11, 'PROF11', 1, '2022-09-01', NULL, 'Contracte a temps complet'),
(12, 'PROF12', 1, '2021-09-01', NULL, 'Contracte a temps complet'),
(13, 'PROF13', 1, '2023-09-01', NULL, 'Contracte parcial'),
(14, 'PROF14', 1, '2020-09-01', NULL, 'Contracte a temps complet'),
(15, 'PROF15', 1, '2022-09-01', NULL, 'Contracte parcial');

-- --------------------------------------------------------

--
-- Estructura de la taula `cursos_cicle`
--

CREATE TABLE `cursos_cicle` (
  `id` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `curs` enum('1r','2n') NOT NULL,
  `hores_total` int(11) NOT NULL,
  `any_inici_referencia` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `cursos_cicle`
--

INSERT INTO `cursos_cicle` (`id`, `nom_cicle`, `curs`, `hores_total`, `any_inici_referencia`) VALUES
(1, 'CFGM Sistemes Microinformatics i Xarxes', '1r', 800, '2021'),
(2, 'CFGM Sistemes Microinformatics i Xarxes', '2n', 900, '2022'),
(3, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1000, '2023'),
(4, 'CFGS Desenvolupament Aplicacions Multiplataforma', '2n', 1100, '2024'),
(5, 'CFGS Desenvolupament Aplicacions Web', '1r', 1000, '2023'),
(6, 'CFGS Desenvolupament Aplicacions Web', '2n', 1100, '2024');

-- --------------------------------------------------------

--
-- Estructura de la taula `directiva`
--

CREATE TABLE `directiva` (
  `rol` varchar(25) NOT NULL,
  `codi_prof` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `directiva`
--

INSERT INTO `directiva` (`rol`, `codi_prof`) VALUES
('Cap d\'estudis', 'PROF01'),
('Coordinador FP', 'PROF02'),
('Cap estudis adjunt', 'PROF03'),
('Coordinador projectes', 'PROF04'),
('Coordinador innovacio', 'PROF05'),
('Cap departament Informati', 'PROF06'),
('Cap departament Administr', 'PROF07'),
('Cap departament Comerc', 'PROF08'),
('Coordinador qualitat', 'PROF09'),
('Director', 'PROF10'),
('Coordinador formacio', 'PROF11'),
('Cap estudis FP', 'PROF12'),
('Coordinador extraescolars', 'PROF13');

-- --------------------------------------------------------

--
-- Estructura de la taula `estudiants`
--

CREATE TABLE `estudiants` (
  `nia` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `nom_grup` varchar(25) NOT NULL,
  `grado` enum('1r','2n') DEFAULT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `cursant` tinyint(1) NOT NULL,
  `repetidor` tinyint(1) NOT NULL,
  `treballant` tinyint(1) NOT NULL,
  `empresa` varchar(256) NOT NULL,
  `actiu` tinyint(1) NOT NULL DEFAULT 1,
  `data_inici` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `estudiants`
--

INSERT INTO `estudiants` (`nia`, `dni`, `nom_grup`, `grado`, `nom_cicle`, `cursant`, `repetidor`, `treballant`, `empresa`, `actiu`, `data_inici`) VALUES
(1001, '11111111A', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 0, '', 1, '2024-09-01'),
(1002, '22222222B', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 0, '', 1, '2023-09-01'),
(1003, '33333333C', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 0, '', 1, '2024-09-01'),
(1004, '44444444D', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 1, 'WebCorp Lleida', 1, '2023-09-01'),
(1005, '55555555E', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 0, '', 1, '2024-09-01'),
(1006, '66666666F', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 1, 'NetSystems SL', 1, '2023-09-01'),
(1007, '77777777G', 'SMX2A', '2n', 'CFGM Sistemes Microinformatics i Xarxes', 1, 0, 0, '', 1, '2024-09-01'),
(1008, '88888888H', 'GA2A', '2n', 'CFGM Gestio Administrativa', 1, 0, 0, '', 1, '2024-09-01'),
(1009, '99999999I', 'FPB2A', '2n', 'FP Basica Informatica', 1, 0, 0, '', 1, '2024-09-01'),
(1010, '10101010J', 'CI2A', '2n', 'CFGS Comerce Internacional', 1, 0, 0, '', 1, '2024-09-01'),
(1011, '12121212L', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 1, 0, '', 1, '2023-09-01'),
(1012, '13131313M', 'DAW1A', '1r', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 0, '', 1, '2024-09-01'),
(1013, '14141414N', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 1, 'TechLleida SA', 1, '2023-09-01'),
(1014, '15151515P', 'GA2A', '2n', 'CFGM Gestio Administrativa', 1, 0, 0, '', 1, '2023-09-01'),
(1015, '16161616Q', 'SMX1A', '1r', 'CFGM Sistemes Microinformatics i Xarxes', 1, 0, 0, '', 1, '2024-09-01'),
(1016, '17171717R', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 0, '', 1, '2024-09-01'),
(1017, '18181818S', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 0, '', 1, '2024-09-01'),
(1018, '19191919T', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 0, '', 1, '2024-09-01'),
(1019, '20202020U', 'GA2A', '2n', 'CFGM Gestio Administrativa', 1, 0, 0, '', 1, '2024-09-01'),
(1020, '21212121V', 'SMX2A', '2n', 'CFGM Sistemes Microinformatics i Xarxes', 1, 0, 1, 'InfoLleida SL', 1, '2023-09-01'),
(1021, '22222223W', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 1, 'AppDev SL', 1, '2023-09-01'),
(1022, '23232323X', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 0, '', 1, '2023-09-01'),
(1023, '24242424Y', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 1, 'SysAdmin SL', 1, '2023-09-01'),
(1024, '25252525Z', 'CI2A', '2n', 'CFGS Comerce Internacional', 1, 0, 0, '', 1, '2024-09-01'),
(1025, '26262626A', 'FPB2A', '2n', 'FP Basica Informatica', 1, 0, 0, '', 1, '2024-09-01'),
(1026, '27272727B', 'GA2A', '2n', 'CFGM Gestio Administrativa', 1, 0, 0, '', 1, '2023-09-01'),
(1027, '28282828C', 'SMX2A', '2n', 'CFGM Sistemes Microinformatics i Xarxes', 1, 0, 0, '', 1, '2024-09-01'),
(1028, '29292929D', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 0, '', 1, '2024-09-01'),
(1029, '30303030E', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 1, 0, '', 1, '2024-09-01'),
(1030, '31313131F', 'CI2A', '2n', 'CFGS Comerce Internacional', 1, 0, 1, 'ComercGlobal', 1, '2023-09-01');

--
-- Disparadors `estudiants`
--
DELIMITER $$
CREATE TRIGGER `estudiantHistoric` AFTER UPDATE ON `estudiants` FOR EACH ROW BEGIN
    DECLARE fin BOOLEAN DEFAULT FALSE;

    IF OLD.actiu = TRUE AND NEW.actiu = FALSE THEN

        SELECT COALESCE(MIN(er.nota) >= 5, FALSE)
        INTO fin
        FROM estudiants_ras er
        WHERE er.nia = NEW.nia;

        INSERT INTO historic_estudiants (nia, nom_cicle, finalitzat, data_inici, data_fi)
        VALUES (NEW.nia, NEW.nom_cicle, fin, NEW.data_inici, CURDATE());

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
  `nota` decimal(10,0) NOT NULL,
  `data_inici` date NOT NULL DEFAULT '2024-09-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `estudiants_ras`
--

INSERT INTO `estudiants_ras` (`id`, `id_ra`, `nia`, `nota`, `data_inici`) VALUES
(19, 28, 1003, 6, '2024-09-01'),
(20, 28, 1004, 8, '2023-09-01'),
(21, 29, 1004, 9, '2023-09-01'),
(22, 24, 1005, 5, '2024-09-01'),
(23, 24, 1006, 8, '2023-09-01'),
(24, 25, 1006, 9, '2023-09-01'),
(25, 22, 1007, 6, '2024-09-01'),
(26, 26, 1008, 7, '2024-09-01'),
(27, 30, 1009, 5, '2024-09-01'),
(28, 32, 1010, 8, '2024-09-01'),
(81, 18, 1022, 8, '2023-09-01'),
(82, 19, 1022, 9, '2023-09-01'),
(83, 28, 1017, 6, '2024-09-01'),
(84, 28, 1022, 7, '2023-09-01'),
(85, 29, 1022, 8, '2023-09-01'),
(87, 22, 1018, 7, '2024-09-01'),
(88, 22, 1023, 9, '2023-09-01'),
(89, 23, 1023, 8, '2023-09-01'),
(90, 22, 1027, 6, '2024-09-01'),
(91, 24, 1018, 8, '2024-09-01'),
(92, 24, 1023, 7, '2023-09-01'),
(93, 25, 1023, 9, '2023-09-01'),
(94, 26, 1019, 6, '2024-09-01'),
(95, 26, 1026, 8, '2023-09-01'),
(96, 27, 1026, 7, '2023-09-01'),
(97, 30, 1025, 6, '2024-09-01'),
(98, 30, 1027, 7, '2024-09-01'),
(99, 32, 1024, 7, '2024-09-01'),
(100, 32, 1030, 8, '2023-09-01'),
(101, 33, 1030, 9, '2023-09-01'),
(105, 23, 1007, 7, '2024-09-01'),
(106, 23, 1027, 5, '2024-09-01'),
(107, 31, 1009, 7, '2024-09-01'),
(108, 31, 1025, 6, '2024-09-01'),
(118, 28, 1029, 5, '2024-09-01'),
(119, 29, 1029, 6, '2025-01-08'),
(120, 30, 1029, 7, '2024-09-01'),
(175, 15, 1001, 7, '2023-09-01'),
(176, 16, 1001, 8, '2024-01-08'),
(177, 17, 1001, 9, '2024-04-01'),
(178, 18, 1001, 7, '2023-09-01'),
(179, 19, 1001, 8, '2024-01-08'),
(180, 20, 1001, 6, '2023-09-01'),
(181, 21, 1001, 7, '2024-01-08'),
(207, 23, 1001, 7, '2021-09-01'),
(209, 25, 1001, 7, '2022-01-10'),
(211, 22, 1001, 7, '2022-09-01'),
(212, 24, 1001, 7, '2022-09-01'),
(213, 30, 1001, 7, '2023-01-09'),
(214, 15, 1001, 8, '2024-09-01'),
(215, 15, 1002, 7, '2024-09-01'),
(216, 15, 1011, 6, '2024-09-01'),
(217, 15, 1016, 9, '2024-09-01'),
(218, 15, 1021, 5, '2024-09-01'),
(219, 15, 1028, 7, '2024-09-01'),
(220, 16, 1001, 7, '2025-01-08'),
(221, 16, 1002, 8, '2025-01-08'),
(222, 16, 1011, 5, '2025-01-08'),
(223, 16, 1016, 8, '2025-01-08'),
(224, 16, 1021, 6, '2025-01-08'),
(225, 16, 1028, 6, '2025-01-08'),
(226, 18, 1001, 9, '2024-09-01'),
(227, 18, 1002, 7, '2024-09-01'),
(228, 18, 1011, 4, '2024-09-01'),
(229, 18, 1016, 8, '2024-09-01'),
(230, 18, 1021, 7, '2024-09-01'),
(231, 18, 1028, 5, '2024-09-01'),
(232, 19, 1001, 8, '2025-01-08'),
(233, 19, 1002, 9, '2025-01-08'),
(234, 19, 1011, 4, '2025-01-08'),
(235, 19, 1016, 9, '2025-01-08'),
(236, 19, 1021, 6, '2025-01-08'),
(237, 19, 1028, 7, '2025-01-08'),
(238, 17, 1001, 9, '2025-04-01'),
(239, 17, 1002, 8, '2025-04-01'),
(240, 17, 1016, 9, '2025-04-01'),
(241, 17, 1021, 7, '2025-04-01'),
(242, 20, 1001, 7, '2024-09-01'),
(243, 20, 1002, 8, '2024-09-01'),
(244, 20, 1011, 6, '2024-09-01'),
(245, 20, 1016, 8, '2024-09-01'),
(246, 20, 1021, 5, '2024-09-01'),
(247, 20, 1028, 6, '2024-09-01'),
(248, 17, 1011, 5, '2024-09-01'),
(249, 15, 1029, 10, '2024-09-01'),
(250, 16, 1029, 5, '2024-09-01'),
(251, 18, 1011, 4, '2024-09-01'),
(252, 19, 1011, 4, '2024-09-01'),
(253, 18, 1029, 4, '2024-09-01'),
(254, 18, 1022, 8, '2024-09-01'),
(255, 19, 1022, 9, '2024-09-01'),
(256, 18, 1028, 5, '2024-09-01'),
(257, 19, 1028, 7, '2024-09-01'),
(258, 18, 1001, 7, '2024-09-01'),
(259, 19, 1001, 8, '2024-09-01'),
(260, 18, 1021, 7, '2024-09-01'),
(261, 19, 1021, 6, '2024-09-01'),
(262, 18, 1002, 7, '2024-09-01'),
(263, 19, 1002, 9, '2024-09-01'),
(264, 18, 1016, 8, '2024-09-01'),
(265, 19, 1016, 9, '2024-09-01'),
(266, 18, 1011, 4, '2024-09-01'),
(267, 19, 1011, 4, '2024-09-01'),
(268, 18, 1029, 4, '2024-09-01'),
(269, 19, 1029, 6, '2024-09-01'),
(270, 18, 1022, 8, '2024-09-01'),
(271, 19, 1022, 9, '2024-09-01'),
(272, 18, 1028, 5, '2024-09-01'),
(273, 19, 1028, 7, '2024-09-01'),
(274, 18, 1001, 7, '2024-09-01'),
(275, 19, 1001, 8, '2024-09-01'),
(276, 18, 1021, 7, '2024-09-01'),
(277, 19, 1021, 6, '2024-09-01'),
(278, 18, 1002, 7, '2024-09-01'),
(279, 19, 1002, 9, '2024-09-01'),
(280, 18, 1016, 8, '2024-09-01'),
(281, 19, 1016, 9, '2024-09-01'),
(282, 15, 1011, 6, '2024-09-01'),
(283, 16, 1011, 5, '2024-09-01'),
(284, 17, 1011, 5, '2024-09-01'),
(285, 15, 1029, 10, '2024-09-01'),
(286, 16, 1029, 5, '2024-09-01'),
(287, 17, 1029, 3, '2024-09-01'),
(288, 15, 1028, 7, '2024-09-01'),
(289, 16, 1028, 6, '2024-09-01'),
(290, 15, 1001, 7, '2024-09-01'),
(291, 16, 1001, 8, '2024-09-01'),
(292, 17, 1001, 9, '2024-09-01'),
(293, 15, 1021, 5, '2024-09-01'),
(294, 16, 1021, 6, '2024-09-01'),
(295, 17, 1021, 7, '2024-09-01'),
(296, 15, 1002, 7, '2024-09-01'),
(297, 16, 1002, 8, '2024-09-01'),
(298, 17, 1002, 8, '2024-09-01'),
(299, 15, 1016, 9, '2024-09-01'),
(300, 16, 1016, 8, '2024-09-01'),
(301, 17, 1016, 9, '2024-09-01'),
(302, 15, 1011, 6, '2024-09-01'),
(303, 16, 1011, 5, '2024-09-01'),
(304, 17, 1011, 5, '2024-09-01'),
(305, 15, 1029, 10, '2024-09-01'),
(306, 16, 1029, 5, '2024-09-01'),
(307, 17, 1029, 3, '2024-09-01'),
(308, 17, 1003, 4, '2024-09-01'),
(309, 15, 1028, 7, '2024-09-01'),
(310, 16, 1028, 6, '2024-09-01'),
(311, 15, 1001, 7, '2024-09-01'),
(312, 16, 1001, 8, '2024-09-01'),
(313, 17, 1001, 9, '2024-09-01'),
(314, 15, 1021, 5, '2024-09-01'),
(315, 16, 1021, 6, '2024-09-01'),
(316, 17, 1021, 7, '2024-09-01'),
(317, 15, 1002, 7, '2024-09-01'),
(318, 16, 1002, 8, '2024-09-01'),
(319, 17, 1002, 8, '2024-09-01'),
(320, 15, 1016, 9, '2024-09-01'),
(321, 16, 1016, 8, '2024-09-01'),
(322, 17, 1016, 9, '2024-09-01'),
(323, 15, 1011, 6, '2024-09-01'),
(324, 16, 1011, 5, '2024-09-01'),
(325, 17, 1011, 5, '2024-09-01'),
(326, 15, 1029, 10, '2024-09-01'),
(327, 16, 1029, 5, '2024-09-01'),
(328, 17, 1029, 3, '2024-09-01'),
(329, 17, 1003, 4, '2024-09-01'),
(330, 15, 1028, 7, '2024-09-01'),
(331, 16, 1028, 6, '2024-09-01'),
(332, 15, 1001, 7, '2024-09-01'),
(333, 16, 1001, 8, '2024-09-01'),
(334, 17, 1001, 9, '2024-09-01'),
(335, 15, 1021, 5, '2024-09-01'),
(336, 16, 1021, 6, '2024-09-01'),
(337, 17, 1021, 7, '2024-09-01'),
(338, 15, 1002, 7, '2024-09-01'),
(339, 16, 1002, 8, '2024-09-01'),
(340, 17, 1002, 8, '2024-09-01'),
(341, 15, 1016, 9, '2024-09-01'),
(342, 16, 1016, 8, '2024-09-01'),
(343, 17, 1016, 9, '2024-09-01');

--
-- Disparadors `estudiants_ras`
--
DELIMITER $$
CREATE TRIGGER `promocio_fp_correcta` AFTER INSERT ON `estudiants_ras` FOR EACH ROW BEGIN
    DECLARE total_ras INT;
    DECLARE aprovades INT;
    DECLARE curs_actual ENUM('1r','2n');
    DECLARE nou_curs ENUM('1r','2n');

    SELECT COUNT(*), e.grado INTO total_ras, curs_actual
    FROM estudiants_ras er 
    JOIN estudiants e ON er.nia = e.nia 
    WHERE er.nia = NEW.nia GROUP BY e.nia, e.grado;

    SELECT COUNT(*) INTO aprovades
    FROM estudiants_ras WHERE nia = NEW.nia AND nota >= 5;

    IF total_ras = aprovades AND curs_actual = '1r' THEN
        SET nou_curs = '2n';
        
        -- Promover
        UPDATE estudiants 
        SET nom_grup = REPLACE(nom_grup, '1', '2'),
            grado = nou_curs,
            data_inici = CURDATE()
        WHERE nia = NEW.nia;
        
        -- Histórico 1r curso
        INSERT INTO historic_estudiants (nia, nom_cicle, grado, finalitzat, nota_final, data_inici, data_fi)
        SELECT nia, nom_cicle, '1r', 1, ROUND(AVG(nota),1), 
               MIN(data_inici), CURDATE()
        FROM estudiants e JOIN estudiants_ras er ON e.nia = er.nia
        WHERE e.nia = NEW.nia AND e.grado = '1r';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `promocio_fp_insert` AFTER INSERT ON `estudiants_ras` FOR EACH ROW BEGIN
    DECLARE total_ras INT;
    DECLARE aprovades INT;
    DECLARE curs_actual VARCHAR(10);

    SELECT COUNT(*) INTO total_ras
    FROM estudiants_ras WHERE nia = NEW.nia;

    SELECT COUNT(*) INTO aprovades
    FROM estudiants_ras 
    WHERE nia = NEW.nia AND nota >= 5;

    -- Si aprueba TODO el curso 1º → promover a 2º Y crear histórico
    IF total_ras > 0 AND total_ras = aprovades AND NEW.nia IN (
        SELECT nia FROM estudiants WHERE nom_grup LIKE '%1%'
    ) THEN
        -- Promover grupo
        UPDATE estudiants 
        SET nom_grup = REPLACE(nom_grup, '1', '2'),
            data_inici = CURDATE()
        WHERE nia = NEW.nia;
        
        -- Crear histórico del curso finalizado
        INSERT INTO historic_estudiants (nia, nom_cicle, finalitzat, nota_final, data_inici, data_fi)
        SELECT NEW.nia, nom_cicle, 1, ROUND(AVG(nota),1), 
               MIN(data_inici), CURDATE()
        FROM estudiants e 
        JOIN estudiants_ras er ON e.nia = er.nia
        WHERE e.nia = NEW.nia;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de la taula `grup_classe`
--

CREATE TABLE `grup_classe` (
  `nom` varchar(25) NOT NULL,
  `aula` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `grup_classe`
--

INSERT INTO `grup_classe` (`nom`, `aula`) VALUES
('ASIX1A', 'A601'),
('ASIX2A', 'A602'),
('CI1A', 'A701'),
('CI2A', 'A702'),
('DAM1A', 'A401'),
('DAM2A', 'A402'),
('DAW1A', 'A501'),
('DAW2A', 'A502'),
('FPB1A', 'A101'),
('FPB2A', 'A102'),
('GA1A', 'A301'),
('GA2A', 'A302'),
('SMX1A', 'A201'),
('SMX2A', 'A202');

-- --------------------------------------------------------

--
-- Estructura de la taula `historic_actes`
--

CREATE TABLE `historic_actes` (
  `id` int(11) NOT NULL,
  `id_acta` int(11) NOT NULL,
  `dni_professor` varchar(9) NOT NULL,
  `camp_mod` varchar(50) NOT NULL,
  `valor_anterior` varchar(255) NOT NULL,
  `valor_nou` varchar(255) NOT NULL,
  `motiu` varchar(255) NOT NULL,
  `data_mod` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `historic_actes`
--

INSERT INTO `historic_actes` (`id`, `id_acta`, `dni_professor`, `camp_mod`, `valor_anterior`, `valor_nou`, `motiu`, `data_mod`) VALUES
(1, 9, '11223344K', 'nota_final', '6.5', '7', 'prova', '2026-05-05 21:48:03'),
(2, 2, '11223344K', 'nota_final', '7', '5', 'prova', '2026-05-05 23:32:48'),
(3, 2, '11223344K', 'nota_final', '5', '4', 'prova', '2026-05-05 23:33:01');

-- --------------------------------------------------------

--
-- Estructura de la taula `historic_estudiants`
--

CREATE TABLE `historic_estudiants` (
  `id` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `grado` enum('1r','2n') DEFAULT NULL,
  `finalitzat` tinyint(1) NOT NULL,
  `nota_final` decimal(4,1) DEFAULT NULL,
  `data_inici` date NOT NULL,
  `data_fi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `historic_estudiants`
--

INSERT INTO `historic_estudiants` (`id`, `nia`, `nom_cicle`, `grado`, `finalitzat`, `nota_final`, `data_inici`, `data_fi`) VALUES
(153, 1001, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1, 7.4, '2023-09-01', '2024-06-20'),
(154, 1002, 'CFGS Desenvolupament Aplicacions Multiplataforma', NULL, 1, 8.0, '2022-09-01', '2023-06-20'),
(155, 1011, 'CFGS Desenvolupament Aplicacions Multiplataforma', NULL, 1, 5.0, '2022-09-01', '2023-06-20'),
(156, 1016, 'CFGS Desenvolupament Aplicacions Multiplataforma', NULL, 1, 7.0, '2023-09-01', '2024-06-20'),
(157, 1021, 'CFGS Desenvolupament Aplicacions Multiplataforma', NULL, 1, 7.0, '2022-09-01', '2023-06-20'),
(158, 1028, 'CFGS Desenvolupament Aplicacions Multiplataforma', NULL, 1, 6.0, '2023-09-01', '2024-06-20'),
(159, 1003, 'CFGS Desenvolupament Aplicacions Web', NULL, 1, 8.0, '2023-09-01', '2024-06-20'),
(160, 1004, 'CFGS Desenvolupament Aplicacions Web', NULL, 1, 7.0, '2022-09-01', '2023-06-20'),
(161, 1017, 'CFGS Desenvolupament Aplicacions Web', NULL, 1, 8.0, '2023-09-01', '2024-06-20'),
(162, 1022, 'CFGS Desenvolupament Aplicacions Web', NULL, 1, 7.0, '2022-09-01', '2023-06-20'),
(163, 1005, 'CFGS Administracio de Sistemes Informatics en Xarxa', NULL, 1, 7.0, '2023-09-01', '2024-06-20'),
(164, 1006, 'CFGS Administracio de Sistemes Informatics en Xarxa', NULL, 1, 7.0, '2022-09-01', '2023-06-20'),
(165, 1013, 'CFGS Administracio de Sistemes Informatics en Xarxa', NULL, 1, 8.0, '2022-09-01', '2023-06-20'),
(166, 1018, 'CFGS Administracio de Sistemes Informatics en Xarxa', NULL, 1, 7.0, '2023-09-01', '2024-06-20'),
(167, 1023, 'CFGS Administracio de Sistemes Informatics en Xarxa', NULL, 1, 8.0, '2022-09-01', '2023-06-20'),
(168, 1007, 'CFGM Sistemes Microinformatics i Xarxes', NULL, 1, 7.0, '2023-09-01', '2024-06-20'),
(169, 1020, 'CFGM Sistemes Microinformatics i Xarxes', NULL, 1, 6.0, '2022-09-01', '2023-06-20'),
(170, 1027, 'CFGM Sistemes Microinformatics i Xarxes', NULL, 1, 6.0, '2023-09-01', '2024-06-20'),
(171, 1008, 'CFGM Gestio Administrativa', NULL, 1, 7.0, '2023-09-01', '2024-06-20'),
(172, 1014, 'CFGM Gestio Administrativa', NULL, 1, 6.0, '2022-09-01', '2023-06-20'),
(173, 1019, 'CFGM Gestio Administrativa', NULL, 1, 7.0, '2023-09-01', '2024-06-20'),
(174, 1026, 'CFGM Gestio Administrativa', NULL, 1, 7.0, '2022-09-01', '2023-06-20'),
(175, 1010, 'CFGS Comerce Internacional', NULL, 1, 7.0, '2023-09-01', '2024-06-20'),
(176, 1024, 'CFGS Comerce Internacional', NULL, 1, 7.0, '2023-09-01', '2024-06-20'),
(177, 1030, 'CFGS Comerce Internacional', NULL, 1, 7.0, '2022-09-01', '2023-06-20'),
(178, 1009, 'FP Basica Informatica', NULL, 1, 6.0, '2023-09-01', '2024-06-20'),
(179, 1025, 'FP Basica Informatica', NULL, 1, 6.0, '2023-09-01', '2024-06-20'),
(180, 1029, 'CFGS Desenvolupament Aplicacions Web', NULL, 0, NULL, '2022-09-01', '2023-06-20'),
(181, 1005, 'CFGM Sistemes Microinformatics i Xarxes', NULL, 1, 7.0, '2021-09-01', '2023-06-20'),
(182, 1018, 'CFGM Sistemes Microinformatics i Xarxes', NULL, 1, 7.0, '2021-09-01', '2023-06-20'),
(183, 1003, 'CFGM Sistemes Microinformatics i Xarxes', NULL, 1, 7.0, '2021-09-01', '2023-06-20'),
(184, 1001, 'CFGM Sistemes Microinformatics i Xarxes', '2n', 1, 7.0, '2022-09-01', '2023-06-20'),
(185, 1001, 'CFGM Sistemes Microinformatics i Xarxes', '1r', 1, 7.0, '2021-09-01', '2022-06-20');

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

--
-- Bolcament de dades per a la taula `historic_fct`
--

INSERT INTO `historic_fct` (`id`, `nia`, `empreses`, `hores`, `finalitzat`, `observacions`, `incidencies`) VALUES
(11, 1002, 'AppDev Lleida SL', 400, 1, 'FCT finalitzada correctament', ''),
(12, 1004, 'WebCorp Lleida', 400, 1, 'FCT finalitzada correctament', ''),
(13, 1006, 'NetSystems SL', 400, 1, 'FCT finalitzada correctament', ''),
(14, 1011, 'SoftLleida SL', 200, 0, 'FCT en curs', ''),
(15, 1013, 'TechLleida SA', 400, 1, 'FCT finalitzada correctament', ''),
(16, 1014, 'GestioLleida SL', 400, 1, 'FCT finalitzada correctament', ''),
(17, 1020, 'InfoLleida SL', 400, 1, 'FCT finalitzada correctament', ''),
(18, 1021, 'AppDev SL', 300, 0, 'FCT en curs', 'Retard entrega documents'),
(19, 1022, 'WebDesign SL', 400, 1, 'FCT finalitzada correctament', ''),
(20, 1023, 'SysAdmin SL', 400, 1, 'FCT finalitzada correctament', ''),
(21, 1026, 'GestioPlus SL', 400, 1, 'FCT finalitzada correctament', ''),
(22, 1030, 'ComercGlobal SL', 250, 0, 'FCT en curs', '');

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

--
-- Bolcament de dades per a la taula `historic_professors`
--

INSERT INTO `historic_professors` (`id`, `codi_prof`, `tipus`, `motius`, `justificat`, `justificant`) VALUES
(11, 'PROF01', 'Baixa', 'Malaltia', 1, 'Informe medic'),
(12, 'PROF02', 'Permis', 'Formacio', 1, 'Justificant curs'),
(13, 'PROF03', 'Retard', 'Transit', 0, ''),
(14, 'PROF04', 'Baixa', 'Cita medica', 1, 'Certificat medic'),
(15, 'PROF05', 'Permis', 'Assumptes personals', 1, 'Sol·licitud aprovada'),
(16, 'PROF06', 'Retard', 'Transport public', 0, ''),
(17, 'PROF07', 'Baixa', 'Vacances', 1, 'Sol·licitud aprovada'),
(18, 'PROF08', 'Permis', 'Entrevista', 1, 'Carta empresa'),
(19, 'PROF09', 'Retard', 'Problemes familiars', 0, ''),
(20, 'PROF10', 'Baixa', 'Malaltia', 1, 'Informe medic'),
(21, 'PROF11', 'Baixa', 'Malaltia', 1, 'Informe medic'),
(22, 'PROF12', 'Permis', 'Formacio', 1, 'Justificant curs'),
(23, 'PROF13', 'Retard', 'Transit', 0, ''),
(24, 'PROF14', 'Baixa', 'Cita medica', 1, 'Certificat medic'),
(25, 'PROF15', 'Permis', 'Assumptes personals', 1, 'Aprovada'),
(26, 'PROF01', 'Retard', 'Transport public', 0, ''),
(27, 'PROF02', 'Baixa', 'Vacances', 1, 'Aprovada'),
(28, 'PROF03', 'Permis', 'Entrevista', 1, 'Carta empresa'),
(29, 'PROF04', 'Retard', 'Problemes familiars', 0, ''),
(30, 'PROF05', 'Baixa', 'Malaltia', 1, 'Informe medic'),
(31, 'PROF06', 'Permis', 'Formacio', 1, 'Justificant curs'),
(32, 'PROF07', 'Retard', 'Transit', 0, ''),
(33, 'PROF08', 'Baixa', 'Cita medica', 1, 'Certificat medic'),
(34, 'PROF09', 'Permis', 'Assumptes personals', 1, 'Aprovada'),
(35, 'PROF10', 'Retard', 'Transport public', 0, ''),
(36, 'PROF11', 'Permis', 'Formacio', 1, 'Justificant curs'),
(37, 'PROF12', 'Retard', 'Transit', 0, ''),
(38, 'PROF13', 'Baixa', 'Malaltia', 1, 'Informe medic'),
(39, 'PROF14', 'Retard', 'Transport public', 0, ''),
(40, 'PROF15', 'Baixa', 'Vacances', 1, 'Aprovada');

-- --------------------------------------------------------

--
-- Estructura de la taula `logs_consultes`
--

CREATE TABLE `logs_consultes` (
  `id` int(11) NOT NULL,
  `dni_user` varchar(20) NOT NULL,
  `consulta` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `logs_consultes`
--

INSERT INTO `logs_consultes` (`id`, `dni_user`, `consulta`) VALUES
(1, '11111111A', '/get_estudis.php?dni=11111111A&token=b2121697855da39afcaf7bfdcb21a56ca3b2cbb3281aafc363784f62ad8711df'),
(2, '11111111A', '/get_profs.php?dni=11111111A&token=b2121697855da39afcaf7bfdcb21a56ca3b2cbb3281aafc363784f62ad8711df'),
(3, '11111111A', '/get_estudis.php?dni=11111111A&token=b2121697855da39afcaf7bfdcb21a56ca3b2cbb3281aafc363784f62ad8711df'),
(4, '11111111A', '/get_estudis.php?dni=11111111A&token=b2121697855da39afcaf7bfdcb21a56ca3b2cbb3281aafc363784f62ad8711df'),
(5, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(6, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(7, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF11&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(8, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(9, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF10&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(10, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(11, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF11&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(12, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(13, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF06&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(14, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(15, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF10&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(16, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(17, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(18, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(19, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(20, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(21, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(22, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(23, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(24, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(25, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(26, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(27, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(28, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(29, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF10&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(30, '11111111A', '/get_profs.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(31, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(32, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(33, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(34, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(35, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(36, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(37, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(38, '11111111A', '/get_estudis.php?dni=11111111A&token=3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443'),
(39, '11111111A', '/get_estudis.php?dni=11111111A&token=cf425b12e956c1329d170a83ffd6babf5df7cceb2045af17a01d38960378b309'),
(40, '11111111A', '/get_estudis.php?dni=11111111A&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(41, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(42, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(43, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(44, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(45, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(46, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(47, '11111111A', '/get_estudis.php?dni=11111111A&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(48, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(49, '11111111A', '/get_estudis.php?dni=11111111A&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(50, '11111111A', '/get_estudis.php?dni=11111111A&token=b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0'),
(51, '11111111A', '/get_estudis.php?dni=11111111A&token=14b6d07fd0cac990a807d41bb08556382aec77937716642293888296cdf312c1'),
(52, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=14b6d07fd0cac990a807d41bb08556382aec77937716642293888296cdf312c1'),
(53, '11111111A', '/get_estudis.php?dni=11111111A&token=14b6d07fd0cac990a807d41bb08556382aec77937716642293888296cdf312c1'),
(54, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=14b6d07fd0cac990a807d41bb08556382aec77937716642293888296cdf312c1'),
(55, '11111111A', '/get_estudis.php?dni=11111111A&token=14b6d07fd0cac990a807d41bb08556382aec77937716642293888296cdf312c1'),
(56, '11111111A', '/get_estudis.php?dni=11111111A&token=fa66ad05921947ab8d1573d2937f17bd3b64e55064ffd2d7d21ce6852040e858'),
(57, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=fa66ad05921947ab8d1573d2937f17bd3b64e55064ffd2d7d21ce6852040e858'),
(58, '11111111A', '/get_estudis.php?dni=11111111A&token=fa66ad05921947ab8d1573d2937f17bd3b64e55064ffd2d7d21ce6852040e858'),
(59, '11111111A', '/get_estudis.php?dni=11111111A&token=438878390709ba53d83134e7908917aa19c6c12071631a9e9fc69a8c5be888c1'),
(60, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=438878390709ba53d83134e7908917aa19c6c12071631a9e9fc69a8c5be888c1'),
(61, '11111111A', '/get_estudis.php?dni=11111111A&token=438878390709ba53d83134e7908917aa19c6c12071631a9e9fc69a8c5be888c1'),
(62, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=438878390709ba53d83134e7908917aa19c6c12071631a9e9fc69a8c5be888c1'),
(63, '11111111A', '/get_estudis.php?dni=11111111A&token=438878390709ba53d83134e7908917aa19c6c12071631a9e9fc69a8c5be888c1'),
(64, '11111111A', '/get_estudis.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(65, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(66, '11111111A', '/get_estudis.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(67, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(68, '11111111A', '/get_estudis.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(69, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(70, '11111111A', '/get_estudis.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(71, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(72, '11111111A', '/get_estudis.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(73, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(74, '11111111A', '/get_estudis.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(75, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(76, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(77, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(78, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(79, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(80, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF10&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(81, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(82, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF06&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(83, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(84, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(85, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(86, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(87, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(88, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF10&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(89, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(90, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(91, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(92, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(93, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(94, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF10&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(95, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(96, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF11&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(97, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(98, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF06&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(99, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(100, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(101, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(102, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF10&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(103, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(104, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF11&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(105, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(106, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(107, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(108, '11111111A', '/get_estudis.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(109, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(110, '11111111A', '/get_estudis.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(111, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(112, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(113, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(114, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(115, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(116, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(117, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(118, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(119, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(120, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(121, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(122, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(123, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(124, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(125, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(126, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(127, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(128, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(129, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(130, '11111111A', '/get_profs.php?dni=11111111A&token=9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd'),
(131, '11111111A', '/get_profs.php?dni=11111111A&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(132, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(133, '11111111A', '/get_profs.php?dni=11111111A&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(134, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(135, '11111111A', '/get_profs.php?dni=11111111A&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(136, '11111111A', '/get_estudis.php?dni=11111111A&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(137, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(138, '11111111A', '/get_estudis.php?dni=11111111A&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(139, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(140, '11111111A', '/get_estudis.php?dni=11111111A&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(141, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(142, '11111111A', '/get_estudis.php?dni=11111111A&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(143, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&token=1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788'),
(144, '11111111A', '/get_estudis.php?dni=11111111A&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(145, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(146, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&data_inici=2023-09-01&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(147, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(148, '11111111A', '/get_estudis.php?dni=11111111A&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(149, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(150, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&data_inici=2023-09-01&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(151, '11111111A', '/get_estudis.php?dni=11111111A&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(152, '11111111A', '/get_estudis.php?dni=11111111A&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(153, '11111111A', '/get_estudis.php?dni=11111111A&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(154, '11111111A', '/get_estudis.php?dni=11111111A&token=8d3722769d4c38dfa0607dd9f2618017685cecc7fbccb2b3eed5a34b02d0edcc'),
(155, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=8d3722769d4c38dfa0607dd9f2618017685cecc7fbccb2b3eed5a34b02d0edcc'),
(156, '11111111A', '/get_estudis.php?dni=11111111A&token=8d3722769d4c38dfa0607dd9f2618017685cecc7fbccb2b3eed5a34b02d0edcc'),
(157, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=8d3722769d4c38dfa0607dd9f2618017685cecc7fbccb2b3eed5a34b02d0edcc'),
(158, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGS%20Desenvolupament%20Aplicacions%20Multiplataforma&data_inici=2023-09-01&token=8d3722769d4c38dfa0607dd9f2618017685cecc7fbccb2b3eed5a34b02d0edcc'),
(159, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=8d3722769d4c38dfa0607dd9f2618017685cecc7fbccb2b3eed5a34b02d0edcc'),
(160, '11111111A', '/get_estudis.php?dni=11111111A&token=8d3722769d4c38dfa0607dd9f2618017685cecc7fbccb2b3eed5a34b02d0edcc'),
(161, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&data_inici=2021-09-01&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53'),
(162, '11111111A', '/get_profs.php?dni=11111111A&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(163, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(164, '11111111A', '/get_profs.php?dni=11111111A&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(165, '11111111A', '/get_estudis.php?dni=11111111A&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(166, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(167, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&data_inici=2023-09-01&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(168, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(169, '11111111A', '/get_estudis.php?dni=11111111A&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(170, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(171, '11111111A', '/get_estudis.php?dni=11111111A&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(172, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(173, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&data_inici=2023-09-01&token=9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6'),
(174, '11111111A', '/get_profs.php?dni=11111111A&token=6ea9d7bea859b041866fcd369b76de5746f22646d8831f0496eaf11cd19b9a2a'),
(175, '11111111A', '/get_estudis.php?dni=11111111A&token=6ea9d7bea859b041866fcd369b76de5746f22646d8831f0496eaf11cd19b9a2a'),
(176, '11111111A', '/get_profs.php?dni=11111111A&token=21677a78aa7f19d7370158b6aa13d0f4d19e7f9bc6d60edbc19cf667318a56e1'),
(177, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=21677a78aa7f19d7370158b6aa13d0f4d19e7f9bc6d60edbc19cf667318a56e1'),
(178, '11111111A', '/get_estudis.php?dni=11111111A&token=958de2cbcc8d8f7aee927e38b444739c785cf72b0b56333d5e47f5e17ba36ba0'),
(179, '11111111A', '/get_profs.php?dni=11111111A&token=958de2cbcc8d8f7aee927e38b444739c785cf72b0b56333d5e47f5e17ba36ba0'),
(180, '11111111A', '/get_estudis.php?dni=11111111A&token=8ac8065b179de613a351f6d336aa243d3a2b0016dca92bd9d65bf5238d672b62'),
(181, '11111111A', '/get_estudis.php?dni=11111111A&token=7ee801f6268a6079e8ab5a831978998bcfa3df96c80d505ce3bfe60593479a19'),
(182, '11111111A', '/get_profs.php?dni=11111111A&token=702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e'),
(183, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e'),
(184, '11111111A', '/get_profs.php?dni=11111111A&token=702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e'),
(185, '11111111A', '/get_estudis.php?dni=11111111A&token=702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e'),
(186, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e'),
(187, '11111111A', '/get_estudis.php?dni=11111111A&token=702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e'),
(188, '11111111A', '/get_profs.php?dni=11111111A&token=702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e'),
(189, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e'),
(190, '11111111A', '/get_profs.php?dni=11111111A&token=3424043994479000585d270d4ed109265eaa4979997b7f770d620b5d437d56b9'),
(191, '11111111A', '/get_profs.php?dni=11111111A&token=2cf8b4ef4283e418295dbdf18eee97a2c849c93e1a9c65620d977572ecef2851'),
(192, '11111111A', '/get_profs.php?dni=11111111A&token=f4b8c39925b92097a5e176624d78805035006cf01e94744b6ed570c21959ebe5'),
(193, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=f4b8c39925b92097a5e176624d78805035006cf01e94744b6ed570c21959ebe5'),
(194, '11111111A', '/get_profs.php?dni=11111111A&token=f4b8c39925b92097a5e176624d78805035006cf01e94744b6ed570c21959ebe5'),
(195, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=f4b8c39925b92097a5e176624d78805035006cf01e94744b6ed570c21959ebe5'),
(196, '11111111A', '/get_profs.php?dni=11111111A&token=f4b8c39925b92097a5e176624d78805035006cf01e94744b6ed570c21959ebe5'),
(197, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=f4b8c39925b92097a5e176624d78805035006cf01e94744b6ed570c21959ebe5'),
(198, '11111111A', '/get_profs.php?dni=11111111A&token=f4b8c39925b92097a5e176624d78805035006cf01e94744b6ed570c21959ebe5'),
(199, '11111111A', '/get_profs.php?dni=11111111A&token=ef0af51acfa7a8d2da65f1f1ddc9c03bcfe4665c46caf4b764c2b0baab005de2'),
(200, '11111111A', '/get_profs.php?dni=11111111A&token=989e6e8753ec332815143546ebb6555adda50abca5828843e490a4b5f11b2b69'),
(201, '11111111A', '/get_profs.php?dni=11111111A&token=5ed99ae6c7c1e0e89bce07e53b55a0c898e64cd827e1c0dbe6f57214b1e14155'),
(202, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=5ed99ae6c7c1e0e89bce07e53b55a0c898e64cd827e1c0dbe6f57214b1e14155');

-- --------------------------------------------------------

--
-- Estructura de la taula `logs_login`
--

CREATE TABLE `logs_login` (
  `id` int(11) NOT NULL,
  `dni_user` varchar(20) NOT NULL,
  `ip` int(12) NOT NULL,
  `exito` tinyint(1) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `logs_login`
--

INSERT INTO `logs_login` (`id`, `dni_user`, `ip`, `exito`, `data`) VALUES
(1, '11223344K', 2147483647, 1, '2026-05-04 22:45:28'),
(2, '11223344K', 2147483647, 1, '2026-05-04 22:46:18'),
(3, '12345678A', 2147483647, 1, '2026-05-04 22:47:09'),
(4, '11223344K', 2147483647, 1, '2026-05-04 22:48:14'),
(5, '11223344K', 2147483647, 0, '2026-05-04 22:49:34'),
(6, '11223344K', 2147483647, 1, '2026-05-04 22:49:42'),
(7, '11223344K', 2147483647, 1, '2026-05-04 22:59:18'),
(8, '12345678A', 2147483647, 1, '2026-05-04 22:59:51'),
(9, '12345678A', 2147483647, 1, '2026-05-05 16:26:19'),
(10, '11223344K', 2147483647, 1, '2026-05-05 16:27:31'),
(11, '12345678A', 2147483647, 1, '2026-05-05 16:29:53'),
(12, '11223344K', 2147483647, 1, '2026-05-05 16:34:20'),
(13, '12345678A', 2147483647, 1, '2026-05-05 16:36:46'),
(14, '12345678A', 2147483647, 1, '2026-05-05 16:45:12'),
(15, '12345678A', 2147483647, 1, '2026-05-05 16:47:08'),
(16, '12345678A', 2147483647, 1, '2026-05-05 16:48:00'),
(17, '12345678A', 2147483647, 1, '2026-05-05 16:49:54'),
(18, '12345678A', 2147483647, 1, '2026-05-05 16:51:19'),
(19, '12345678A', 2147483647, 1, '2026-05-05 16:52:03'),
(20, '12345678A', 2147483647, 1, '2026-05-05 19:19:51'),
(21, '12345678A', 2147483647, 1, '2026-05-05 19:24:36'),
(22, '12345678A', 2147483647, 1, '2026-05-05 19:26:53'),
(23, '12345678A', 2147483647, 1, '2026-05-05 19:29:49'),
(24, '11223344K', 2147483647, 1, '2026-05-05 19:30:17'),
(25, '12345678A', 2147483647, 1, '2026-05-05 19:51:01'),
(26, '12345678A', 2147483647, 1, '2026-05-05 19:53:46'),
(27, '12345678A', 2147483647, 1, '2026-05-05 19:56:34'),
(28, '11223344K', 2147483647, 1, '2026-05-05 20:11:40'),
(29, '11223344K', 2147483647, 1, '2026-05-05 20:17:35'),
(30, '11223344K', 2147483647, 1, '2026-05-05 20:36:58'),
(31, '11223344K', 2147483647, 1, '2026-05-05 20:38:21'),
(32, '11223344K', 2147483647, 1, '2026-05-05 21:07:35'),
(33, '11223344K', 2147483647, 1, '2026-05-05 21:10:07'),
(34, '11223344K', 2147483647, 1, '2026-05-05 21:13:17'),
(35, '11223344K', 2147483647, 1, '2026-05-05 21:15:02'),
(36, '11223344K', 2147483647, 1, '2026-05-05 21:15:46'),
(37, '11223344K', 2147483647, 1, '2026-05-05 21:19:42'),
(38, '11223344K', 2147483647, 1, '2026-05-05 21:21:32'),
(39, '11223344K', 2147483647, 1, '2026-05-05 23:08:39'),
(40, '11223344K', 2147483647, 1, '2026-05-05 23:09:43'),
(41, '11223344K', 2147483647, 1, '2026-05-05 23:13:53'),
(42, '11223344K', 2147483647, 1, '2026-05-05 23:15:23'),
(43, '11223344K', 2147483647, 1, '2026-05-05 23:17:05'),
(44, '11223344K', 2147483647, 1, '2026-05-05 23:21:13'),
(45, '11223344K', 2147483647, 1, '2026-05-05 23:23:51'),
(46, '11223344K', 2147483647, 1, '2026-05-05 23:24:58'),
(47, '12345678A', 2147483647, 1, '2026-05-05 23:25:25'),
(48, '11223344K', 2147483647, 1, '2026-05-05 23:26:50'),
(49, '12345678A', 2147483647, 1, '2026-05-05 23:35:40'),
(50, '11223344K', 2147483647, 1, '2026-05-05 23:37:13'),
(51, '12345678A', 2147483647, 1, '2026-05-05 23:38:02'),
(52, '11223344K', 2147483647, 1, '2026-05-05 23:46:38'),
(53, '11223344K', 2147483647, 1, '2026-05-06 00:02:45'),
(54, '11223344K', 2147483647, 1, '2026-05-06 00:05:15'),
(55, '11223344K', 2147483647, 1, '2026-05-06 00:07:05'),
(56, '12345678A', 2147483647, 1, '2026-05-06 00:10:01'),
(57, '11223344K', 2147483647, 1, '2026-05-06 00:10:17'),
(58, '11223344K', 2147483647, 1, '2026-05-06 00:13:37'),
(59, '11223344K', 2147483647, 1, '2026-05-06 00:16:05'),
(60, '11223344K', 2147483647, 1, '2026-05-06 00:18:12'),
(61, '11223344K', 2147483647, 1, '2026-05-06 00:19:33'),
(62, '11223344K', 2147483647, 1, '2026-05-06 00:22:30'),
(63, '11223344K', 2147483647, 1, '2026-05-06 00:26:33'),
(64, '11223344K', 2147483647, 1, '2026-05-06 00:30:36'),
(65, '11223344K', 2147483647, 1, '2026-05-06 00:34:34'),
(66, '11223344K', 2147483647, 1, '2026-05-06 00:39:26'),
(67, '11223344K', 2147483647, 1, '2026-05-06 00:49:42'),
(68, '11223344K', 2147483647, 1, '2026-05-06 00:52:06'),
(69, '11223344K', 2147483647, 1, '2026-05-06 01:27:40'),
(70, '11223344K', 2147483647, 1, '2026-05-06 01:29:31');

-- --------------------------------------------------------

--
-- Estructura de la taula `periodes_avaluacio`
--

CREATE TABLE `periodes_avaluacio` (
  `id` int(11) NOT NULL,
  `trimestre` tinyint(1) NOT NULL COMMENT '1, 2 o 3',
  `curs` varchar(9) NOT NULL COMMENT 'p.ex. 2026-2027',
  `obert` tinyint(1) NOT NULL DEFAULT 0,
  `data_obertura` datetime DEFAULT NULL,
  `data_tancament` datetime DEFAULT NULL,
  `obert_per` varchar(9) DEFAULT NULL COMMENT 'dni del cap d estudis'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `periodes_avaluacio`
--

INSERT INTO `periodes_avaluacio` (`id`, `trimestre`, `curs`, `obert`, `data_obertura`, `data_tancament`, `obert_per`) VALUES
(4, 1, '2026-2027', 0, '2026-05-05 23:23:56', '2026-05-05 23:24:02', '11223344K'),
(5, 2, '2026-2027', 1, '2026-05-06 01:33:38', NULL, '11223344K'),
(6, 3, '2026-2027', 0, NULL, NULL, NULL);

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
  `ruta_foto` varchar(125) NOT NULL,
  `rol` enum('professor','alumne','director','administrador','tutor') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `persones`
--

INSERT INTO `persones` (`dni`, `nom`, `cognom`, `data_naix`, `poblacio`, `codi_postal`, `nacionalitat`, `municipi_naix`, `telf_mob`, `telf_fix`, `email`, `ruta_foto`, `rol`) VALUES
('10101010J', 'Emma', 'Vidal Torres', '2006-01-30', 'Lleida', 25005, 'Espanyola', 'Lleida', 610101010, 973101010, 'emma.vidal@alumne.cat', 'img/alumns/alum10.png', 'alumne'),
('11111111A', 'Pol', 'Gómez Ruiz', '2005-02-18', 'Lleida', 25001, 'Espanyola', 'Lleida', 611111111, 973111111, 'pol.gomez@alumne.cat', 'img/alumns/alum01.png', 'alumne'),
('11223344K', 'Eva', 'Torres Prat', '1974-12-05', 'Lleida', 25005, 'Espanyola', 'Lleida', 611223344, 973223344, 'eva.torres@institut.cat', 'img/profs/prof10.png', 'administrador'),
('12121212L', 'Arnau', 'Bosch Camps', '2005-06-15', 'Lleida', 25001, 'Espanyola', 'Lleida', 612121212, 973121212, 'arnau.bosch@alumne.cat', 'img/alumns/alum11.png', 'alumne'),
('12345678A', 'Marc', 'Serra Puig', '1978-03-12', 'Lleida', 25001, 'Espanyola', 'Lleida', 612345678, 973345678, 'marc.serra@institut.cat', 'img/profs/prof01.png', 'professor'),
('13131313M', 'Júlia', 'Ferrer Pons', '2006-02-28', 'Lleida', 25001, 'Espanyola', 'Lleida', 613131313, 973131313, 'julia.ferrer@alumne.cat', 'img/alumns/alum12.png', 'alumne'),
('14141414N', 'Roger', 'Llopis Mas', '2004-11-09', 'Lleida', 25002, 'Espanyola', 'Lleida', 614141414, 973141414, 'roger.llopis@alumne.cat', 'img/alumns/alum13.png', 'alumne'),
('15151515P', 'Carla', 'Mora Esteve', '2005-03-22', 'Lleida', 25002, 'Espanyola', 'Lleida', 615151515, 973151515, 'carla.mora@alumne.cat', 'img/alumns/alum14.png', 'alumne'),
('16161616Q', 'Marc', 'Torrents Gil', '2004-07-04', 'Lleida', 25003, 'Espanyola', 'Lleida', 616161616, 973161616, 'marc.torrents@alumne.cat', 'img/alumns/alum15.png', 'alumne'),
('17171717R', 'Sofia', 'Mas Vidal', '2005-05-12', 'Lleida', 25001, 'Espanyola', 'Lleida', 617171717, 973171717, 'sofia.mas@alumne.cat', 'img/alumns/alum16.png', 'alumne'),
('18181818S', 'Pau', 'Roca Gimeno', '2006-03-18', 'Lleida', 25001, 'Espanyola', 'Lleida', 618181818, 973181818, 'pau.roca@alumne.cat', 'img/alumns/alum17.png', 'alumne'),
('19191919T', 'Neus', 'Sala Pont', '2005-11-25', 'Lleida', 25002, 'Espanyola', 'Lleida', 619191919, 973191919, 'neus.sala@alumne.cat', 'img/alumns/alum18.png', 'alumne'),
('20202020U', 'Oriol', 'Vila Camps', '2006-07-04', 'Lleida', 25002, 'Espanyola', 'Lleida', 620202020, 973202020, 'oriol.vila@alumne.cat', 'img/alumns/alum19.png', 'alumne'),
('21212121V', 'Marina', 'Pons Esteve', '2005-09-30', 'Lleida', 25003, 'Espanyola', 'Lleida', 621212121, 973212121, 'marina.pons@alumne.cat', 'img/alumns/alum20.png', 'alumne'),
('22222222B', 'Aina', 'Martí Soler', '2006-11-05', 'Lleida', 25001, 'Espanyola', 'Lleida', 622222222, 973222222, 'aina.marti@alumne.cat', 'img/alumns/alum02.png', 'alumne'),
('22222223W', 'Gerard', 'Llopis Tort', '2004-12-15', 'Lleida', 25003, 'Espanyola', 'Lleida', 622222223, 973222223, 'gerard.llopis@alumne.cat', 'img/alumns/alum21.png', 'alumne'),
('23232323X', 'Mireia', 'Ferrer Mas', '2005-06-08', 'Lleida', 25004, 'Espanyola', 'Lleida', 623232323, 973232323, 'mireia.ferrer@alumne.cat', 'img/alumns/alum22.png', 'alumne'),
('23456789B', 'Anna', 'Ribas Soler', '1982-07-24', 'Lleida', 25001, 'Espanyola', 'Lleida', 623456789, 973456789, 'anna.ribas@institut.cat', 'img/profs/prof02.png', 'professor'),
('24242424Y', 'Dani', 'Soler Riba', '2006-01-22', 'Lleida', 25004, 'Espanyola', 'Lleida', 624242424, 973242424, 'dani.soler@alumne.cat', 'img/alumns/alum23.png', 'alumne'),
('25252525Z', 'Ona', 'Puig Tort', '2005-04-17', 'Lleida', 25005, 'Espanyola', 'Lleida', 625252525, 973252525, 'ona.puig@alumne.cat', 'img/alumns/alum24.png', 'alumne'),
('26262626A', 'Bernat', 'Coma Valls', '2004-08-29', 'Lleida', 25005, 'Espanyola', 'Lleida', 626262626, 973262626, 'bernat.coma@alumne.cat', 'img/alumns/alum25.png', 'alumne'),
('27272727B', 'Alba', 'Mir Prat', '2005-03-11', 'Lleida', 25001, 'Espanyola', 'Lleida', 627272727, 973272727, 'alba.mir@alumne.cat', 'img/alumns/alum26.png', 'alumne'),
('28282828C', 'Guillem', 'Tort Bosch', '2006-10-03', 'Lleida', 25001, 'Espanyola', 'Lleida', 628282828, 973282828, 'guillem.tort@alumne.cat', 'img/alumns/alum27.png', 'alumne'),
('29292929D', 'Laura', 'Font Sala', '2005-07-19', 'Lleida', 25002, 'Espanyola', 'Lleida', 629292929, 973292929, 'laura.font@alumne.cat', 'img/alumns/alum28.png', 'alumne'),
('30303030E', 'Alex', 'Camps Mir', '2004-02-06', 'Lleida', 25002, 'Espanyola', 'Lleida', 630303030, 973303030, 'alex.camps@alumne.cat', 'img/alumns/alum29.png', 'alumne'),
('31313131F', 'Claudia', 'Valls Roca', '2006-05-24', 'Lleida', 25003, 'Espanyola', 'Lleida', 631313131, 973313131, 'claudia.valls@alumne.cat', 'img/alumns/alum30.png', 'alumne'),
('32323232G', 'Miquel', 'Aguilar Blasco', '1980-04-14', 'Lleida', 25003, 'Espanyola', 'Lleida', 632323232, 973323232, 'miquel.aguilar@institut.cat', 'img/profs/prof11.png', 'professor'),
('33323232H', 'Cristina', 'Beltran Vidal', '1977-09-21', 'Lleida', 25004, 'Espanyola', 'Lleida', 633323232, 973332323, 'cristina.beltran@institut.cat', 'img/profs/prof12.png', 'professor'),
('33333333C', 'Nil', 'Costa Riba', '2005-07-23', 'Lleida', 25002, 'Espanyola', 'Lleida', 633333333, 973333333, 'nil.costa@alumne.cat', 'img/alumns/alum03.png', 'alumne'),
('34323232I', 'Raul', 'Gimenez Pons', '1983-01-08', 'Lleida', 25004, 'Espanyola', 'Lleida', 634323232, 973342323, 'raul.gimenez@institut.cat', 'img/profs/prof13.png', 'professor'),
('34567890C', 'Jordi', 'Casas Vila', '1975-11-03', 'Lleida', 25002, 'Espanyola', 'Lleida', 634567890, 973567890, 'jordi.casas@institut.cat', 'img/profs/prof03.png', 'professor'),
('35323232J', 'Montse', 'Llopis Camps', '1979-06-30', 'Lleida', 25005, 'Espanyola', 'Lleida', 635323232, 973352323, 'montse.llopis@institut.cat', 'img/profs/prof14.png', 'professor'),
('36323232K', 'Toni', 'Rovira Soler', '1981-11-15', 'Lleida', 25005, 'Espanyola', 'Lleida', 636323232, 973362323, 'toni.rovira@institut.cat', 'img/profs/prof15.png', 'professor'),
('44444444D', 'Laia', 'Romero Gil', '2005-09-14', 'Lleida', 25002, 'Espanyola', 'Lleida', 644444444, 973444444, 'laia.romero@alumne.cat', 'img/alumns/alum04.png', 'alumne'),
('45678901D', 'Marta', 'Puig Ferrer', '1980-05-19', 'Lleida', 25002, 'Espanyola', 'Lleida', 645678901, 973678901, 'marta.puig@institut.cat', 'img/profs/prof04.png', 'professor'),
('55555555E', 'Jan', 'Navarro Puig', '2006-03-09', 'Lleida', 25003, 'Espanyola', 'Lleida', 655555555, 973555555, 'jan.navarro@alumne.cat', 'img/alumns/alum05.png', 'alumne'),
('56789012E', 'Pere', 'Anton López', '1979-09-08', 'Lleida', 25003, 'Espanyola', 'Lleida', 656789012, 973789012, 'pere.anton@institut.cat', 'img/profs/prof05.png', 'professor'),
('66666666F', 'Clara', 'Ortiz Vila', '2005-12-27', 'Lleida', 25003, 'Espanyola', 'Lleida', 666666666, 973666666, 'clara.ortiz@alumne.cat', 'img/alumns/alum06.png', 'alumne'),
('67890123F', 'Laura', 'Sánchez Mora', '1983-01-15', 'Lleida', 25003, 'Espanyola', 'Lleida', 667890123, 973890123, 'laura.sanchez@institut.cat', 'img/profs/prof06.png', 'professor'),
('77777777G', 'Eric', 'Soler Llorens', '2005-04-11', 'Lleida', 25004, 'Espanyola', 'Lleida', 677777777, 973777777, 'eric.soler@alumne.cat', 'img/alumns/alum07.png', 'alumne'),
('78901234G', 'Carles', 'Domènech Roca', '1977-06-30', 'Lleida', 25004, 'Espanyola', 'Lleida', 678901234, 973901234, 'carles.domenech@institut.cat', 'img/profs/prof07.png', 'professor'),
('88888888H', 'Iris', 'Reig Amat', '2006-10-21', 'Lleida', 25004, 'Espanyola', 'Lleida', 688888888, 973888888, 'iris.reig@alumne.cat', 'img/alumns/alum08.png', 'alumne'),
('89012345H', 'Núria', 'Pérez Vidal', '1985-04-22', 'Lleida', 25004, 'Espanyola', 'Lleida', 689012345, 973012345, 'nuria.perez@institut.cat', 'img/profs/prof08.png', 'professor'),
('90123456I', 'Xavier', 'Font Mir', '1976-08-11', 'Lleida', 25005, 'Espanyola', 'Lleida', 690123456, 973123456, 'xavier.font@institut.cat', 'img/profs/prof09.png', 'professor'),
('99999999I', 'Biel', 'Pascual Serra', '2005-08-02', 'Lleida', 25005, 'Espanyola', 'Lleida', 699999999, 973999999, 'biel.pascual@alumne.cat', 'img/alumns/alum09.png', 'alumne');

--
-- Disparadors `persones`
--
DELIMITER $$
CREATE TRIGGER `generarUsuari` AFTER INSERT ON `persones` FOR EACH ROW BEGIN
    DECLARE usernameBase VARCHAR(50);
    DECLARE usernameFinal VARCHAR(50);
    DECLARE cont INT DEFAULT 0;

    SET usernameBase = LOWER(CONCAT(LEFT(NEW.nom, 1), REPLACE(NEW.cognom, ' ', '')));
    SET usernameFinal = usernameBase;

    WHILE EXISTS (
        SELECT 1 FROM usuaris WHERE username = usernameFinal
    ) DO
        SET cont = cont + 1;
        SET usernameFinal = CONCAT(usernameBase, cont);
    END WHILE;

    INSERT INTO usuaris (username, dni, password)
    VALUES (usernameFinal, NEW.dni, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `valid_email` BEFORE INSERT ON `persones` FOR EACH ROW BEGIN
    IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email no vàlid';
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

--
-- Bolcament de dades per a la taula `professors`
--

INSERT INTO `professors` (`codi_prof`, `dni`, `dedicacio`) VALUES
('PROF01', '12345678A', 'professor'),
('PROF02', '23456789B', 'tutor de grup'),
('PROF03', '34567890C', 'professor'),
('PROF04', '45678901D', 'tutor FCT'),
('PROF05', '56789012E', 'professor'),
('PROF06', '67890123F', 'tutor de grup'),
('PROF07', '78901234G', 'professor'),
('PROF08', '89012345H', 'tutor FCT'),
('PROF09', '90123456I', 'professor'),
('PROF10', '11223344K', 'tutor de grup'),
('PROF11', '32323232G', 'professor'),
('PROF12', '33323232H', 'tutor de grup'),
('PROF13', '34323232I', 'professor'),
('PROF14', '35323232J', 'tutor FCT'),
('PROF15', '36323232K', 'tutor de grup');

-- --------------------------------------------------------

--
-- Estructura de la taula `prof_assignatura`
--

CREATE TABLE `prof_assignatura` (
  `id` int(11) NOT NULL,
  `id_codiprof` varchar(20) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `prof_assignatura`
--

INSERT INTO `prof_assignatura` (`id`, `id_codiprof`, `id_assignatura`) VALUES
(1, 'PROF01', 'MP06'),
(2, 'PROF01', 'MP07'),
(3, 'PROF02', 'MP08'),
(4, 'PROF02', 'MP09'),
(5, 'PROF03', 'MP03'),
(6, 'PROF03', 'MP05'),
(7, 'PROF04', 'MP11'),
(8, 'PROF04', 'MP12'),
(9, 'PROF05', 'MP01'),
(10, 'PROF05', 'MP02'),
(11, 'PROF06', 'MP04'),
(12, 'PROF06', 'MP10'),
(13, 'PROF07', 'MP13'),
(14, 'PROF08', 'MP14'),
(15, 'PROF08', 'MP15');

-- --------------------------------------------------------

--
-- Estructura de la taula `ras`
--

CREATE TABLE `ras` (
  `id` int(11) NOT NULL,
  `ra` int(11) NOT NULL,
  `codi_assignatura` varchar(25) NOT NULL,
  `data_inici` date NOT NULL,
  `data_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `ras`
--

INSERT INTO `ras` (`id`, `ra`, `codi_assignatura`, `data_inici`, `data_fin`) VALUES
(15, 1, 'MP06', '2024-09-01', '2024-12-20'),
(16, 2, 'MP06', '2025-01-08', '2025-03-28'),
(17, 3, 'MP06', '2025-04-01', '2025-06-13'),
(18, 1, 'MP07', '2024-09-01', '2024-12-20'),
(19, 2, 'MP07', '2025-01-08', '2025-06-13'),
(20, 1, 'MP08', '2024-09-01', '2024-12-20'),
(21, 2, 'MP08', '2025-01-08', '2025-06-13'),
(22, 1, 'MP03', '2024-09-01', '2024-12-20'),
(23, 2, 'MP03', '2025-01-08', '2025-06-13'),
(24, 1, 'MP05', '2024-09-01', '2024-12-20'),
(25, 2, 'MP05', '2025-01-08', '2025-06-13'),
(26, 1, 'MP11', '2024-09-01', '2024-12-20'),
(27, 2, 'MP11', '2025-01-08', '2025-06-13'),
(28, 1, 'MP04', '2024-09-01', '2024-12-20'),
(29, 2, 'MP04', '2025-01-08', '2025-06-13'),
(30, 1, 'MP01', '2024-09-01', '2024-12-20'),
(31, 2, 'MP01', '2025-01-08', '2025-06-13'),
(32, 1, 'MP14', '2024-09-01', '2024-12-20'),
(33, 2, 'MP14', '2025-01-08', '2025-06-13'),
(34, 3, 'MP01', '2025-04-01', '2025-06-13'),
(35, 3, 'MP02', '2025-04-01', '2025-06-13'),
(36, 3, 'MP03', '2025-04-01', '2025-06-13'),
(37, 3, 'MP04', '2025-04-01', '2025-06-13'),
(38, 3, 'MP05', '2025-04-01', '2025-06-13');

--
-- Disparadors `ras`
--
DELIMITER $$
CREATE TRIGGER `verificarRa` BEFORE INSERT ON `ras` FOR EACH ROW BEGIN
    DECLARE exist INT DEFAULT 0;

    SELECT COUNT(*) INTO exist
    FROM ras
    WHERE ra = NEW.ra
      AND codi_assignatura = NEW.codi_assignatura;

    IF exist > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RA ja existent per a aquesta assignatura';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de la taula `sessions`
--

CREATE TABLE `sessions` (
  `id_session` int(11) NOT NULL,
  `dni_user` varchar(20) NOT NULL,
  `token` char(64) NOT NULL,
  `data_inici` datetime NOT NULL,
  `data_fin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `sessions`
--

INSERT INTO `sessions` (`id_session`, `dni_user`, `token`, `data_inici`, `data_fin`) VALUES
(40, '11111111A', 'b2121697855da39afcaf7bfdcb21a56ca3b2cbb3281aafc363784f62ad8711df', '2026-05-03 00:00:00', '2026-05-04 00:00:00'),
(41, '11111111A', '3ab676f7a619c141397acf8a3ce7a1cb903797be1b4f20092d686b7da2235443', '2026-05-03 00:00:00', '2026-05-04 00:00:00'),
(42, '11111111A', 'cf425b12e956c1329d170a83ffd6babf5df7cceb2045af17a01d38960378b309', '2026-05-03 00:00:00', '2026-05-04 00:00:00'),
(43, '11111111A', 'b017fef2d5bb026ad7fad8119ac823241e482f70c0600edd3270fb501bd970c0', '2026-05-03 00:00:00', '2026-05-04 00:00:00'),
(44, '11111111A', '14b6d07fd0cac990a807d41bb08556382aec77937716642293888296cdf312c1', '2026-05-03 00:00:00', '2026-05-04 00:00:00'),
(45, '11111111A', 'fa66ad05921947ab8d1573d2937f17bd3b64e55064ffd2d7d21ce6852040e858', '2026-05-03 00:00:00', '2026-05-04 00:00:00'),
(46, '11111111A', '438878390709ba53d83134e7908917aa19c6c12071631a9e9fc69a8c5be888c1', '2026-05-03 00:00:00', '2026-05-04 00:00:00'),
(47, '11111111A', '9c76b4f7d8733c10738a6de1f29a2bf89ed7a9e8e09fe293decb3e232ceca3dd', '2026-05-03 00:00:00', '2026-05-04 00:00:00'),
(48, '11111111A', 'ab8d980505d696a67e9e1fcdabd07f692601b9b57ea533f1565386bfeabf3e97', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(49, '11111111A', 'a625bb14c62e4b43e7ac1f4adcbe4d72363053e3c220770971fde1fabf7c9331', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(50, '11111111A', 'faf322f4f5d0254447f714ece90f0d7e77bbc35e89a62150d0f895ebff30e4ff', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(51, '11111111A', '6823f0edee710c361844ba85745af7d84141f40914564105b5c9e7c36ffc71b8', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(52, '11111111A', '3f360ad4a96d356e429cb1d72b8c0c55209ac6a45b7e41098635e72f8d1ad9a0', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(53, '11111111A', 'e2728607b62937b8d4c311f4f0d247612c899cd08907b13392d921ed0116a134', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(54, '11111111A', 'b3a9b7278f2f1ef0c6bec6185029db9c771e994c3f47407f67e208c9215989ca', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(55, '11111111A', 'c386b8ba5419aa74fb8b3e714d451d3fb318349962319f5297e77124dafa8c2d', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(56, '11111111A', 'da63389184cdf94e056d6b7fc52e3686eb2c8135cec510819e207743f302560e', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(57, '11111111A', '69ef853e591a56b62b5461a7542eeb62cf3eb95429b7aed5d7d18c3c91bb5ceb', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(58, '11111111A', '9692fb8cd7a49cbe54e3c19402042e36b0d3f2b5f697e69bf812d84275b1dfa7', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(59, '11111111A', '57659695cf433ea3811f6d9da0f5e2736bc3d50e69cc5d31ab09f67d395ee0da', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(60, '11111111A', '71483a21270f93fa292b560999ef0a82a2b934c0e0e199083c1d6223341b667b', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(61, '11111111A', '8a1510beda7cca50bd3bace12be5f5cebc57caf12e4ba60a1ce18177e757d9da', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(62, '11111111A', '598cc2182cf9fd15601419cc6ec2cdd8def6752a146515bda5c6dcde1a52de22', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(63, '11111111A', '8762861aacaff0e5649f10c4880a6992c2cb28cc519f287adc4cb6b372c11c93', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(64, '11111111A', 'f8708ce6d88377b0be29aa40be377f784aa13a4c15f20249579773b7c381adfc', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(65, '11111111A', '2fdd6b61ede0de1464fc2a8288ef0875adc5f000fc5a1f1114df5e52ff533e76', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(66, '11111111A', '1c8b32d9d9a099567478ee5037bd8f1310d511ce3a7e18423bf80131a6256607', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(67, '11111111A', '740895a3a522f30db682a71f21059c8dc7a5db2dab9f4f8d3b1e5e5482c90ce3', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(68, '11111111A', '4c00cfe94933e8183495390a884681a009b01b82c7467aa820fc3a8fc7bc69d3', '2026-05-04 00:00:00', '2026-05-04 00:00:00'),
(69, '11111111A', '1e2d0929f8bcd5f07f2a79d08ed36341f47a7e239fc62c820fd655d46f99e788', '2026-05-04 11:07:47', '2026-05-04 21:07:47'),
(70, '11111111A', '22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53', '2026-05-04 12:10:22', '2026-05-04 22:10:22'),
(71, '11111111A', '8d3722769d4c38dfa0607dd9f2618017685cecc7fbccb2b3eed5a34b02d0edcc', '2026-05-04 15:32:14', '2026-05-05 01:32:14'),
(72, '11111111A', '9006d4e0bd8d682c862b54538b09d1ecdb9ccb2e5f6a534008621df951747cf6', '2026-05-04 15:54:27', '2026-05-05 01:54:27'),
(73, '11111111A', '0937ba0b11df4000c5cd6bf1b9af90e4e9d7f519efaf4bdb0d463de5da90fa20', '2026-05-04 17:55:50', '2026-05-05 03:55:50'),
(74, '11111111A', '6ea9d7bea859b041866fcd369b76de5746f22646d8831f0496eaf11cd19b9a2a', '2026-05-04 18:02:01', '2026-05-05 04:02:01'),
(75, '11111111A', '21677a78aa7f19d7370158b6aa13d0f4d19e7f9bc6d60edbc19cf667318a56e1', '2026-05-04 18:08:52', '2026-05-05 04:08:52'),
(76, '11111111A', '958de2cbcc8d8f7aee927e38b444739c785cf72b0b56333d5e47f5e17ba36ba0', '2026-05-04 18:09:41', '2026-05-05 04:09:41'),
(77, '11111111A', '8ac8065b179de613a351f6d336aa243d3a2b0016dca92bd9d65bf5238d672b62', '2026-05-04 18:12:01', '2026-05-05 04:12:01'),
(78, '11111111A', '7ee801f6268a6079e8ab5a831978998bcfa3df96c80d505ce3bfe60593479a19', '2026-05-04 18:18:53', '2026-05-05 04:18:53'),
(79, '11111111A', '702cdc92fd5a6845f63c4548848e65c98ad4c3f0bd4079c59a94fe3b6e99e71e', '2026-05-04 20:47:34', '2026-05-05 06:47:34'),
(80, '11111111A', '3424043994479000585d270d4ed109265eaa4979997b7f770d620b5d437d56b9', '2026-05-04 21:14:03', '2026-05-05 07:14:03'),
(81, '11111111A', '2cf8b4ef4283e418295dbdf18eee97a2c849c93e1a9c65620d977572ecef2851', '2026-05-04 21:17:48', '2026-05-05 07:17:48'),
(82, '11111111A', 'f4b8c39925b92097a5e176624d78805035006cf01e94744b6ed570c21959ebe5', '2026-05-04 22:22:22', '2026-05-05 08:22:22'),
(83, '11111111A', 'ef0af51acfa7a8d2da65f1f1ddc9c03bcfe4665c46caf4b764c2b0baab005de2', '2026-05-04 22:28:38', '2026-05-05 08:28:38'),
(84, '11111111A', '989e6e8753ec332815143546ebb6555adda50abca5828843e490a4b5f11b2b69', '2026-05-04 22:31:44', '2026-05-05 08:31:44'),
(85, '11111111A', '5ed99ae6c7c1e0e89bce07e53b55a0c898e64cd827e1c0dbe6f57214b1e14155', '2026-05-04 22:32:24', '2026-05-05 08:32:24'),
(86, '11223344K', 'b27aa2069edc6ef58360ae01b8e47996e4dcaed7e777c7dc9ef26b933a8210de', '2026-05-04 22:37:57', '2026-05-05 08:37:57'),
(87, '11223344K', 'b457207a79c41cc6129b2b1aa2f8320cbc78bd0707d019f4b868ecbafcf8ca45', '2026-05-04 22:45:28', '2026-05-05 08:45:28'),
(88, '11223344K', '2f28544d1d36799f86b51e8164ced245976bb5279342065cc04d30059b2c1726', '2026-05-04 22:46:18', '2026-05-05 08:46:18'),
(89, '12345678A', '5af25425310df145579329a6fa96244d10625cbb8432c70a60d64b5aaf0eb4aa', '2026-05-04 22:47:09', '2026-05-05 08:47:09'),
(90, '11223344K', 'c612d3dba1cb54a11af4dfc47f1915840a4b802a3752fb3513a804701f69ff36', '2026-05-04 22:48:14', '2026-05-05 08:48:14'),
(91, '11223344K', '942160b433f1614d071fb1488d0c51a20f3cdc422ff30449ddf3efebfd038d2b', '2026-05-04 22:49:42', '2026-05-05 08:49:42'),
(92, '11223344K', '89d7fc72c8b8e420c8f82491f67e2523c7b51dcc9259ec9287f7072afef34af7', '2026-05-04 22:59:18', '2026-05-05 08:59:18'),
(93, '12345678A', '80dd6c786e8a722c8526eb37d1891b7fbdebc8ca4443ca74c63d36d39947d891', '2026-05-04 22:59:51', '2026-05-05 08:59:51'),
(94, '12345678A', '4dc85c90e235c7999cc8cb4a6ad5d77fe7595a35f55234120f39877626574807', '2026-05-05 16:26:19', '2026-05-06 02:26:19'),
(95, '11223344K', 'c6af8e692e2e81a669c1835606908bc96d2fa5dca8f6eb8d45cd894033a821e4', '2026-05-05 16:27:31', '2026-05-06 02:27:31'),
(96, '12345678A', '47e909600e18cfc85c9b735d71e4e61db582fa26c553e8028ec31ab78bd68b8f', '2026-05-05 16:29:53', '2026-05-06 02:29:53'),
(97, '11223344K', '74cf74b22d536fc88e5e278c9bd53cc0bfa442849eb45702c36315d91f6f9022', '2026-05-05 16:34:20', '2026-05-06 02:34:20'),
(98, '12345678A', 'aa9aa2dbca78ed5cec15563d44f54d4c6dc8b43cf2cf7ce7ce7e91820a9e4563', '2026-05-05 16:36:46', '2026-05-06 02:36:46'),
(99, '12345678A', 'bb372cf5ac1105a9a8326b6b3b8b2ad5d044501d1e248c56141e59635098cc0d', '2026-05-05 16:45:12', '2026-05-06 02:45:12'),
(100, '12345678A', 'f2884a5476bb03b2ddf0c7f5099595b6a9db7832780264fb4d87df9d4111dbcc', '2026-05-05 16:47:08', '2026-05-06 02:47:08'),
(101, '12345678A', '2bb428baf5bb73124b3ccc61927bd20e21ae6f388d3635b2e303b5e1380d9ec7', '2026-05-05 16:48:00', '2026-05-06 02:48:00'),
(102, '12345678A', '0f7a97f7de8a0292afd1b966a7031fee050b8a4e91a2325ea1a9a94f64b63611', '2026-05-05 16:49:54', '2026-05-06 02:49:54'),
(103, '12345678A', 'ac43a39e1665b771ab4472f56c37ad50606c63ee7fd38330c56c0b62c9f970a5', '2026-05-05 16:51:19', '2026-05-06 02:51:19'),
(104, '12345678A', '1d26bf0a32880ec981f4932aae80f80d7342c42c27107d7a2f295cf98b002048', '2026-05-05 16:52:03', '2026-05-06 02:52:03'),
(105, '12345678A', '227c5e2c1320bf0c2777655f17c2443783b82f93734ac6ff9ef15820cf21c452', '2026-05-05 19:19:51', '2026-05-06 05:19:51'),
(106, '12345678A', 'aeeada283a8b55f9619fdf3396098527f127f3a19043dec9558137c2ccd2c15b', '2026-05-05 19:24:36', '2026-05-06 05:24:36'),
(107, '12345678A', 'fe784636af3270e42373269b2b4d98a2f8f30843da880074d90f9fcfa8a0d464', '2026-05-05 19:26:53', '2026-05-06 05:26:53'),
(108, '12345678A', '82934d3329e59a45435db4879c5a25cb230930c425e49d31efe8a262fef827d3', '2026-05-05 19:29:49', '2026-05-06 05:29:49'),
(109, '11223344K', '3d661666a44300e36b73a0261824910386bc6c904ed22d17e8809636788b7b20', '2026-05-05 19:30:17', '2026-05-06 05:30:17'),
(110, '12345678A', '910a52d14a695cb727d2aea965185145e1f200653c8cf1a3caa008f1a68983e6', '2026-05-05 19:51:01', '2026-05-06 05:51:01'),
(111, '12345678A', '8e38a0a5d280bdeed9fcf91dc05879b85479a87c4af08a418f36f969cfcb4569', '2026-05-05 19:53:46', '2026-05-06 05:53:46'),
(112, '12345678A', 'd94840846a452a7a17e614982b1067b380a7aa5a3a7ea13374296454331d74d7', '2026-05-05 19:56:34', '2026-05-06 05:56:34'),
(113, '11223344K', '9aa29cbd8829911e78206dc4b8d4c4f35e6460fea22361cf71ca65ce9726b1c4', '2026-05-05 20:11:40', '2026-05-06 06:11:40'),
(114, '11223344K', '61b20eed96035f7d87c01c325b718b651322c241c0ec829217f6f5ba26670ecf', '2026-05-05 20:17:35', '2026-05-06 06:17:35'),
(115, '11223344K', 'f0ab1c9c857279417ecee7001c58079f95237a83d48479210106b35960fecb96', '2026-05-05 20:36:58', '2026-05-06 06:36:58'),
(116, '11223344K', 'd807375d518ef75667a485eecb8e5bd9d2968b3a0125789c29f95523e7920899', '2026-05-05 20:38:21', '2026-05-06 06:38:21'),
(117, '11223344K', 'ee7e9da5a271dde6e56177af4a11056b28737633b37448c0e9dd39a3acabe2ac', '2026-05-05 21:07:35', '2026-05-06 07:07:35'),
(118, '11223344K', 'cc1bf52bac1b8fcaea7e0778c3f4cd0bec365649216fc6e4c2a855df25717077', '2026-05-05 21:10:07', '2026-05-06 07:10:07'),
(119, '11223344K', '50b6e73019fa028f515b085c015e57bcbcef13519d0401afd2607595ca2eaf0d', '2026-05-05 21:13:17', '2026-05-06 07:13:17'),
(120, '11223344K', 'f51b0ae5cc42d2596220091d3a130a6174c4d68bdeee6acc2553603a136009fd', '2026-05-05 21:15:02', '2026-05-06 07:15:02'),
(121, '11223344K', '9dcd60405d7108fdfe8304919782d3cd6558ac6300522a32ed341d719b3d809f', '2026-05-05 21:15:46', '2026-05-06 07:15:46'),
(122, '11223344K', 'a040b6ec1136b62a9e4421228d1eb0f3507b86844687eabbb5c82e2e6f7a7588', '2026-05-05 21:19:42', '2026-05-06 07:19:42'),
(123, '11223344K', '07010bfa56d7bca3e1a6d4d54efde6b3c5213b9c372515d52f777e6c67476bb7', '2026-05-05 21:21:32', '2026-05-06 07:21:32'),
(124, '11223344K', '1a2906219626592673f63791c653e7710d9c0f388d1d865ef26cefa72935267b', '2026-05-05 23:08:39', '2026-05-06 09:08:39'),
(125, '11223344K', '439c399404433e06f3a5ce43abbe4d21cec89b99c5fe5a25247efa57158a6e0d', '2026-05-05 23:09:43', '2026-05-06 09:09:43'),
(126, '11223344K', 'a06ac821d0721c9adcaa507ff7f3634d51ab3c9df0abda99e2bd1b00041b6ecb', '2026-05-05 23:13:53', '2026-05-06 09:13:53'),
(127, '11223344K', '26ff921cd1d48cc09f9d1c839a20fb81f233879efa879beb2095e6c6a0f97eda', '2026-05-05 23:15:23', '2026-05-06 09:15:23'),
(128, '11223344K', 'b3e429f6bd1d1e52430f6c37216e67eebe27d90d007f78f349e74b5a7be66c2b', '2026-05-05 23:17:05', '2026-05-06 09:17:05'),
(129, '11223344K', '81652a34db893a6c3dd230f8de8241abf7722f14c73c22e7bfbb45309c5e1d4b', '2026-05-05 23:21:13', '2026-05-06 09:21:13'),
(130, '11223344K', 'f01743b3d056080ce48be86ecf0c7ada983f0e984147bfc827ecec17321eed66', '2026-05-05 23:23:51', '2026-05-06 09:23:51'),
(131, '11223344K', 'fb1c20de33d9a88c6c338a805cc2408d4bc4503032577ac44da55f146d97569f', '2026-05-05 23:24:58', '2026-05-06 09:24:58'),
(132, '12345678A', '82b438afed137aaa1f47e5dbb4556e527bf6f74320181708a262d8a684498983', '2026-05-05 23:25:25', '2026-05-06 09:25:25'),
(133, '11223344K', '536076c99602cc4153c16d8e63ee8e25597cfa049cb2da9f33e6555598dd6d9f', '2026-05-05 23:26:50', '2026-05-06 09:26:50'),
(134, '12345678A', '5a1063f390f88de45e9aeca34f4c4338d807b6190ecd0868c2ff667c3be47d65', '2026-05-05 23:35:40', '2026-05-06 09:35:40'),
(135, '11223344K', 'c073409decff1e70db137e3fd3a476302b9807ffeff65ada4cccaad72ef37e24', '2026-05-05 23:37:13', '2026-05-06 09:37:13'),
(136, '12345678A', '56981994b9cb90791c21b60d85da2415cfe9d2bfe7d817a420f73f6fd105696b', '2026-05-05 23:38:02', '2026-05-06 09:38:02'),
(137, '11223344K', '36150aee88a31e5e4ec08cac6a85db92f0e684b42c4d78a19cce381b092f71c7', '2026-05-05 23:46:38', '2026-05-06 09:46:38'),
(138, '11223344K', '0a189ddb69755a2f17d364c36e64e4128fb0cd482504ff56338a2818efd4ee15', '2026-05-06 00:02:45', '2026-05-06 10:02:45'),
(139, '11223344K', 'a9799ad7a90e77a5b1576e8681332ea20904eea88d108e842f92a4f227ee6735', '2026-05-06 00:05:15', '2026-05-06 10:05:15'),
(140, '11223344K', 'e9fb5c0cf190ebe5b2c4be275fea908a86dfad80f96869a4a3b8feee786679aa', '2026-05-06 00:07:05', '2026-05-06 10:07:05'),
(141, '12345678A', '1b76454daf5760e55f7728cf4c658e89d01d7b4f3b739c2ede78bcd56003239a', '2026-05-06 00:10:01', '2026-05-06 10:10:01'),
(142, '11223344K', '9c77ef5990699d3cd3759f0512a8ab157520ec9889242821402bafe2a2270bb5', '2026-05-06 00:10:17', '2026-05-06 10:10:17'),
(143, '11223344K', '0d2fde6b16faf2a4a0f6b9e0c685993292629539a395984b8b09c23160e36278', '2026-05-06 00:13:37', '2026-05-06 10:13:37'),
(144, '11223344K', 'b30de5454e9bbe3b025770c1c28e3be2b215e8584e8171f7939aa7a6ba9baceb', '2026-05-06 00:16:05', '2026-05-06 10:16:05'),
(145, '11223344K', '735b7e209c159c3e9941fc7c847f6e212890f8d28dbd65a77877cf933e7f1c01', '2026-05-06 00:18:12', '2026-05-06 10:18:12'),
(146, '11223344K', 'c5ea8015050365649c6a358055232ec477e5da8101bf6f30163b3ea6f41e27e3', '2026-05-06 00:19:33', '2026-05-06 10:19:33'),
(147, '11223344K', '987f5fb109377658bf162bac9127296bc432004df495b4cba62bc3509f44968b', '2026-05-06 00:22:30', '2026-05-06 10:22:30'),
(148, '11223344K', '01fb0e7f1f0bbde9a6be38fe843f0098853e758ea21aa7e14d46334e102164a9', '2026-05-06 00:26:33', '2026-05-06 10:26:33'),
(149, '11223344K', '6b121b37ab4ce37d5f0eccb885d2abcb3d5afa53140733bda1ea5995beea677f', '2026-05-06 00:30:36', '2026-05-06 10:30:36'),
(150, '11223344K', '34aebf247152413b315f9b7a33fd974d2efa0fbee57e936da8b1e66d85e4920e', '2026-05-06 00:34:34', '2026-05-06 10:34:34'),
(151, '11223344K', 'c03f97386f9d244dea76ee82766b35be80936d4c48f145413984321c15bc19ba', '2026-05-06 00:39:26', '2026-05-06 10:39:26'),
(152, '11223344K', '0d8b3378ab1b0e2ebfadb24ed5c29f90d9d16abf2d56784e488448c80c638f3e', '2026-05-06 00:49:42', '2026-05-06 10:49:42'),
(153, '11223344K', '7028467a9ba7a6b24ff5f6db86b5c1c82fbedd0fa9794ef213a7f62698f0ec2e', '2026-05-06 00:52:06', '2026-05-06 10:52:06'),
(154, '11223344K', '1023dae88478d6c0f3bc66b575cb0392d26d3a67f8abfe7b30c44da8769fc21e', '2026-05-06 01:27:40', '2026-05-06 11:27:40'),
(155, '11223344K', '0b90c8d279e9b817a011d2839d7b72be3beae1e790e3ee5ec1d81124533d85a9', '2026-05-06 01:29:31', '2026-05-06 11:29:31');

-- --------------------------------------------------------

--
-- Estructura de la taula `usuaris`
--

CREATE TABLE `usuaris` (
  `id_user` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `username` varchar(11) NOT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Bolcament de dades per a la taula `usuaris`
--

INSERT INTO `usuaris` (`id_user`, `dni`, `username`, `password`) VALUES
(32, '12345678A', 'mserrapuig', '$2y$10$RZP.e1Zu5wBVlRnarJnytOpIsc9.6avn7OOxV5SomlLSsP4Dts/U2'),
(33, '23456789B', 'aribassoler', NULL),
(34, '34567890C', 'jcasasvila', NULL),
(35, '45678901D', 'mpuigferrer', NULL),
(36, '56789012E', 'pantonlópez', NULL),
(37, '67890123F', 'lsánchezmor', NULL),
(38, '78901234G', 'cdomènechro', NULL),
(39, '89012345H', 'npérezvidal', NULL),
(40, '90123456I', 'xfontmir', NULL),
(41, '11223344K', 'etorresprat', '$2y$10$ll0uPllujPKOmPBDJ0NtsOKmgc5ccmIcW7YIlkkOQG7CKO/os3qWi'),
(42, '11111111A', 'pgomezruiz', '$2y$10$/ZKL1KG4UBPb8szT/vTWcOoZp31I3f6vSv1b.QYF8GBoNgUbRhaUK'),
(43, '22222222B', 'amartísoler', NULL),
(44, '33333333C', 'ncostariba', NULL),
(45, '44444444D', 'lromerogil', NULL),
(46, '55555555E', 'jnavarropui', NULL),
(47, '66666666F', 'cortizvila', NULL),
(48, '77777777G', 'esolerllore', NULL),
(49, '88888888H', 'ireigamat', NULL),
(50, '99999999I', 'bpascualser', NULL),
(51, '10101010J', 'evidaltorre', NULL),
(52, '12121212L', 'aboschcamps', NULL),
(53, '13131313M', 'jferrerpons', NULL),
(54, '14141414N', 'rllopismas', NULL),
(55, '15151515P', 'cmoraesteve', NULL),
(56, '16161616Q', 'mtorrentsgi', NULL),
(57, '17171717R', 'smasvidal', NULL),
(58, '18181818S', 'procagimeno', NULL),
(59, '19191919T', 'nsalapont', NULL),
(60, '20202020U', 'ovilacamps', NULL),
(61, '21212121V', 'mponsesteve', NULL),
(62, '22222223W', 'gllopistort', NULL),
(63, '23232323X', 'mferrermas', NULL),
(64, '24242424Y', 'dsolerriba', NULL),
(65, '25252525Z', 'opuigtort', NULL),
(66, '26262626A', 'bcomavalls', NULL),
(67, '27272727B', 'amirprat', NULL),
(68, '28282828C', 'gtortbosch', NULL),
(69, '29292929D', 'lfontsala', NULL),
(70, '30303030E', 'acampsmir', NULL),
(71, '31313131F', 'cvallsroca', NULL),
(72, '32323232G', 'maguilarbla', NULL),
(73, '33323232H', 'cbeltranvid', NULL),
(74, '34323232I', 'rgimenezpon', NULL),
(75, '35323232J', 'mllopiscamp', NULL),
(76, '36323232K', 'trovirasole', NULL);

--
-- Índexs per a les taules bolcades
--

--
-- Índexs per a la taula `acta_avaluacio`
--
ALTER TABLE `acta_avaluacio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_acta_assignatura` (`id_assignatura`),
  ADD KEY `fk_acta_grup` (`nom_grup`);

--
-- Índexs per a la taula `acta_notes`
--
ALTER TABLE `acta_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_notes_acta` (`id_acta`),
  ADD KEY `fk_notes_estudiant` (`nia`);

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
-- Índexs per a la taula `cursos_cicle`
--
ALTER TABLE `cursos_cicle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nom_cicle` (`nom_cicle`);

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
-- Índexs per a la taula `historic_actes`
--
ALTER TABLE `historic_actes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_hist_acta` (`id_acta`),
  ADD KEY `fk_hist_professor` (`dni_professor`);

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
  ADD KEY `fk_logs_consultes_dni` (`dni_user`);

--
-- Índexs per a la taula `logs_login`
--
ALTER TABLE `logs_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logs_login_dni` (`dni_user`);

--
-- Índexs per a la taula `periodes_avaluacio`
--
ALTER TABLE `periodes_avaluacio`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_trimestre_curs` (`trimestre`,`curs`),
  ADD KEY `fk_periode_persona` (`obert_per`);

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
  ADD PRIMARY KEY (`id_session`);

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
-- AUTO_INCREMENT per la taula `acta_avaluacio`
--
ALTER TABLE `acta_avaluacio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT per la taula `acta_notes`
--
ALTER TABLE `acta_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT per la taula `administradors`
--
ALTER TABLE `administradors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT per la taula `admin_centre`
--
ALTER TABLE `admin_centre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT per la taula `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT per la taula `assistencia`
--
ALTER TABLE `assistencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT per la taula `contractes`
--
ALTER TABLE `contractes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT per la taula `cursos_cicle`
--
ALTER TABLE `cursos_cicle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la taula `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=344;

--
-- AUTO_INCREMENT per la taula `historic_actes`
--
ALTER TABLE `historic_actes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la taula `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT per la taula `historic_fct`
--
ALTER TABLE `historic_fct`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT per la taula `historic_professors`
--
ALTER TABLE `historic_professors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT per la taula `logs_consultes`
--
ALTER TABLE `logs_consultes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=203;

--
-- AUTO_INCREMENT per la taula `logs_login`
--
ALTER TABLE `logs_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT per la taula `periodes_avaluacio`
--
ALTER TABLE `periodes_avaluacio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT per la taula `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT per la taula `ras`
--
ALTER TABLE `ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT per la taula `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id_session` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT per la taula `usuaris`
--
ALTER TABLE `usuaris`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- Restriccions per a les taules bolcades
--

--
-- Restriccions per a la taula `acta_avaluacio`
--
ALTER TABLE `acta_avaluacio`
  ADD CONSTRAINT `fk_acta_assignatura` FOREIGN KEY (`id_assignatura`) REFERENCES `assignatures` (`codi`),
  ADD CONSTRAINT `fk_acta_grup` FOREIGN KEY (`nom_grup`) REFERENCES `grup_classe` (`nom`);

--
-- Restriccions per a la taula `acta_notes`
--
ALTER TABLE `acta_notes`
  ADD CONSTRAINT `fk_notes_acta` FOREIGN KEY (`id_acta`) REFERENCES `acta_avaluacio` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_notes_estudiant` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`);

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
-- Restriccions per a la taula `cursos_cicle`
--
ALTER TABLE `cursos_cicle`
  ADD CONSTRAINT `cursos_cicle_ibfk_1` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`) ON UPDATE CASCADE;

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
-- Restriccions per a la taula `historic_actes`
--
ALTER TABLE `historic_actes`
  ADD CONSTRAINT `fk_hist_acta` FOREIGN KEY (`id_acta`) REFERENCES `acta_avaluacio` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_hist_professor` FOREIGN KEY (`dni_professor`) REFERENCES `persones` (`dni`);

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
  ADD CONSTRAINT `fk_logs_consultes_dni` FOREIGN KEY (`dni_user`) REFERENCES `usuaris` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restriccions per a la taula `logs_login`
--
ALTER TABLE `logs_login`
  ADD CONSTRAINT `fk_logs_login_dni` FOREIGN KEY (`dni_user`) REFERENCES `usuaris` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restriccions per a la taula `periodes_avaluacio`
--
ALTER TABLE `periodes_avaluacio`
  ADD CONSTRAINT `fk_periode_persona` FOREIGN KEY (`obert_per`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE;

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
-- Restriccions per a la taula `usuaris`
--
ALTER TABLE `usuaris`
  ADD CONSTRAINT `fk_usuaridni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
