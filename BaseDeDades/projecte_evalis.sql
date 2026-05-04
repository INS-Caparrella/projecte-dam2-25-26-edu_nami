-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 04-05-2026 a las 15:14:42
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

DELIMITER $$
--
-- Procedimientos
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
-- Funciones
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
-- Estructura de tabla para la tabla `acta_avaluacio`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acta_notes`
--

CREATE TABLE `acta_notes` (
  `id` int(11) NOT NULL,
  `id_acta` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nota_final` decimal(10,0) NOT NULL,
  `repetidor` tinyint(1) NOT NULL,
  `treballant` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradors`
--

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
-- Estructura de tabla para la tabla `admin_centre`
--

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
-- Estructura de tabla para la tabla `assignatures`
--

CREATE TABLE `assignatures` (
  `codi` varchar(25) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `departament` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `assignatures`
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
-- Estructura de tabla para la tabla `assignatures_cicle`
--

CREATE TABLE `assignatures_cicle` (
  `id` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `assignatures_cicle`
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
-- Estructura de tabla para la tabla `assistencia`
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
-- Volcado de datos para la tabla `assistencia`
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
-- Estructura de tabla para la tabla `centres`
--

CREATE TABLE `centres` (
  `codi` int(11) NOT NULL,
  `nom` varchar(256) NOT NULL,
  `data_inaug` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `centres`
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
-- Estructura de tabla para la tabla `cicles`
--

CREATE TABLE `cicles` (
  `nom` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cicles`
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
-- Estructura de tabla para la tabla `contractes`
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
-- Volcado de datos para la tabla `contractes`
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
-- Estructura de tabla para la tabla `cursos_cicle`
--

