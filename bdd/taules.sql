-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Temps de generació: 23-10-2025 a les 17:29:02
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
-- Base de dades: `plataforma_evalis`
--


-- --------------------------------------------------------


--
-- Estructura de la taula `administradors`
--


CREATE TABLE `administradors` (
  `nom` varchar(100) NOT NULL,
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
  `nom_admin` varchar(50) NOT NULL,
  `codi_centre` int(11) NOT NULL,
  `backup` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `assignatures`
--


CREATE TABLE `assignatures` (
  `codi` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `assignatures_cicle`
--


CREATE TABLE `assignatures_cicle` (
  `nom_cicle` varchar(50) NOT NULL,
  `codi_assignatura` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `assistencia`
--


CREATE TABLE `assistencia` (
  `id` int(11) NOT NULL,
  `codi_id` int(11) NOT NULL,
  `nom_grup` varchar(50) NOT NULL,
  `codi_assignatura` varchar(50) NOT NULL,
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
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `contractes`
--


CREATE TABLE `contractes` (
  `id` int(11) NOT NULL,
  `codi_id` int(11) NOT NULL,
  `codi_centre` int(11) NOT NULL,
  `data_alta` date NOT NULL,
  `data_baix` date NOT NULL,
  `vinculacio_laboral` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `directiva`
--


CREATE TABLE `directiva` (
  `rol` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `estudiants`
--


CREATE TABLE `estudiants` (
  `nia` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `nom_grup` varchar(25) NOT NULL,
  `nom_cicle` varchar(50) NOT NULL,
  `cursant` tinyint(1) NOT NULL,
  `repetidor` tinyint(1) NOT NULL,
  `treballant` tinyint(1) NOT NULL,
  `empresa` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `estudiants_ras`
--


CREATE TABLE `estudiants_ras` (
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
  `aula` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `historic_estudiants`
--


CREATE TABLE `historic_estudiants` (
  `id` int(11) NOT NULL,
  `nia` int(20) NOT NULL,
  `nom_cicle` int(50) NOT NULL,
  `finalitzat` tinyint(1) NOT NULL,
  `nota_final` decimal(10,0) NOT NULL,
  `data_inici` date NOT NULL,
  `date_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `historic_fct`
--


CREATE TABLE `historic_fct` (
  `id` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `empreses` varchar(100) NOT NULL,
  `hores` int(11) NOT NULL,
  `finalitzat` tinyint(1) NOT NULL,
  `observacions` varchar(500) NOT NULL,
  `incidencies` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `historic_professors`
--


CREATE TABLE `historic_professors` (
  `id` int(11) NOT NULL,
  `codi_id` int(11) NOT NULL,
  `tipus` varchar(256) NOT NULL,
  `motius` varchar(256) NOT NULL,
  `justificat` tinyint(1) NOT NULL,
  `justificant` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `logs`
--


CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `intents` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `login` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `logs_consultes`
--


CREATE TABLE `logs_consultes` (
  `id` int(11) NOT NULL,
  `token` int(11) NOT NULL,
  `consulta` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `persones`
--


CREATE TABLE `persones` (
  `dni` varchar(9) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `cognom` varchar(50) NOT NULL,
  `data_naix` date NOT NULL,
  `poblacio` varchar(256) NOT NULL,
  `codi_postal` int(6) NOT NULL,
  `nacionalitat` varchar(100) NOT NULL,
  `municipi_naix` varchar(100) NOT NULL,
  `telf_mob` int(10) NOT NULL,
  `telf_fix` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `ruta_foto` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `professors`
--


CREATE TABLE `professors` (
  `codi_id` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `dedicacio` enum('professor','tutor de grup','tutor de FCT','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `ras`
--


CREATE TABLE `ras` (
  `id` int(11) NOT NULL,
  `codi_assignatura` varchar(50) NOT NULL,
  `data_inici` date NOT NULL,
  `data_fin` date NOT NULL,
  `nota` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------


--
-- Estructura de la taula `sessions`
--


CREATE TABLE `sessions` (
  `id_user` int(11) NOT NULL,
  `username` int(11) NOT NULL,
  `token` int(11) NOT NULL,
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
  `username` varchar(25) NOT NULL,
  `password` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Índexs per a les taules bolcades
--


--
-- Índexs per a la taula `administradors`
--
ALTER TABLE `administradors`
  ADD PRIMARY KEY (`nom`),
  ADD KEY `fk_adminuser` (`id_user`),
  ADD KEY `fk_admindni` (`dni`);


--
-- Índexs per a la taula `admin_centre`
--
ALTER TABLE `admin_centre`
  ADD KEY `fk_admin` (`nom_admin`),
  ADD KEY `fk_adminc` (`codi_centre`);


--
-- Índexs per a la taula `assignatures`
--
ALTER TABLE `assignatures`
  ADD PRIMARY KEY (`codi`);


--
-- Índexs per a la taula `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  ADD KEY `fk_asscc` (`nom_cicle`),
  ADD KEY `fk_assas` (`codi_assignatura`);


--
-- Índexs per a la taula `assistencia`
--
ALTER TABLE `assistencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assprof` (`codi_id`),
  ADD KEY `fk_assgrup` (`nom_grup`),
  ADD KEY `fk_assa` (`codi_assignatura`);


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
  ADD KEY `fk_contractesp` (`codi_id`),
  ADD KEY `fk_contractesc` (`codi_centre`);


--
-- Índexs per a la taula `directiva`
--
ALTER TABLE `directiva`
  ADD PRIMARY KEY (`rol`);


--
-- Índexs per a la taula `estudiants`
--
ALTER TABLE `estudiants`
  ADD PRIMARY KEY (`nia`),
  ADD KEY `fk_estudiants1` (`nom_grup`),
  ADD KEY `fk_estudiants2` (`nom_cicle`),
  ADD KEY `fk_estudiantsdni` (`dni`);


--
-- Índexs per a la taula `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  ADD KEY `fk_esrae` (`id_ra`),
  ADD KEY `fk_esrar` (`nia`);


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
  ADD KEY `fk_hestudiants` (`nia`);


--
-- Índexs per a la taula `historic_fct`
--
ALTER TABLE `historic_fct`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_hfct` (`nia`);


--
-- Índexs per a la taula `historic_professors`
--
ALTER TABLE `historic_professors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_hprof` (`codi_id`);


--
-- Índexs per a la taula `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logs` (`id_user`);


--
-- Índexs per a la taula `logs_consultes`
--
ALTER TABLE `logs_consultes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logsc` (`token`);


--
-- Índexs per a la taula `persones`
--
ALTER TABLE `persones`
  ADD PRIMARY KEY (`dni`);


--
-- Índexs per a la taula `professors`
--
ALTER TABLE `professors`
  ADD PRIMARY KEY (`codi_id`),
  ADD KEY `fk_profdni` (`dni`);


--
-- Índexs per a la taula `ras`
--
ALTER TABLE `ras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ass` (`codi_assignatura`);


--
-- Índexs per a la taula `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`token`),
  ADD KEY `fk_sessions` (`id_user`);


--
-- Índexs per a la taula `usuaris`
--
ALTER TABLE `usuaris`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `fk_usuaris` (`dni`);


--
-- AUTO_INCREMENT per les taules bolcades
--


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
-- AUTO_INCREMENT per la taula `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


--
-- AUTO_INCREMENT per la taula `logs_consultes`
--
ALTER TABLE `logs_consultes`
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
  ADD CONSTRAINT `fk_admindni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`),
  ADD CONSTRAINT `fk_adminuser` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`);


--
-- Restriccions per a la taula `admin_centre`
--
ALTER TABLE `admin_centre`
  ADD CONSTRAINT `fk_admin` FOREIGN KEY (`nom_admin`) REFERENCES `administradors` (`nom`),
  ADD CONSTRAINT `fk_adminc` FOREIGN KEY (`codi_centre`) REFERENCES `centres` (`codi`);


--
-- Restriccions per a la taula `assignatures_cicle`
--
ALTER TABLE `assignatures_cicle`
  ADD CONSTRAINT `fk_assas` FOREIGN KEY (`codi_assignatura`) REFERENCES `assignatures` (`codi`),
  ADD CONSTRAINT `fk_asscc` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`);


--
-- Restriccions per a la taula `assistencia`
--
ALTER TABLE `assistencia`
  ADD CONSTRAINT `fk_assa` FOREIGN KEY (`codi_assignatura`) REFERENCES `assignatures` (`codi`),
  ADD CONSTRAINT `fk_assgrup` FOREIGN KEY (`nom_grup`) REFERENCES `grup_classe` (`nom`),
  ADD CONSTRAINT `fk_assprof` FOREIGN KEY (`codi_id`) REFERENCES `professors` (`codi_id`);


--
-- Restriccions per a la taula `contractes`
--
ALTER TABLE `contractes`
  ADD CONSTRAINT `fk_contractesc` FOREIGN KEY (`codi_centre`) REFERENCES `centres` (`codi`),
  ADD CONSTRAINT `fk_contractesp` FOREIGN KEY (`codi_id`) REFERENCES `professors` (`codi_id`);


--
-- Restriccions per a la taula `estudiants`
--
ALTER TABLE `estudiants`
  ADD CONSTRAINT `fk_estudiants1` FOREIGN KEY (`nom_grup`) REFERENCES `grup_classe` (`nom`),
  ADD CONSTRAINT `fk_estudiants2` FOREIGN KEY (`nom_cicle`) REFERENCES `cicles` (`nom`),
  ADD CONSTRAINT `fk_estudiantsdni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`);


--
-- Restriccions per a la taula `estudiants_ras`
--
ALTER TABLE `estudiants_ras`
  ADD CONSTRAINT `fk_esrae` FOREIGN KEY (`id_ra`) REFERENCES `ras` (`id`),
  ADD CONSTRAINT `fk_esrar` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`);


--
-- Restriccions per a la taula `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  ADD CONSTRAINT `fk_hestudiants` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`);


--
-- Restriccions per a la taula `historic_fct`
--
ALTER TABLE `historic_fct`
  ADD CONSTRAINT `fk_hfct` FOREIGN KEY (`nia`) REFERENCES `estudiants` (`nia`);


--
-- Restriccions per a la taula `historic_professors`
--
ALTER TABLE `historic_professors`
  ADD CONSTRAINT `fk_hprof` FOREIGN KEY (`codi_id`) REFERENCES `professors` (`codi_id`);


--
-- Restriccions per a la taula `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `fk_logs` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`);


--
-- Restriccions per a la taula `logs_consultes`
--
ALTER TABLE `logs_consultes`
  ADD CONSTRAINT `fk_logsc` FOREIGN KEY (`token`) REFERENCES `sessions` (`token`);


--
-- Restriccions per a la taula `professors`
--
ALTER TABLE `professors`
  ADD CONSTRAINT `fk_profdni` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`);


--
-- Restriccions per a la taula `ras`
--
ALTER TABLE `ras`
  ADD CONSTRAINT `fk_ass` FOREIGN KEY (`codi_assignatura`) REFERENCES `assignatures` (`codi`);


--
-- Restriccions per a la taula `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `fk_sessions` FOREIGN KEY (`id_user`) REFERENCES `usuaris` (`id_user`);


--
-- Restriccions per a la taula `usuaris`
--
ALTER TABLE `usuaris`
  ADD CONSTRAINT `fk_usuaris` FOREIGN KEY (`dni`) REFERENCES `persones` (`dni`);
COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;