CREATE TABLE `cursos_cicle` (
  `id` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `grado` enum('1r','2n') NOT NULL,
  `hores_total` int(11) NOT NULL,
  `any_inici_referencia` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos_cicle`
--

INSERT INTO `cursos_cicle` (`id`, `nom_cicle`, `grado`, `hores_total`, `any_inici_referencia`) VALUES
(1, 'CFGM Sistemes Microinformatics i Xarxes', '1r', 800, '2021'),
(2, 'CFGM Sistemes Microinformatics i Xarxes', '2n', 900, '2022'),
(3, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1000, '2023'),
(4, 'CFGS Desenvolupament Aplicacions Multiplataforma', '2n', 1100, '2024'),
(5, 'CFGS Desenvolupament Aplicacions Web', '1r', 1000, '2023'),
(6, 'CFGS Desenvolupament Aplicacions Web', '2n', 1100, '2024');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `directiva`
--

CREATE TABLE `directiva` (
  `rol` varchar(25) NOT NULL,
  `codi_prof` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `directiva`
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
-- Estructura de tabla para la tabla `estudiants`
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
-- Volcado de datos para la tabla `estudiants`
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
-- Disparadores `estudiants`
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
-- Estructura de tabla para la tabla `estudiants_ras`
--

CREATE TABLE `estudiants_ras` (
  `id` int(11) NOT NULL,
  `id_ra` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nota` decimal(10,0) NOT NULL,
  `data_inici` date NOT NULL DEFAULT '2024-09-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiants_ras`
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
(213, 30, 1001, 7, '2023-01-09');

--
-- Disparadores `estudiants_ras`
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
-- Estructura de tabla para la tabla `grup_classe`
--

CREATE TABLE `grup_classe` (
  `nom` varchar(25) NOT NULL,
  `aula` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grup_classe`
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
-- Estructura de tabla para la tabla `historic_actes`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historic_estudiants`
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
-- Volcado de datos para la tabla `historic_estudiants`
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
-- Estructura de tabla para la tabla `historic_fct`
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
-- Volcado de datos para la tabla `historic_fct`
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
-- Estructura de tabla para la tabla `historic_professors`
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
-- Volcado de datos para la tabla `historic_professors`
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
-- Estructura de tabla para la tabla `logs_consultes`
--

CREATE TABLE `logs_consultes` (
  `id` int(11) NOT NULL,
  `dni_user` varchar(20) NOT NULL,
  `consulta` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logs_consultes`
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
(148, '11111111A', '/get_estudis.php?dni=11111111A&token=22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_login`
--

CREATE TABLE `logs_login` (
  `id` int(11) NOT NULL,
  `dni_user` varchar(20) NOT NULL,
  `ip` int(12) NOT NULL,
  `exito` tinyint(1) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodes_avaluacio`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persones`
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
-- Volcado de datos para la tabla `persones`
--

INSERT INTO `persones` (`dni`, `nom`, `cognom`, `data_naix`, `poblacio`, `codi_postal`, `nacionalitat`, `municipi_naix`, `telf_mob`, `telf_fix`, `email`, `ruta_foto`, `rol`) VALUES
('10101010J', 'Emma', 'Vidal Torres', '2006-01-30', 'Lleida', 25005, 'Espanyola', 'Lleida', 610101010, 973101010, 'emma.vidal@alumne.cat', 'img/alumns/alum10.jpg', 'alumne'),
('11111111A', 'Pol', 'Gómez Ruiz', '2005-02-18', 'Lleida', 25001, 'Espanyola', 'Lleida', 611111111, 973111111, 'pol.gomez@alumne.cat', 'img/alumns/alum01.jpg', 'alumne'),
('11223344K', 'Eva', 'Torres Prat', '1974-12-05', 'Lleida', 25005, 'Espanyola', 'Lleida', 611223344, 973223344, 'eva.torres@institut.cat', 'img/profs/prof10.jpg', 'administrador'),
('12121212L', 'Arnau', 'Bosch Camps', '2005-06-15', 'Lleida', 25001, 'Espanyola', 'Lleida', 612121212, 973121212, 'arnau.bosch@alumne.cat', 'img/alumns/alum11.jpg', 'alumne'),
('12345678A', 'Marc', 'Serra Puig', '1978-03-12', 'Lleida', 25001, 'Espanyola', 'Lleida', 612345678, 973345678, 'marc.serra@institut.cat', 'img/profs/prof01.jpg', 'professor'),
('13131313M', 'Júlia', 'Ferrer Pons', '2006-02-28', 'Lleida', 25001, 'Espanyola', 'Lleida', 613131313, 973131313, 'julia.ferrer@alumne.cat', 'img/alumns/alum12.jpg', 'alumne'),
('14141414N', 'Roger', 'Llopis Mas', '2004-11-09', 'Lleida', 25002, 'Espanyola', 'Lleida', 614141414, 973141414, 'roger.llopis@alumne.cat', 'img/alumns/alum13.jpg', 'alumne'),
('15151515P', 'Carla', 'Mora Esteve', '2005-03-22', 'Lleida', 25002, 'Espanyola', 'Lleida', 615151515, 973151515, 'carla.mora@alumne.cat', 'img/alumns/alum14.jpg', 'alumne'),
('16161616Q', 'Marc', 'Torrents Gil', '2004-07-04', 'Lleida', 25003, 'Espanyola', 'Lleida', 616161616, 973161616, 'marc.torrents@alumne.cat', 'img/alumns/alum15.jpg', 'alumne'),
('17171717R', 'Sofia', 'Mas Vidal', '2005-05-12', 'Lleida', 25001, 'Espanyola', 'Lleida', 617171717, 973171717, 'sofia.mas@alumne.cat', 'img/alumns/alum16.jpg', 'alumne'),
('18181818S', 'Pau', 'Roca Gimeno', '2006-03-18', 'Lleida', 25001, 'Espanyola', 'Lleida', 618181818, 973181818, 'pau.roca@alumne.cat', 'img/alumns/alum17.jpg', 'alumne'),
('19191919T', 'Neus', 'Sala Pont', '2005-11-25', 'Lleida', 25002, 'Espanyola', 'Lleida', 619191919, 973191919, 'neus.sala@alumne.cat', 'img/alumns/alum18.jpg', 'alumne'),
('20202020U', 'Oriol', 'Vila Camps', '2006-07-04', 'Lleida', 25002, 'Espanyola', 'Lleida', 620202020, 973202020, 'oriol.vila@alumne.cat', 'img/alumns/alum19.jpg', 'alumne'),
('21212121V', 'Marina', 'Pons Esteve', '2005-09-30', 'Lleida', 25003, 'Espanyola', 'Lleida', 621212121, 973212121, 'marina.pons@alumne.cat', 'img/alumns/alum20.jpg', 'alumne'),
('22222222B', 'Aina', 'Martí Soler', '2006-11-05', 'Lleida', 25001, 'Espanyola', 'Lleida', 622222222, 973222222, 'aina.marti@alumne.cat', 'img/alumns/alum02.jpg', 'alumne'),
('22222223W', 'Gerard', 'Llopis Tort', '2004-12-15', 'Lleida', 25003, 'Espanyola', 'Lleida', 622222223, 973222223, 'gerard.llopis@alumne.cat', 'img/alumns/alum21.jpg', 'alumne'),
('23232323X', 'Mireia', 'Ferrer Mas', '2005-06-08', 'Lleida', 25004, 'Espanyola', 'Lleida', 623232323, 973232323, 'mireia.ferrer@alumne.cat', 'img/alumns/alum22.jpg', 'alumne'),
('23456789B', 'Anna', 'Ribas Soler', '1982-07-24', 'Lleida', 25001, 'Espanyola', 'Lleida', 623456789, 973456789, 'anna.ribas@institut.cat', 'img/profs/prof02.jpg', 'professor'),
('24242424Y', 'Dani', 'Soler Riba', '2006-01-22', 'Lleida', 25004, 'Espanyola', 'Lleida', 624242424, 973242424, 'dani.soler@alumne.cat', 'img/alumns/alum23.jpg', 'alumne'),
('25252525Z', 'Ona', 'Puig Tort', '2005-04-17', 'Lleida', 25005, 'Espanyola', 'Lleida', 625252525, 973252525, 'ona.puig@alumne.cat', 'img/alumns/alum24.jpg', 'alumne'),
('26262626A', 'Bernat', 'Coma Valls', '2004-08-29', 'Lleida', 25005, 'Espanyola', 'Lleida', 626262626, 973262626, 'bernat.coma@alumne.cat', 'img/alumns/alum25.jpg', 'alumne'),
('27272727B', 'Alba', 'Mir Prat', '2005-03-11', 'Lleida', 25001, 'Espanyola', 'Lleida', 627272727, 973272727, 'alba.mir@alumne.cat', 'img/alumns/alum26.jpg', 'alumne'),
('28282828C', 'Guillem', 'Tort Bosch', '2006-10-03', 'Lleida', 25001, 'Espanyola', 'Lleida', 628282828, 973282828, 'guillem.tort@alumne.cat', 'img/alumns/alum27.jpg', 'alumne'),
('29292929D', 'Laura', 'Font Sala', '2005-07-19', 'Lleida', 25002, 'Espanyola', 'Lleida', 629292929, 973292929, 'laura.font@alumne.cat', 'img/alumns/alum28.jpg', 'alumne'),
('30303030E', 'Alex', 'Camps Mir', '2004-02-06', 'Lleida', 25002, 'Espanyola', 'Lleida', 630303030, 973303030, 'alex.camps@alumne.cat', 'img/alumns/alum29.jpg', 'alumne'),
('31313131F', 'Claudia', 'Valls Roca', '2006-05-24', 'Lleida', 25003, 'Espanyola', 'Lleida', 631313131, 973313131, 'claudia.valls@alumne.cat', 'img/alumns/alum30.jpg', 'alumne'),
('32323232G', 'Miquel', 'Aguilar Blasco', '1980-04-14', 'Lleida', 25003, 'Espanyola', 'Lleida', 632323232, 973323232, 'miquel.aguilar@institut.cat', 'img/profs/prof11.jpg', 'professor'),
('33323232H', 'Cristina', 'Beltran Vidal', '1977-09-21', 'Lleida', 25004, 'Espanyola', 'Lleida', 633323232, 973332323, 'cristina.beltran@institut.cat', 'img/profs/prof12.jpg', 'professor'),
('33333333C', 'Nil', 'Costa Riba', '2005-07-23', 'Lleida', 25002, 'Espanyola', 'Lleida', 633333333, 973333333, 'nil.costa@alumne.cat', 'img/alumns/alum03.jpg', 'alumne'),
('34323232I', 'Raul', 'Gimenez Pons', '1983-01-08', 'Lleida', 25004, 'Espanyola', 'Lleida', 634323232, 973342323, 'raul.gimenez@institut.cat', 'img/profs/prof13.jpg', 'professor'),
('34567890C', 'Jordi', 'Casas Vila', '1975-11-03', 'Lleida', 25002, 'Espanyola', 'Lleida', 634567890, 973567890, 'jordi.casas@institut.cat', 'img/profs/prof03.jpg', 'professor'),
('35323232J', 'Montse', 'Llopis Camps', '1979-06-30', 'Lleida', 25005, 'Espanyola', 'Lleida', 635323232, 973352323, 'montse.llopis@institut.cat', 'img/profs/prof14.jpg', 'professor'),
('36323232K', 'Toni', 'Rovira Soler', '1981-11-15', 'Lleida', 25005, 'Espanyola', 'Lleida', 636323232, 973362323, 'toni.rovira@institut.cat', 'img/profs/prof15.jpg', 'professor'),
('44444444D', 'Laia', 'Romero Gil', '2005-09-14', 'Lleida', 25002, 'Espanyola', 'Lleida', 644444444, 973444444, 'laia.romero@alumne.cat', 'img/alumns/alum04.jpg', 'alumne'),
('45678901D', 'Marta', 'Puig Ferrer', '1980-05-19', 'Lleida', 25002, 'Espanyola', 'Lleida', 645678901, 973678901, 'marta.puig@institut.cat', 'img/profs/prof04.jpg', 'professor'),
('55555555E', 'Jan', 'Navarro Puig', '2006-03-09', 'Lleida', 25003, 'Espanyola', 'Lleida', 655555555, 973555555, 'jan.navarro@alumne.cat', 'img/alumns/alum05.jpg', 'alumne'),
('56789012E', 'Pere', 'Anton López', '1979-09-08', 'Lleida', 25003, 'Espanyola', 'Lleida', 656789012, 973789012, 'pere.anton@institut.cat', 'img/profs/prof05.jpg', 'professor'),
('66666666F', 'Clara', 'Ortiz Vila', '2005-12-27', 'Lleida', 25003, 'Espanyola', 'Lleida', 666666666, 973666666, 'clara.ortiz@alumne.cat', 'img/alumns/alum06.jpg', 'alumne'),
('67890123F', 'Laura', 'Sánchez Mora', '1983-01-15', 'Lleida', 25003, 'Espanyola', 'Lleida', 667890123, 973890123, 'laura.sanchez@institut.cat', 'img/profs/prof06.jpg', 'professor'),
('77777777G', 'Eric', 'Soler Llorens', '2005-04-11', 'Lleida', 25004, 'Espanyola', 'Lleida', 677777777, 973777777, 'eric.soler@alumne.cat', 'img/alumns/alum07.jpg', 'alumne'),
('78901234G', 'Carles', 'Domènech Roca', '1977-06-30', 'Lleida', 25004, 'Espanyola', 'Lleida', 678901234, 973901234, 'carles.domenech@institut.cat', 'img/profs/prof07.jpg', 'professor'),
('88888888H', 'Iris', 'Reig Amat', '2006-10-21', 'Lleida', 25004, 'Espanyola', 'Lleida', 688888888, 973888888, 'iris.reig@alumne.cat', 'img/alumns/alum08.jpg', 'alumne'),
('89012345H', 'Núria', 'Pérez Vidal', '1985-04-22', 'Lleida', 25004, 'Espanyola', 'Lleida', 689012345, 973012345, 'nuria.perez@institut.cat', 'img/profs/prof08.jpg', 'professor'),
('90123456I', 'Xavier', 'Font Mir', '1976-08-11', 'Lleida', 25005, 'Espanyola', 'Lleida', 690123456, 973123456, 'xavier.font@institut.cat', 'img/profs/prof09.jpg', 'professor'),
('99999999I', 'Biel', 'Pascual Serra', '2005-08-02', 'Lleida', 25005, 'Espanyola', 'Lleida', 699999999, 973999999, 'biel.pascual@alumne.cat', 'img/alumns/alum09.jpg', 'alumne');

--
-- Disparadores `persones`
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
-- Estructura de tabla para la tabla `professors`
--

CREATE TABLE `professors` (
  `codi_prof` varchar(20) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `dedicacio` enum('professor','tutor de grup','tutor FCT','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `professors`
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
-- Estructura de tabla para la tabla `prof_assignatura`
--

CREATE TABLE `prof_assignatura` (
  `id` int(11) NOT NULL,
  `id_codiprof` varchar(20) NOT NULL,
  `id_assignatura` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prof_assignatura`
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
-- Estructura de tabla para la tabla `ras`
--

CREATE TABLE `ras` (
  `id` int(11) NOT NULL,
  `ra` int(11) NOT NULL,
  `codi_assignatura` varchar(25) NOT NULL,
  `data_inici` date NOT NULL,
  `data_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ras`
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
-- Disparadores `ras`
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
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id_session` int(11) NOT NULL,
  `dni_user` varchar(20) NOT NULL,
  `token` char(64) NOT NULL,
  `data_inici` datetime NOT NULL,
  `data_fin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sessions`
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
(70, '11111111A', '22e508131c896329defa6729eeab3cbc372797a5b415e63fbe1e4a260e8c3b53', '2026-05-04 12:10:22', '2026-05-04 22:10:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuaris`
--

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
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acta_avaluacio`
--
ALTER TABLE `acta_avaluacio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_acta_assignatura` (`id_assignatura`),
  ADD KEY `fk_acta_grup` (`nom_grup`);

--
-- Indices de la tabla `acta_notes`
--
ALTER TABLE `acta_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_notes_acta` (`id_acta`),
  ADD KEY `fk_notes_estudiant` (`nia`);

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
-- Indices de la tabla `cursos_cicle`
--
ALTER TABLE `cursos_cicle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nom_cicle` (`nom_cicle`);

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
-- Indices de la tabla `historic_actes`
--
ALTER TABLE `historic_actes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_hist_acta` (`id_acta`),
  ADD KEY `fk_hist_professor` (`dni_professor`);

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
  ADD KEY `fk_logs_consultes_dni` (`dni_user`);

--
-- Indices de la tabla `logs_login`
--
ALTER TABLE `logs_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logs_login_dni` (`dni_user`);

--
-- Indices de la tabla `periodes_avaluacio`
--
ALTER TABLE `periodes_avaluacio`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_trimestre_curs` (`trimestre`,`curs`),
  ADD KEY `fk_periode_persona` (`obert_per`);

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
  ADD PRIMARY KEY (`id_session`);

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
-- AUTO_INCREMENT de la tabla `acta_avaluacio`
--
ALTER TABLE `acta_avaluacio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `acta_notes`
--
ALTER TABLE `acta_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `administradors`
--
ALTER TABLE `administradors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `admin_centre`
--
ALTER TABLE `admin_centre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `assistencia`
--
ALTER TABLE `assistencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `contractes`
--
ALTER TABLE `contractes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `cursos_cicle`
--
ALTER TABLE `cursos_cicle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=214;

--
-- AUTO_INCREMENT de la tabla `historic_actes`
--
ALTER TABLE `historic_actes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT de la tabla `historic_fct`
--
ALTER TABLE `historic_fct`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `historic_professors`
--
ALTER TABLE `historic_professors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `logs_consultes`
--
ALTER TABLE `logs_consultes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT de la tabla `logs_login`
--
ALTER TABLE `logs_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `periodes_avaluacio`
--
ALTER TABLE `periodes_avaluacio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `ras`
--
ALTER TABLE `ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id_session` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `usuaris`
--
ALTER TABLE `usuaris`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `acta_avaluacio`
--
ALTER TABLE `acta_avaluacio`
  ADD CONSTRAINT `fk_acta_assignatura` FOREIGN KEY (`id_assignatura`) REFERENCES `assignatures` (`codi`),
  ADD CONSTRAINT `fk_acta_grup` FOREIGN KEY (`nom_grup`) REFERENCES `grup_classe` (`nom`);

--
-- Filtros para la tabla `acta_notes`
--
ALTER TABLE `acta_notes`
  ADD CONSTRAINT `fk_notes_acta` FOREIGN KEY (`id_acta`) REFERENCES `acta_avaluacio` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_notes_estudiant` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`);

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
-- Filtros para la tabla `cursos_cicle`
--
ALTER TABLE `cursos_cicle`
  ADD CONSTRAINT `cursos_cicle_ibfk_1` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`) ON UPDATE CASCADE;

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
-- Filtros para la tabla `historic_actes`
--
ALTER TABLE `historic_actes`
  ADD CONSTRAINT `fk_hist_acta` FOREIGN KEY (`id_acta`) REFERENCES `acta_avaluacio` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_hist_professor` FOREIGN KEY (`dni_professor`) REFERENCES `persones` (`dni`);

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
  ADD CONSTRAINT `fk_logs_consultes_dni` FOREIGN KEY (`dni_user`) REFERENCES `usuaris` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `logs_login`
--
ALTER TABLE `logs_login`
  ADD CONSTRAINT `fk_logs_login_dni` FOREIGN KEY (`dni_user`) REFERENCES `usuaris` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `periodes_avaluacio`
--
ALTER TABLE `periodes_avaluacio`
  ADD CONSTRAINT `fk_periode_persona` FOREIGN KEY (`obert_per`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE;

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
-- Filtros para la tabla `usuaris`
--
ALTER TABLE `usuaris`
  ADD CONSTRAINT `fk_usuaridni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
