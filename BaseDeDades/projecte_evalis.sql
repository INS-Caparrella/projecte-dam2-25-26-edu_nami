-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 06-05-2026 a las 16:12:56
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
-- Base de datos: `phpmyadmin`
--
DROP DATABASE IF EXISTS `phpmyadmin`;
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

DROP TABLE IF EXISTS `pma__bookmark`;
CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

DROP TABLE IF EXISTS `pma__central_columns`;
CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

DROP TABLE IF EXISTS `pma__column_info`;
CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

DROP TABLE IF EXISTS `pma__designer_settings`;
CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Volcado de datos para la tabla `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"relation_lines\":\"true\",\"snap_to_grid\":\"off\",\"angular_direct\":\"direct\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

DROP TABLE IF EXISTS `pma__export_templates`;
CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

DROP TABLE IF EXISTS `pma__favorite`;
CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

DROP TABLE IF EXISTS `pma__history`;
CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

DROP TABLE IF EXISTS `pma__navigationhiding`;
CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

DROP TABLE IF EXISTS `pma__pdf_pages`;
CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

DROP TABLE IF EXISTS `pma__recent`;
CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"projecte_evalis\",\"table\":\"persones\"},{\"db\":\"projecte_evalis\",\"table\":\"ras\"},{\"db\":\"projecte_evalis\",\"table\":\"estudiants_ras\"},{\"db\":\"projecte_evalis\",\"table\":\"sessions\"},{\"db\":\"projecte_evalis\",\"table\":\"acta_avaluacio\"},{\"db\":\"projecte_evalis\",\"table\":\"acta_notes\"},{\"db\":\"projecte_evalis\",\"table\":\"logs_login\"},{\"db\":\"projecte_evalis\",\"table\":\"cursos_cicle\"},{\"db\":\"projecte_evalis\",\"table\":\"usuaris\"},{\"db\":\"projecte_evalis\",\"table\":\"historic_estudiants\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

DROP TABLE IF EXISTS `pma__relation`;
CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

DROP TABLE IF EXISTS `pma__savedsearches`;
CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

DROP TABLE IF EXISTS `pma__table_coords`;
CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

DROP TABLE IF EXISTS `pma__table_info`;
CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

DROP TABLE IF EXISTS `pma__table_uiprefs`;
CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'projecte_evalis', 'estudiants_ras', '{\"sorted_col\":\"`estudiants_ras`.`id_ra` ASC\"}', '2026-05-06 10:54:36'),
('root', 'projecte_evalis', 'ras', '{\"sorted_col\":\"`ras`.`codi_assignatura` ASC\"}', '2026-05-06 10:55:13'),
('root', 'projecte_evalis', 'sessions', '{\"sorted_col\":\"`sessions`.`data_inici` DESC\"}', '2026-05-06 08:43:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

DROP TABLE IF EXISTS `pma__tracking`;
CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

DROP TABLE IF EXISTS `pma__userconfig`;
CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-05-06 14:10:36', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\",\"NavigationWidth\":0}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

DROP TABLE IF EXISTS `pma__usergroups`;
CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

DROP TABLE IF EXISTS `pma__users`;
CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `projecte_evalis`
--
DROP DATABASE IF EXISTS `projecte_evalis`;
CREATE DATABASE IF NOT EXISTS `projecte_evalis` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `projecte_evalis`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acta_avaluacio`
--

DROP TABLE IF EXISTS `acta_avaluacio`;
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
-- Volcado de datos para la tabla `acta_avaluacio`
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
(10, 'MP04', 'DAW2A', 1, '2026-2027', '11223344K', '2026-05-06 00:22:59', '2026-05-06 00:22:59', 0),
(11, 'MP07', 'DAM2A', 2, '2026-2027', '11223344K', '2026-05-06 01:41:26', '2026-05-06 01:41:26', 0),
(12, 'MP04', 'DAW2A', 2, '2026-2027', '11223344K', '2026-05-06 01:44:32', '2026-05-06 01:44:32', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acta_notes`
--

DROP TABLE IF EXISTS `acta_notes`;
CREATE TABLE `acta_notes` (
  `id` int(11) NOT NULL,
  `id_acta` int(11) NOT NULL,
  `nia` int(11) NOT NULL,
  `nota_final` decimal(10,0) NOT NULL,
  `repetidor` tinyint(1) NOT NULL,
  `treballant` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `acta_notes`
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

DROP TABLE IF EXISTS `assignatures`;
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

DROP TABLE IF EXISTS `cicles`;
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

DROP TABLE IF EXISTS `cursos_cicle`;
CREATE TABLE `cursos_cicle` (
  `id` int(11) NOT NULL,
  `nom_cicle` varchar(256) NOT NULL,
  `curs` enum('1r','2n') NOT NULL,
  `hores_total` int(11) NOT NULL,
  `any_inici_referencia` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos_cicle`
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

DROP TABLE IF EXISTS `estudiants`;
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
(1001, '11111111A', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 0, '', 1, '2025-09-01'),
(1002, '22222222B', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 0, '', 1, '2025-09-01'),
(1003, '33333333C', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 0, '', 1, '2025-09-01'),
(1004, '44444444D', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 1, 'WebCorp Lleida', 1, '2025-09-01'),
(1005, '55555555E', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 0, '', 1, '2025-09-01'),
(1006, '66666666F', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 1, 'NetSystems SL', 1, '2025-09-01'),
(1007, '77777777G', 'SMX2A', '2n', 'CFGM Sistemes Microinformatics i Xarxes', 1, 0, 0, '', 1, '2025-09-01'),
(1008, '88888888H', 'GA2A', '2n', 'CFGM Gestio Administrativa', 1, 0, 0, '', 1, '2025-09-01'),
(1009, '99999999I', 'FPB2A', '2n', 'FP Basica Informatica', 1, 0, 0, '', 1, '2025-09-01'),
(1010, '10101010J', 'CI2A', '2n', 'CFGS Comerce Internacional', 1, 0, 0, '', 1, '2025-09-01'),
(1011, '12121212L', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 1, 0, '', 1, '2025-09-01'),
(1012, '13131313M', 'DAW1A', '1r', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 0, '', 1, '2025-09-01'),
(1013, '14141414N', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 1, 'TechLleida SA', 1, '2025-09-01'),
(1014, '15151515P', 'GA2A', '2n', 'CFGM Gestio Administrativa', 1, 0, 0, '', 1, '2025-09-01'),
(1015, '16161616Q', 'SMX1A', '1r', 'CFGM Sistemes Microinformatics i Xarxes', 1, 0, 0, '', 1, '2025-09-01'),
(1016, '17171717R', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 0, '', 1, '2025-09-01'),
(1017, '18181818S', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 0, '', 1, '2025-09-01'),
(1018, '19191919T', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 0, '', 1, '2025-09-01'),
(1019, '20202020U', 'GA2A', '2n', 'CFGM Gestio Administrativa', 1, 0, 0, '', 1, '2025-09-01'),
(1020, '21212121V', 'SMX2A', '2n', 'CFGM Sistemes Microinformatics i Xarxes', 1, 0, 1, 'InfoLleida SL', 1, '2025-09-01'),
(1021, '22222223W', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 1, 'AppDev SL', 1, '2025-09-01'),
(1022, '23232323X', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 0, 0, '', 1, '2025-09-01'),
(1023, '24242424Y', 'ASIX2A', '2n', 'CFGS Administracio de Sistemes Informatics en Xarxa', 1, 0, 1, 'SysAdmin SL', 1, '2025-09-01'),
(1024, '25252525Z', 'CI2A', '2n', 'CFGS Comerce Internacional', 1, 0, 0, '', 1, '2025-09-01'),
(1025, '26262626A', 'FPB2A', '2n', 'FP Basica Informatica', 1, 0, 0, '', 1, '2025-09-01'),
(1026, '27272727B', 'GA2A', '2n', 'CFGM Gestio Administrativa', 1, 0, 0, '', 1, '2025-09-01'),
(1027, '28282828C', 'SMX2A', '2n', 'CFGM Sistemes Microinformatics i Xarxes', 1, 0, 0, '', 1, '2025-09-01'),
(1028, '29292929D', 'DAM2A', '2n', 'CFGS Desenvolupament Aplicacions Multiplataforma', 1, 0, 0, '', 1, '2025-09-01'),
(1029, '30303030E', 'DAW2A', '2n', 'CFGS Desenvolupament Aplicacions Web', 1, 1, 0, '', 1, '2025-09-01'),
(1030, '31313131F', 'CI2A', '2n', 'CFGS Comerce Internacional', 1, 0, 1, 'ComercGlobal', 1, '2025-09-01');

--
-- Disparadores `estudiants`
--
DROP TRIGGER IF EXISTS `estudiantHistoric`;
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

DROP TABLE IF EXISTS `estudiants_ras`;
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
(1, 15, 1001, 6, '2024-09-01'),
(2, 16, 1001, 7, '2025-01-08'),
(3, 17, 1001, 8, '2025-04-01'),
(4, 18, 1001, 7, '2024-09-01'),
(5, 19, 1001, 6, '2025-01-08'),
(6, 20, 1001, 8, '2024-09-01'),
(7, 21, 1001, 7, '2025-01-08'),
(8, 15, 1002, 7, '2024-09-01'),
(9, 16, 1002, 8, '2025-01-08'),
(10, 17, 1002, 9, '2025-04-01'),
(11, 18, 1002, 8, '2024-09-01'),
(12, 19, 1002, 7, '2025-01-08'),
(13, 20, 1002, 9, '2024-09-01'),
(14, 21, 1002, 8, '2025-01-08'),
(15, 15, 1011, 5, '2024-09-01'),
(16, 16, 1011, 5, '2025-01-08'),
(17, 17, 1011, 6, '2025-04-01'),
(18, 18, 1011, 5, '2024-09-01'),
(19, 19, 1011, 5, '2025-01-08'),
(20, 20, 1011, 6, '2024-09-01'),
(21, 21, 1011, 5, '2025-01-08'),
(22, 15, 1016, 6, '2024-09-01'),
(23, 16, 1016, 7, '2025-01-08'),
(24, 17, 1016, 8, '2025-04-01'),
(25, 18, 1016, 7, '2024-09-01'),
(26, 19, 1016, 6, '2025-01-08'),
(27, 20, 1016, 8, '2024-09-01'),
(28, 21, 1016, 7, '2025-01-08'),
(29, 15, 1021, 6, '2024-09-01'),
(30, 16, 1021, 7, '2025-01-08'),
(31, 17, 1021, 8, '2025-04-01'),
(32, 18, 1021, 7, '2024-09-01'),
(33, 19, 1021, 6, '2025-01-08'),
(34, 20, 1021, 8, '2024-09-01'),
(35, 21, 1021, 7, '2025-01-08'),
(36, 15, 1028, 5, '2024-09-01'),
(37, 16, 1028, 6, '2025-01-08'),
(38, 17, 1028, 7, '2025-04-01'),
(39, 18, 1028, 6, '2024-09-01'),
(40, 19, 1028, 5, '2025-01-08'),
(41, 20, 1028, 7, '2024-09-01'),
(42, 21, 1028, 6, '2025-01-08'),
(43, 28, 1003, 7, '2024-09-01'),
(44, 29, 1003, 8, '2025-01-08'),
(45, 15, 1003, 9, '2024-09-01'),
(46, 16, 1003, 8, '2025-01-08'),
(47, 17, 1003, 7, '2025-04-01'),
(48, 18, 1003, 9, '2024-09-01'),
(49, 19, 1003, 8, '2025-01-08'),
(50, 28, 1017, 7, '2024-09-01'),
(51, 29, 1017, 8, '2025-01-08'),
(52, 15, 1017, 9, '2024-09-01'),
(53, 16, 1017, 8, '2025-01-08'),
(54, 17, 1017, 7, '2025-04-01'),
(55, 18, 1017, 9, '2024-09-01'),
(56, 19, 1017, 8, '2025-01-08'),
(57, 28, 1004, 6, '2023-09-01'),
(58, 29, 1004, 7, '2024-01-08'),
(59, 15, 1004, 8, '2023-09-01'),
(60, 16, 1004, 7, '2024-01-08'),
(61, 17, 1004, 6, '2024-04-01'),
(62, 18, 1004, 8, '2023-09-01'),
(63, 19, 1004, 7, '2024-01-08'),
(64, 28, 1022, 6, '2023-09-01'),
(65, 29, 1022, 7, '2024-01-08'),
(66, 15, 1022, 8, '2023-09-01'),
(67, 16, 1022, 7, '2024-01-08'),
(68, 17, 1022, 6, '2024-04-01'),
(69, 18, 1022, 8, '2023-09-01'),
(70, 19, 1022, 7, '2024-01-08'),
(71, 28, 1029, 6, '2023-09-01'),
(72, 29, 1029, 6, '2024-01-08'),
(73, 15, 1029, 8, '2023-09-01'),
(74, 16, 1029, 6, '2024-01-08'),
(75, 17, 1029, 6, '2024-04-01'),
(76, 18, 1029, 8, '2023-09-01'),
(77, 19, 1029, 6, '2024-01-08'),
(78, 22, 1005, 6, '2024-09-01'),
(79, 23, 1005, 7, '2025-01-08'),
(80, 24, 1005, 8, '2024-09-01'),
(81, 25, 1005, 7, '2025-01-08'),
(82, 22, 1006, 6, '2023-09-01'),
(83, 23, 1006, 7, '2024-01-08'),
(84, 24, 1006, 8, '2023-09-01'),
(85, 25, 1006, 7, '2024-01-08'),
(86, 22, 1013, 7, '2023-09-01'),
(87, 23, 1013, 8, '2024-01-08'),
(88, 24, 1013, 9, '2023-09-01'),
(89, 25, 1013, 8, '2024-01-08'),
(90, 22, 1023, 7, '2023-09-01'),
(91, 23, 1023, 8, '2024-01-08'),
(92, 24, 1023, 9, '2023-09-01'),
(93, 25, 1023, 8, '2024-01-08'),
(94, 30, 1007, 6, '2024-09-01'),
(95, 31, 1007, 7, '2025-01-08'),
(96, 22, 1007, 8, '2024-09-01'),
(97, 23, 1007, 7, '2025-01-08'),
(98, 24, 1007, 6, '2024-09-01'),
(99, 25, 1007, 8, '2025-01-08'),
(100, 30, 1027, 5, '2024-09-01'),
(101, 31, 1027, 6, '2025-01-08'),
(102, 22, 1027, 7, '2024-09-01'),
(103, 23, 1027, 6, '2025-01-08'),
(104, 24, 1027, 5, '2024-09-01'),
(105, 25, 1027, 7, '2025-01-08'),
(106, 30, 1001, 6, '2023-09-01'),
(107, 31, 1001, 7, '2024-01-08'),
(108, 22, 1001, 8, '2023-09-01'),
(109, 23, 1001, 7, '2024-01-08'),
(110, 24, 1001, 6, '2023-09-01'),
(111, 25, 1001, 8, '2024-01-08'),
(112, 30, 1003, 6, '2023-09-01'),
(113, 31, 1003, 7, '2024-01-08'),
(114, 22, 1003, 8, '2023-09-01'),
(115, 23, 1003, 7, '2024-01-08'),
(116, 24, 1003, 6, '2023-09-01'),
(117, 25, 1003, 8, '2024-01-08'),
(118, 30, 1005, 6, '2023-09-01'),
(119, 31, 1005, 7, '2024-01-08'),
(120, 22, 1005, 8, '2023-09-01'),
(121, 23, 1005, 7, '2024-01-08'),
(122, 24, 1005, 6, '2023-09-01'),
(123, 25, 1005, 8, '2024-01-08'),
(124, 30, 1001, 6, '2022-09-01'),
(125, 31, 1001, 7, '2023-01-08'),
(126, 22, 1001, 8, '2022-09-01'),
(127, 23, 1001, 7, '2023-01-08'),
(128, 24, 1001, 6, '2022-09-01'),
(129, 25, 1001, 8, '2023-01-08'),
(130, 26, 1019, 6, '2024-09-01'),
(131, 27, 1019, 7, '2025-01-08'),
(132, 26, 1026, 6, '2024-09-01'),
(133, 27, 1026, 7, '2025-01-08'),
(134, 26, 1014, 5, '2023-09-01'),
(135, 27, 1014, 6, '2024-01-08'),
(136, 26, 1026, 3, '2023-09-01'),
(137, 27, 1026, 4, '2024-01-08'),
(138, 32, 1024, 6, '2024-09-01'),
(139, 33, 1024, 7, '2025-01-08'),
(140, 32, 1030, 6, '2023-09-01'),
(141, 33, 1030, 7, '2024-01-08'),
(142, 30, 1009, 5, '2024-09-01'),
(143, 31, 1009, 6, '2025-01-08'),
(144, 30, 1025, 5, '2024-09-01'),
(145, 31, 1025, 6, '2025-01-08'),
(146, 30, 1007, 6, '2022-09-01'),
(147, 31, 1007, 7, '2023-01-08'),
(148, 30, 1015, 5, '2023-09-01'),
(149, 31, 1015, 6, '2024-01-08'),
(150, 30, 1020, 6, '2022-09-01'),
(151, 31, 1020, 8, '2023-01-08'),
(152, 30, 1020, 7, '2023-09-01'),
(153, 31, 1020, 8, '2024-01-08'),
(154, 28, 1014, 3, '2022-09-01'),
(155, 29, 1014, 4, '2023-01-08'),
(156, 15, 1014, 3, '2022-09-01'),
(157, 16, 1014, 4, '2023-01-08'),
(158, 18, 1014, 3, '2022-09-01'),
(159, 19, 1014, 4, '2023-01-08'),
(160, 41, 1001, 7, '2024-09-01'),
(161, 42, 1001, 8, '2025-01-08'),
(162, 41, 1002, 8, '2024-09-01'),
(163, 42, 1002, 8, '2025-01-08'),
(164, 41, 1011, 5, '2024-09-01'),
(165, 42, 1011, 5, '2025-01-08'),
(166, 41, 1016, 7, '2024-09-01'),
(167, 42, 1016, 7, '2025-01-08'),
(168, 41, 1021, 7, '2024-09-01'),
(169, 42, 1021, 7, '2025-01-08'),
(170, 41, 1028, 6, '2024-09-01'),
(171, 42, 1028, 6, '2025-01-08'),
(172, 43, 1005, 7, '2024-09-01'),
(173, 44, 1005, 7, '2025-01-08'),
(174, 43, 1006, 7, '2023-09-01'),
(175, 44, 1006, 7, '2024-01-08'),
(176, 43, 1013, 8, '2023-09-01'),
(177, 44, 1013, 8, '2024-01-08'),
(178, 43, 1023, 8, '2023-09-01'),
(179, 44, 1023, 9, '2024-01-08'),
(180, 45, 1019, 7, '2024-09-01'),
(181, 46, 1019, 7, '2025-01-08'),
(182, 47, 1019, 7, '2024-09-01'),
(183, 48, 1019, 7, '2025-01-08'),
(184, 45, 1026, 6, '2024-09-01'),
(185, 46, 1026, 7, '2025-01-08'),
(186, 47, 1026, 6, '2024-09-01'),
(187, 48, 1026, 7, '2025-01-08'),
(188, 45, 1014, 6, '2023-09-01'),
(189, 46, 1014, 6, '2024-01-08'),
(190, 47, 1014, 6, '2023-09-01'),
(191, 48, 1014, 6, '2024-01-08'),
(192, 45, 1026, 3, '2023-09-01'),
(193, 46, 1026, 4, '2024-01-08'),
(194, 47, 1026, 3, '2023-09-01'),
(195, 48, 1026, 4, '2024-01-08'),
(196, 49, 1024, 7, '2024-09-01'),
(197, 50, 1024, 7, '2025-01-08'),
(198, 49, 1030, 7, '2023-09-01'),
(199, 50, 1030, 8, '2024-01-08'),
(200, 39, 1009, 6, '2024-09-01'),
(201, 40, 1009, 6, '2025-01-08'),
(202, 39, 1025, 6, '2024-09-01'),
(203, 40, 1025, 6, '2025-01-08'),
(204, 39, 1007, 7, '2022-09-01'),
(205, 40, 1007, 7, '2023-01-08'),
(208, 41, 1001, 7, '2024-09-01'),
(209, 42, 1001, 8, '2025-01-08'),
(210, 41, 1002, 8, '2024-09-01'),
(211, 42, 1002, 8, '2025-01-08'),
(212, 41, 1011, 5, '2024-09-01'),
(213, 42, 1011, 5, '2025-01-08'),
(214, 41, 1016, 7, '2024-09-01'),
(215, 42, 1016, 7, '2025-01-08'),
(216, 41, 1021, 7, '2024-09-01'),
(217, 42, 1021, 7, '2025-01-08'),
(218, 41, 1028, 6, '2024-09-01'),
(219, 42, 1028, 6, '2025-01-08'),
(220, 43, 1005, 7, '2024-09-01'),
(221, 44, 1005, 7, '2025-01-08'),
(222, 43, 1006, 7, '2023-09-01'),
(223, 44, 1006, 7, '2024-01-08'),
(224, 43, 1013, 8, '2023-09-01'),
(225, 44, 1013, 8, '2024-01-08'),
(226, 43, 1023, 8, '2023-09-01'),
(227, 44, 1023, 9, '2024-01-08'),
(228, 45, 1019, 7, '2024-09-01'),
(229, 46, 1019, 7, '2025-01-08'),
(230, 47, 1019, 7, '2024-09-01'),
(231, 48, 1019, 7, '2025-01-08'),
(232, 45, 1026, 6, '2024-09-01'),
(233, 46, 1026, 7, '2025-01-08'),
(234, 47, 1026, 6, '2024-09-01'),
(235, 48, 1026, 7, '2025-01-08'),
(236, 45, 1014, 6, '2023-09-01'),
(237, 46, 1014, 6, '2024-01-08'),
(238, 47, 1014, 6, '2023-09-01'),
(239, 48, 1014, 6, '2024-01-08'),
(240, 45, 1026, 3, '2023-09-01'),
(241, 46, 1026, 4, '2024-01-08'),
(242, 47, 1026, 3, '2023-09-01'),
(243, 48, 1026, 4, '2024-01-08'),
(244, 49, 1024, 7, '2024-09-01'),
(245, 50, 1024, 7, '2025-01-08'),
(246, 49, 1030, 7, '2023-09-01'),
(247, 50, 1030, 8, '2024-01-08'),
(248, 39, 1009, 6, '2024-09-01'),
(249, 40, 1009, 6, '2025-01-08'),
(250, 39, 1025, 6, '2024-09-01'),
(251, 40, 1025, 6, '2025-01-08'),
(252, 39, 1007, 7, '2022-09-01'),
(253, 40, 1007, 7, '2023-01-08'),
(254, 39, 1015, 6, '2023-09-01'),
(255, 40, 1015, 6, '2024-01-08'),
(256, 39, 1020, 7, '2022-09-01'),
(257, 40, 1020, 8, '2023-01-08'),
(258, 39, 1020, 7, '2023-09-01'),
(259, 40, 1020, 8, '2024-01-08');

--
-- Disparadores `estudiants_ras`
--
DROP TRIGGER IF EXISTS `promocio_fp_correcta`;
DELIMITER $$
CREATE TRIGGER `promocio_fp_correcta` AFTER INSERT ON `estudiants_ras` FOR EACH ROW BEGIN
    DECLARE total_ras INT;
    DECLARE aprovades INT;
    DECLARE curs_actual ENUM('1r','2n');

    SELECT COUNT(*), e.grado INTO total_ras, curs_actual
    FROM estudiants_ras er
    JOIN estudiants e ON er.nia = e.nia
    WHERE er.nia = NEW.nia GROUP BY e.nia, e.grado;

    SELECT COUNT(*) INTO aprovades FROM estudiants_ras WHERE nia = NEW.nia AND nota >= 5;

    IF total_ras = aprovades AND curs_actual = '1r' THEN
        UPDATE estudiants
        SET nom_grup = REPLACE(nom_grup, '1', '2'), grado = '2n', data_inici = CURDATE()
        WHERE nia = NEW.nia;

        INSERT INTO historic_estudiants (nia, nom_cicle, grado, finalitzat, nota_final, data_inici, data_fi)
        SELECT NEW.nia, e.nom_cicle, '1r', 1, ROUND(AVG(er.nota), 1), MIN(er.data_inici), CURDATE()
        FROM estudiants e JOIN estudiants_ras er ON e.nia = er.nia
        WHERE e.nia = NEW.nia AND e.grado = '1r';
    END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `promocio_fp_insert`;
DELIMITER $$
CREATE TRIGGER `promocio_fp_insert` AFTER INSERT ON `estudiants_ras` FOR EACH ROW BEGIN
    DECLARE total_ras INT;
    DECLARE aprovades INT;

    SELECT COUNT(*) INTO total_ras FROM estudiants_ras WHERE nia = NEW.nia;
    SELECT COUNT(*) INTO aprovades FROM estudiants_ras WHERE nia = NEW.nia AND nota >= 5;

    IF total_ras > 0 AND total_ras = aprovades AND NEW.nia IN (
        SELECT nia FROM estudiants WHERE nom_grup LIKE '%1%'
    ) THEN
        UPDATE estudiants SET nom_grup = REPLACE(nom_grup, '1', '2'), data_inici = CURDATE()
        WHERE nia = NEW.nia;

        INSERT INTO historic_estudiants (nia, nom_cicle, finalitzat, nota_final, data_inici, data_fi)
        SELECT NEW.nia, e.nom_cicle, 1, ROUND(AVG(er.nota), 1), MIN(er.data_inici), CURDATE()
        FROM estudiants e JOIN estudiants_ras er ON e.nia = er.nia
        WHERE e.nia = NEW.nia;
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

DROP TABLE IF EXISTS `historic_actes`;
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
-- Volcado de datos para la tabla `historic_actes`
--

INSERT INTO `historic_actes` (`id`, `id_acta`, `dni_professor`, `camp_mod`, `valor_anterior`, `valor_nou`, `motiu`, `data_mod`) VALUES
(1, 9, '11223344K', 'nota_final', '6.5', '7', 'prova', '2026-05-05 21:48:03'),
(2, 2, '11223344K', 'nota_final', '7', '5', 'prova', '2026-05-05 23:32:48'),
(3, 2, '11223344K', 'nota_final', '5', '4', 'prova', '2026-05-05 23:33:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historic_estudiants`
--

DROP TABLE IF EXISTS `historic_estudiants`;
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
(153, 1001, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1, 7.4, '2024-09-01', '2025-06-20'),
(154, 1002, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1, 8.0, '2024-09-01', '2025-06-20'),
(155, 1011, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1, 5.0, '2024-09-01', '2025-06-20'),
(156, 1016, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1, 7.0, '2024-09-01', '2025-06-20'),
(157, 1021, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1, 7.0, '2024-09-01', '2025-06-20'),
(158, 1028, 'CFGS Desenvolupament Aplicacions Multiplataforma', '1r', 1, 6.0, '2024-09-01', '2025-06-20'),
(159, 1003, 'CFGS Desenvolupament Aplicacions Web', '1r', 1, 8.0, '2024-09-01', '2025-06-20'),
(160, 1004, 'CFGS Desenvolupament Aplicacions Web', '1r', 1, 7.0, '2023-09-01', '2024-06-20'),
(161, 1017, 'CFGS Desenvolupament Aplicacions Web', '1r', 1, 8.0, '2024-09-01', '2025-06-20'),
(162, 1022, 'CFGS Desenvolupament Aplicacions Web', '1r', 1, 7.0, '2023-09-01', '2024-06-20'),
(163, 1005, 'CFGS Administracio de Sistemes Informatics en Xarxa', '1r', 1, 7.0, '2024-09-01', '2025-06-20'),
(164, 1006, 'CFGS Administracio de Sistemes Informatics en Xarxa', '1r', 1, 7.0, '2023-09-01', '2024-06-20'),
(165, 1013, 'CFGS Administracio de Sistemes Informatics en Xarxa', '1r', 1, 8.0, '2023-09-01', '2024-06-20'),
(167, 1023, 'CFGS Administracio de Sistemes Informatics en Xarxa', '1r', 1, 8.0, '2023-09-01', '2024-06-20'),
(168, 1007, 'CFGM Sistemes Microinformatics i Xarxes', '1r', 1, 7.0, '2024-09-01', '2025-06-20'),
(169, 1020, 'CFGM Sistemes Microinformatics i Xarxes', '1r', 1, 6.0, '2023-09-01', '2024-06-20'),
(170, 1027, 'CFGM Sistemes Microinformatics i Xarxes', '1r', 1, 6.0, '2024-09-01', '2025-06-20'),
(172, 1014, 'CFGM Gestio Administrativa', '1r', 1, 6.0, '2023-09-01', '2024-06-20'),
(173, 1019, 'CFGM Gestio Administrativa', '1r', 1, 7.0, '2024-09-01', '2025-06-20'),
(174, 1026, 'CFGM Gestio Administrativa', '1r', 1, 7.0, '2024-09-01', '2025-06-20'),
(176, 1024, 'CFGS Comerce Internacional', '1r', 1, 7.0, '2024-09-01', '2025-06-20'),
(177, 1030, 'CFGS Comerce Internacional', '1r', 1, 7.0, '2023-09-01', '2024-06-20'),
(178, 1009, 'FP Basica Informatica', '1r', 1, 6.0, '2024-09-01', '2025-06-20'),
(179, 1025, 'FP Basica Informatica', '1r', 1, 6.0, '2024-09-01', '2025-06-20'),
(180, 1029, 'CFGS Desenvolupament Aplicacions Web', '1r', 0, 6.5, '2023-09-01', '2024-06-20'),
(181, 1005, 'CFGM Sistemes Microinformatics i Xarxes', '2n', 1, 7.0, '2023-09-01', '2024-06-20'),
(183, 1003, 'CFGM Sistemes Microinformatics i Xarxes', '2n', 1, 7.0, '2023-09-01', '2024-06-20'),
(184, 1001, 'CFGM Sistemes Microinformatics i Xarxes', '2n', 1, 7.0, '2023-09-01', '2024-06-20'),
(185, 1001, 'CFGM Sistemes Microinformatics i Xarxes', '1r', 1, 7.0, '2022-09-01', '2023-06-20'),
(186, 1007, 'FP Basica Informatica', '2n', 1, 7.0, '2022-09-01', '2024-06-20'),
(187, 1015, 'FP Basica Informatica', '2n', 1, 6.0, '2023-09-01', '2025-06-20'),
(188, 1014, 'CFGS Desenvolupament Aplicacions Web', '1r', 0, NULL, '2022-09-01', '2023-06-20'),
(189, 1020, 'FP Basica Informatica', '1r', 1, 7.5, '2022-09-01', '2023-06-20'),
(190, 1020, 'FP Basica Informatica', '2n', 1, 8.0, '2023-09-01', '2024-06-20'),
(191, 1026, 'CFGM Gestio Administrativa', '1r', 0, NULL, '2023-09-01', '2024-06-20');

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

DROP TABLE IF EXISTS `logs_consultes`;
CREATE TABLE `logs_consultes` (
  `id` int(11) NOT NULL,
  `dni_user` varchar(20) NOT NULL,
  `consulta` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logs_consultes`
--

INSERT INTO `logs_consultes` (`id`, `dni_user`, `consulta`) VALUES
(1, '11111111A', '/get_estudis.php?dni=11111111A&token=example'),
(2, '11111111A', '/get_profs.php?dni=11111111A&token=example'),
(3, '77777777G', '/get_estudis.php?dni=77777777G&token=example'),
(4, '22222222B', '/get_estudis.php?dni=22222222B&token=example'),
(5, '11111111A', '/get_perfil.php?dni=11111111A&token=example'),
(6, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0'),
(7, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&data_inici=2024-09-01&token=c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0'),
(8, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0'),
(9, '11111111A', '/get_estudis.php?dni=11111111A&token=c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0'),
(10, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0'),
(11, '11111111A', '/get_estudis.php?dni=11111111A&token=c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0'),
(12, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0'),
(13, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&data_inici=2024-09-01&token=c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0'),
(14, '11111111A', '/get_estudis.php?dni=11111111A&token=c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f'),
(15, '11111111A', '/get_expedient.php?dni=11111111A&cicle=CFGM%20Sistemes%20Microinformatics%20i%20Xarxes&token=c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f'),
(16, '11111111A', '/get_estudis.php?dni=11111111A&token=c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f'),
(17, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f'),
(18, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&data_inici=2024-09-01&token=c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f'),
(19, '11111111A', '/get_butlleti.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&data_inici=2024-09-01&token=c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f'),
(20, '11111111A', '/get_cursos.php?dni=11111111A&cicle=CFGS+Desenvolupament+Aplicacions+Multiplataforma&token=c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f'),
(21, '11111111A', '/get_estudis.php?dni=11111111A&token=c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f'),
(22, '11111111A', '/get_profs.php?dni=11111111A&token=4546839308749199f40ca9408091f6e59563e385996af46da8a49d1d4e2fae8b'),
(23, '11111111A', '/get_profs.php?dni=11111111A&token=4546839308749199f40ca9408091f6e59563e385996af46da8a49d1d4e2fae8b'),
(24, '11111111A', '/get_estudis.php?dni=11111111A&token=4546839308749199f40ca9408091f6e59563e385996af46da8a49d1d4e2fae8b'),
(25, '11111111A', '/get_estudis.php?dni=11111111A&token=3fbd2383aa53ad67d4d49e64a11e9e5b3c6df8678ea46e6a513de0d07d29590d'),
(26, '11111111A', '/get_estudis.php?dni=11111111A&token=d217b14c83675197f4458c24f9b342a8648524b4b1022be4a01c1dc72ee0a331'),
(27, '11111111A', '/get_perfil.php?dni=11111111A&token=d217b14c83675197f4458c24f9b342a8648524b4b1022be4a01c1dc72ee0a331'),
(28, '11111111A', '/get_estadistiques.php?token=d217b14c83675197f4458c24f9b342a8648524b4b1022be4a01c1dc72ee0a331'),
(29, '11111111A', '/get_estudis.php?dni=11111111A&token=d217b14c83675197f4458c24f9b342a8648524b4b1022be4a01c1dc72ee0a331'),
(30, '11111111A', '/get_perfil.php?dni=11111111A&token=a908d0d45ab52447f565bff38e0dcfbafa8a80885be62332b57eb3de1f60b409'),
(31, '11111111A', '/get_estadistiques.php?token=a908d0d45ab52447f565bff38e0dcfbafa8a80885be62332b57eb3de1f60b409'),
(32, '11111111A', '/get_estudis.php?dni=11111111A&token=dc0842397266d78f59d662614adaf80cab757529356c3689d76a9f6a79103e5e'),
(33, '11111111A', '/get_profs.php?dni=11111111A&token=dc0842397266d78f59d662614adaf80cab757529356c3689d76a9f6a79103e5e'),
(34, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=dc0842397266d78f59d662614adaf80cab757529356c3689d76a9f6a79103e5e'),
(35, '11111111A', '/get_perfil.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(36, '11111111A', '/get_estadistiques.php?token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(37, '11111111A', '/get_estudis.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(38, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(39, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(40, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(41, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(42, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(43, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(44, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(45, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(46, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(47, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(48, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(49, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(50, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(51, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF02&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(52, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(53, '11111111A', '/get_prof.php?dni=11111111A&codi_prof=PROF01&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(54, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(55, '11111111A', '/get_profs.php?dni=11111111A&token=bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c'),
(56, '11111111A', '/get_profs.php?dni=11111111A&token=e54bdb4d9e93ba248f8c9cd7455015b76c07f4b1455680028092edf2fb2f8bb7');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_login`
--

DROP TABLE IF EXISTS `logs_login`;
CREATE TABLE `logs_login` (
  `id` int(11) NOT NULL,
  `dni_user` varchar(20) NOT NULL,
  `ip` int(12) NOT NULL,
  `exito` tinyint(1) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logs_login`
--

INSERT INTO `logs_login` (`id`, `dni_user`, `ip`, `exito`, `data`) VALUES
(1, '11223344K', 2147483647, 1, '2026-05-04 22:45:28'),
(2, '12345678A', 2147483647, 1, '2026-05-04 22:47:09'),
(3, '11223344K', 2147483647, 0, '2026-05-04 22:49:34'),
(4, '11223344K', 2147483647, 1, '2026-05-04 22:49:42'),
(5, '11111111A', 2147483647, 1, '2026-05-06 02:58:34'),
(6, '22222222B', 184305510, 1, '2026-05-06 10:39:08'),
(7, '77777777G', 184305510, 1, '2026-05-06 10:25:47'),
(8, '11111111A', 184305510, 1, '2026-05-06 10:08:14'),
(9, '11223344K', 184305510, 1, '2026-05-06 10:24:29'),
(10, '12345678A', 184305510, 1, '2026-05-06 10:24:57'),
(11, '11111111A', 2147483647, 1, '2026-05-06 14:32:32'),
(12, '11111111A', 2147483647, 1, '2026-05-06 14:44:19'),
(13, '11111111A', 2147483647, 1, '2026-05-06 14:49:34'),
(14, '11111111A', 2147483647, 1, '2026-05-06 14:49:48'),
(15, '11111111A', 2147483647, 1, '2026-05-06 14:50:09'),
(16, '11111111A', 2147483647, 1, '2026-05-06 14:52:47'),
(17, '11111111A', 2147483647, 1, '2026-05-06 14:56:21'),
(18, '11111111A', 2147483647, 1, '2026-05-06 15:26:05'),
(19, '11111111A', 2147483647, 1, '2026-05-06 15:46:15'),
(20, '11111111A', 2147483647, 1, '2026-05-06 15:47:51'),
(21, '11111111A', 2147483647, 1, '2026-05-06 15:55:47'),
(22, '11111111A', 2147483647, 1, '2026-05-06 16:02:07'),
(23, '11111111A', 2147483647, 1, '2026-05-06 16:05:38'),
(24, '11111111A', 2147483647, 1, '2026-05-06 16:12:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodes_avaluacio`
--

DROP TABLE IF EXISTS `periodes_avaluacio`;
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
-- Volcado de datos para la tabla `periodes_avaluacio`
--

INSERT INTO `periodes_avaluacio` (`id`, `trimestre`, `curs`, `obert`, `data_obertura`, `data_tancament`, `obert_per`) VALUES
(4, 1, '2026-2027', 0, '2026-05-05 23:23:56', '2026-05-05 23:24:02', '11223344K'),
(5, 2, '2026-2027', 1, '2026-05-06 01:33:38', NULL, '11223344K'),
(6, 3, '2026-2027', 0, NULL, NULL, NULL);

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
  `ruta_foto` varchar(125) NOT NULL,
  `rol` enum('professor','alumne','director','administrador','tutor') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persones`
--

INSERT INTO `persones` (`dni`, `nom`, `cognom`, `data_naix`, `poblacio`, `codi_postal`, `nacionalitat`, `municipi_naix`, `telf_mob`, `telf_fix`, `email`, `ruta_foto`, `rol`) VALUES
('10101010J', 'Emma', 'Vidal Torres', '2006-01-30', 'Lleida', 25005, 'Espanyola', 'Lleida', 610101010, 973101010, 'emma.vidal@alumne.cat', '/img/alumns/alum10.png', 'alumne'),
('11111111A', 'Pol', 'Gómez Ruiz', '2005-02-18', 'Lleida', 25001, 'Espanyola', 'Lleida', 611111111, 973111111, 'pol.gomez@alumne.cat', '/img/alumns/perfil_11111111A.jpg', 'alumne'),
('11223344K', 'Eva', 'Torres Prat', '1974-12-05', 'Lleida', 25005, 'Espanyola', 'Lleida', 611223344, 973223344, 'eva.torres@institut.cat', 'img/profs/prof10.png', 'administrador'),
('12121212L', 'Arnau', 'Bosch Camps', '2005-06-15', 'Lleida', 25001, 'Espanyola', 'Lleida', 612121212, 973121212, 'arnau.bosch@alumne.cat', '/img/alumns/alum11.png', 'alumne'),
('12345678A', 'Marc', 'Serra Puig', '1978-03-12', 'Lleida', 25001, 'Espanyola', 'Lleida', 612345678, 973345678, 'marc.serra@institut.cat', 'img/profs/prof01.png', 'professor'),
('13131313M', 'Júlia', 'Ferrer Pons', '2006-02-28', 'Lleida', 25001, 'Espanyola', 'Lleida', 613131313, 973131313, 'julia.ferrer@alumne.cat', '/img/alumns/alum12.png', 'alumne'),
('14141414N', 'Roger', 'Llopis Mas', '2004-11-09', 'Lleida', 25002, 'Espanyola', 'Lleida', 614141414, 973141414, 'roger.llopis@alumne.cat', '/img/alumns/alum13.png', 'alumne'),
('15151515P', 'Carla', 'Mora Esteve', '2005-03-22', 'Lleida', 25002, 'Espanyola', 'Lleida', 615151515, 973151515, 'carla.mora@alumne.cat', '/img/alumns/alum14.png', 'alumne'),
('16161616Q', 'Marc', 'Torrents Gil', '2004-07-04', 'Lleida', 25003, 'Espanyola', 'Lleida', 616161616, 973161616, 'marc.torrents@alumne.cat', '/img/alumns/alum15.png', 'alumne'),
('17171717R', 'Sofia', 'Mas Vidal', '2005-05-12', 'Lleida', 25001, 'Espanyola', 'Lleida', 617171717, 973171717, 'sofia.mas@alumne.cat', '/img/alumns/alum16.png', 'alumne'),
('18181818S', 'Pau', 'Roca Gimeno', '2006-03-18', 'Lleida', 25001, 'Espanyola', 'Lleida', 618181818, 973181818, 'pau.roca@alumne.cat', '/img/alumns/alum17.png', 'alumne'),
('19191919T', 'Neus', 'Sala Pont', '2005-11-25', 'Lleida', 25002, 'Espanyola', 'Lleida', 619191919, 973191919, 'neus.sala@alumne.cat', '/img/alumns/alum18.png', 'alumne'),
('20202020U', 'Oriol', 'Vila Camps', '2006-07-04', 'Lleida', 25002, 'Espanyola', 'Lleida', 620202020, 973202020, 'oriol.vila@alumne.cat', '/img/alumns/alum19.png', 'alumne'),
('21212121V', 'Marina', 'Pons Esteve', '2005-09-30', 'Lleida', 25003, 'Espanyola', 'Lleida', 621212121, 973212121, 'marina.pons@alumne.cat', '/img/alumns/alum20.png', 'alumne'),
('22222222B', 'Aina', 'Martí Soler', '2006-11-05', 'Lleida', 25001, 'Espanyola', 'Lleida', 622222222, 973222222, 'aina.marti@alumne.cat', '/img/alumns/alum02.png', 'alumne'),
('22222223W', 'Gerard', 'Llopis Tort', '2004-12-15', 'Lleida', 25003, 'Espanyola', 'Lleida', 622222223, 973222223, 'gerard.llopis@alumne.cat', '/img/alumns/alum21.png', 'alumne'),
('23232323X', 'Mireia', 'Ferrer Mas', '2005-06-08', 'Lleida', 25004, 'Espanyola', 'Lleida', 623232323, 973232323, 'mireia.ferrer@alumne.cat', '/img/alumns/alum22.png', 'alumne'),
('23456789B', 'Anna', 'Ribas Soler', '1982-07-24', 'Lleida', 25001, 'Espanyola', 'Lleida', 623456789, 973456789, 'anna.ribas@institut.cat', 'img/profs/prof02.png', 'professor'),
('24242424Y', 'Dani', 'Soler Riba', '2006-01-22', 'Lleida', 25004, 'Espanyola', 'Lleida', 624242424, 973242424, 'dani.soler@alumne.cat', '/img/alumns/alum23.png', 'alumne'),
('25252525Z', 'Ona', 'Puig Tort', '2005-04-17', 'Lleida', 25005, 'Espanyola', 'Lleida', 625252525, 973252525, 'ona.puig@alumne.cat', '/img/alumns/alum24.png', 'alumne'),
('26262626A', 'Bernat', 'Coma Valls', '2004-08-29', 'Lleida', 25005, 'Espanyola', 'Lleida', 626262626, 973262626, 'bernat.coma@alumne.cat', '/img/alumns/alum25.png', 'alumne'),
('27272727B', 'Alba', 'Mir Prat', '2005-03-11', 'Lleida', 25001, 'Espanyola', 'Lleida', 627272727, 973272727, 'alba.mir@alumne.cat', '/img/alumns/alum26.png', 'alumne'),
('28282828C', 'Guillem', 'Tort Bosch', '2006-10-03', 'Lleida', 25001, 'Espanyola', 'Lleida', 628282828, 973282828, 'guillem.tort@alumne.cat', '/img/alumns/alum27.png', 'alumne'),
('29292929D', 'Laura', 'Font Sala', '2005-07-19', 'Lleida', 25002, 'Espanyola', 'Lleida', 629292929, 973292929, 'laura.font@alumne.cat', '/img/alumns/alum28.png', 'alumne'),
('30303030E', 'Alex', 'Camps Mir', '2004-02-06', 'Lleida', 25002, 'Espanyola', 'Lleida', 630303030, 973303030, 'alex.camps@alumne.cat', '/img/alumns/alum29.png', 'alumne'),
('31313131F', 'Claudia', 'Valls Roca', '2006-05-24', 'Lleida', 25003, 'Espanyola', 'Lleida', 631313131, 973313131, 'claudia.valls@alumne.cat', '/img/alumns/alum30.png', 'alumne'),
('32323232G', 'Miquel', 'Aguilar Blasco', '1980-04-14', 'Lleida', 25003, 'Espanyola', 'Lleida', 632323232, 973323232, 'miquel.aguilar@institut.cat', 'img/profs/prof11.png', 'professor'),
('33323232H', 'Cristina', 'Beltran Vidal', '1977-09-21', 'Lleida', 25004, 'Espanyola', 'Lleida', 633323232, 973332323, 'cristina.beltran@institut.cat', 'img/profs/prof12.png', 'professor'),
('33333333C', 'Nil', 'Costa Riba', '2005-07-23', 'Lleida', 25002, 'Espanyola', 'Lleida', 633333333, 973333333, 'nil.costa@alumne.cat', '/img/alumns/alum03.png', 'alumne'),
('34323232I', 'Raul', 'Gimenez Pons', '1983-01-08', 'Lleida', 25004, 'Espanyola', 'Lleida', 634323232, 973342323, 'raul.gimenez@institut.cat', 'img/profs/prof13.png', 'professor'),
('34567890C', 'Jordi', 'Casas Vila', '1975-11-03', 'Lleida', 25002, 'Espanyola', 'Lleida', 634567890, 973567890, 'jordi.casas@institut.cat', 'img/profs/prof03.png', 'professor'),
('35323232J', 'Montse', 'Llopis Camps', '1979-06-30', 'Lleida', 25005, 'Espanyola', 'Lleida', 635323232, 973352323, 'montse.llopis@institut.cat', 'img/profs/prof14.png', 'professor'),
('36323232K', 'Toni', 'Rovira Soler', '1981-11-15', 'Lleida', 25005, 'Espanyola', 'Lleida', 636323232, 973362323, 'toni.rovira@institut.cat', 'img/profs/prof15.png', 'professor'),
('44444444D', 'Laia', 'Romero Gil', '2005-09-14', 'Lleida', 25002, 'Espanyola', 'Lleida', 644444444, 973444444, 'laia.romero@alumne.cat', '/img/alumns/alum04.png', 'alumne'),
('45678901D', 'Marta', 'Puig Ferrer', '1980-05-19', 'Lleida', 25002, 'Espanyola', 'Lleida', 645678901, 973678901, 'marta.puig@institut.cat', 'img/profs/prof04.png', 'professor'),
('55555555E', 'Jan', 'Navarro Puig', '2006-03-09', 'Lleida', 25003, 'Espanyola', 'Lleida', 655555555, 973555555, 'jan.navarro@alumne.cat', '/img/alumns/alum05.png', 'alumne'),
('56789012E', 'Pere', 'Anton López', '1979-09-08', 'Lleida', 25003, 'Espanyola', 'Lleida', 656789012, 973789012, 'pere.anton@institut.cat', 'img/profs/prof05.png', 'professor'),
('66666666F', 'Clara', 'Ortiz Vila', '2005-12-27', 'Lleida', 25003, 'Espanyola', 'Lleida', 666666666, 973666666, 'clara.ortiz@alumne.cat', '/img/alumns/alum06.png', 'alumne'),
('67890123F', 'Laura', 'Sánchez Mora', '1983-01-15', 'Lleida', 25003, 'Espanyola', 'Lleida', 667890123, 973890123, 'laura.sanchez@institut.cat', 'img/profs/prof06.png', 'professor'),
('77777777G', 'Eric', 'Soler Llorens', '2005-04-11', 'Lleida', 25004, 'Espanyola', 'Lleida', 677777777, 973777777, 'eric.soler@alumne.cat', '/img/alumns/alum07.png', 'alumne'),
('78901234G', 'Carles', 'Domènech Roca', '1977-06-30', 'Lleida', 25004, 'Espanyola', 'Lleida', 678901234, 973901234, 'carles.domenech@institut.cat', 'img/profs/prof07.png', 'professor'),
('88888888H', 'Iris', 'Reig Amat', '2006-10-21', 'Lleida', 25004, 'Espanyola', 'Lleida', 688888888, 973888888, 'iris.reig@alumne.cat', '/img/alumns/alum08.png', 'alumne'),
('89012345H', 'Núria', 'Pérez Vidal', '1985-04-22', 'Lleida', 25004, 'Espanyola', 'Lleida', 689012345, 973012345, 'nuria.perez@institut.cat', 'img/profs/prof08.png', 'professor'),
('90123456I', 'Xavier', 'Font Mir', '1976-08-11', 'Lleida', 25005, 'Espanyola', 'Lleida', 690123456, 973123456, 'xavier.font@institut.cat', 'img/profs/prof09.png', 'professor'),
('99999999I', 'Biel', 'Pascual Serra', '2005-08-02', 'Lleida', 25005, 'Espanyola', 'Lleida', 699999999, 973999999, 'biel.pascual@alumne.cat', '/img/alumns/alum09.png', 'alumne');

--
-- Disparadores `persones`
--
DROP TRIGGER IF EXISTS `generarUsuari`;
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
DROP TRIGGER IF EXISTS `valid_email`;
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

DROP TABLE IF EXISTS `ras`;
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
(38, 3, 'MP05', '2025-04-01', '2025-06-13'),
(39, 1, 'MP02', '2024-09-01', '2024-12-20'),
(40, 2, 'MP02', '2025-01-08', '2025-06-13'),
(41, 1, 'MP09', '2024-09-01', '2024-12-20'),
(42, 2, 'MP09', '2025-01-08', '2025-06-13'),
(43, 1, 'MP10', '2024-09-01', '2024-12-20'),
(44, 2, 'MP10', '2025-01-08', '2025-06-13'),
(45, 1, 'MP12', '2024-09-01', '2024-12-20'),
(46, 2, 'MP12', '2025-01-08', '2025-06-13'),
(47, 1, 'MP13', '2024-09-01', '2024-12-20'),
(48, 2, 'MP13', '2025-01-08', '2025-06-13'),
(49, 1, 'MP15', '2024-09-01', '2024-12-20'),
(50, 2, 'MP15', '2025-01-08', '2025-06-13');

--
-- Disparadores `ras`
--
DROP TRIGGER IF EXISTS `verificarRa`;
DELIMITER $$
CREATE TRIGGER `verificarRa` BEFORE INSERT ON `ras` FOR EACH ROW BEGIN
    DECLARE exist INT DEFAULT 0;
    SELECT COUNT(*) INTO exist
    FROM ras
    WHERE ra = NEW.ra AND codi_assignatura = NEW.codi_assignatura;
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

DROP TABLE IF EXISTS `sessions`;
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
(1, '11111111A', 'a4ea43e3d60a772ed94b2627bba7a7865afe05cab7050ecd3c257aba9e61f288', '2026-05-06 03:55:35', '2026-05-06 13:55:35'),
(2, '11111111A', '42e34b0374260befeac8976375562c02d0a128901202216c009e0d64552f254c', '2026-05-06 04:19:17', '2026-05-06 14:19:17'),
(3, '11111111A', '5dd351c5c5d994b03840c1432fc8dd3a469a5090eb126826e9a97202a532b622', '2026-05-06 04:26:07', '2026-05-06 14:26:07'),
(4, '11111111A', '67833b830febbe281885185a51ed29deb1884bba0558c607c72865b8c9009896', '2026-05-06 04:26:48', '2026-05-06 14:26:48'),
(5, '11111111A', '20faa202d5fbfd0079427eafc50ced2ff0a1a9dd77e6120c14172105094c8a08', '2026-05-06 10:08:14', '2026-05-06 20:08:14'),
(6, '11223344K', 'f067682699bb90f0d11cbb4066499527410b6f66fea57ac80c5b1f2ba97cf8f4', '2026-05-06 10:24:29', '2026-05-06 20:24:29'),
(7, '12345678A', 'a84c1bfaefff387fb30fc871d6ac6e2fceb98b9c3e33565551cf658976d66872', '2026-05-06 10:24:57', '2026-05-06 20:24:57'),
(8, '77777777G', 'a2616b22769212952cc137d5c7df810da86b1ffed943c0885d0d087095d72d31', '2026-05-06 10:25:47', '2026-05-06 20:25:47'),
(9, '22222222B', '6aea66589ad384544750eee901014f618aa4c6e6419907064b7973098a8b76f6', '2026-05-06 10:39:08', '2026-05-06 20:39:08'),
(10, '77777777G', '3633e6483298f0cda851d3b4e1fcb341cad326270fc258cd3eafb1fa08fca473', '2026-05-06 10:40:07', '2026-05-06 20:40:07'),
(11, '11111111A', 'be7cbe7c8aaa7747d22a50e46508deee06619048e252a38943d0e33e5fe68327', '2026-05-06 10:41:47', '2026-05-06 20:41:47'),
(12, '11111111A', '6f791078894fdf05a7ea0bcd7225a4d63dc999f5ad5db855f83e5b1ccda1e966', '2026-05-06 10:49:52', '2026-05-06 20:49:52'),
(13, '11111111A', 'c91a69dc585a36534c8bd23575edb2ca9218f47e77124bfaee242bba42bf44e0', '2026-05-06 10:59:35', '2026-05-06 20:59:35'),
(14, '11111111A', 'c4ebbc922230e77a0fdb85acabdeac5b73d34fe41d919392f9e9add21e746d8f', '2026-05-06 14:32:32', '2026-05-07 00:32:32'),
(15, '11111111A', 'da4756e8b1c5a450e86f9a82e0b5b9887090551fe009de5938230ec568a6d382', '2026-05-06 14:44:19', '2026-05-07 00:44:19'),
(16, '11111111A', 'a56a7ab4ba224b14d9155617324554d9657a92dc9419ecb994e9035885e8d243', '2026-05-06 14:49:34', '2026-05-07 00:49:34'),
(17, '11111111A', 'bba5416befcaac8f745d12966c58f2b2075300e53be96512c4cf8a0b8f50b23a', '2026-05-06 14:49:48', '2026-05-07 00:49:48'),
(18, '11111111A', '4546839308749199f40ca9408091f6e59563e385996af46da8a49d1d4e2fae8b', '2026-05-06 14:50:09', '2026-05-07 00:50:09'),
(19, '11111111A', '3fbd2383aa53ad67d4d49e64a11e9e5b3c6df8678ea46e6a513de0d07d29590d', '2026-05-06 14:52:47', '2026-05-07 00:52:47'),
(20, '11111111A', '016bdf8a8c3e79d8b6375038da495de7d1acd4eafab8d8dee2e239f4ed1c8de1', '2026-05-06 14:56:21', '2026-05-07 00:56:21'),
(21, '11111111A', '5cd9f7ffed2fb1ac0140cc9bbd8511fd0cea1098b0ee8057a9e3578d8651e0cc', '2026-05-06 15:26:05', '2026-05-07 01:26:05'),
(22, '11111111A', 'd217b14c83675197f4458c24f9b342a8648524b4b1022be4a01c1dc72ee0a331', '2026-05-06 15:46:15', '2026-05-07 01:46:15'),
(23, '11111111A', 'a908d0d45ab52447f565bff38e0dcfbafa8a80885be62332b57eb3de1f60b409', '2026-05-06 15:47:51', '2026-05-07 01:47:51'),
(24, '11111111A', '9dfab29c7125dcc1d003b1ad51885d78aad89cf96248121617d309849ea11761', '2026-05-06 15:55:47', '2026-05-07 01:55:47'),
(25, '11111111A', 'dc0842397266d78f59d662614adaf80cab757529356c3689d76a9f6a79103e5e', '2026-05-06 16:02:07', '2026-05-07 02:02:07'),
(26, '11111111A', 'bba3f8eeb70b64874e9e06ba20799a480a25799e50ea3e7790befb107063dc4c', '2026-05-06 16:05:38', '2026-05-07 02:05:38'),
(27, '11111111A', 'e54bdb4d9e93ba248f8c9cd7455015b76c07f4b1455680028092edf2fb2f8bb7', '2026-05-06 16:12:06', '2026-05-07 02:12:06');

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
(43, '22222222B', 'amartísoler', '$2y$10$/ZKL1KG4UBPb8szT/vTWcOoZp31I3f6vSv1b.QYF8GBoNgUbRhaUK'),
(44, '33333333C', 'ncostariba', '$2y$10$/ZKL1KG4UBPb8szT/vTWcOoZp31I3f6vSv1b.QYF8GBoNgUbRhaUK'),
(45, '44444444D', 'lromerogil', '$2y$10$/ZKL1KG4UBPb8szT/vTWcOoZp31I3f6vSv1b.QYF8GBoNgUbRhaUK'),
(46, '55555555E', 'jnavarropui', '$2y$10$/ZKL1KG4UBPb8szT/vTWcOoZp31I3f6vSv1b.QYF8GBoNgUbRhaUK'),
(47, '66666666F', 'cortizvila', NULL),
(48, '77777777G', 'esolerllore', '$2y$10$/ZKL1KG4UBPb8szT/vTWcOoZp31I3f6vSv1b.QYF8GBoNgUbRhaUK'),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `acta_notes`
--
ALTER TABLE `acta_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;

--
-- AUTO_INCREMENT de la tabla `historic_actes`
--
ALTER TABLE `historic_actes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `historic_estudiants`
--
ALTER TABLE `historic_estudiants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT de la tabla `logs_login`
--
ALTER TABLE `logs_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `periodes_avaluacio`
--
ALTER TABLE `periodes_avaluacio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `prof_assignatura`
--
ALTER TABLE `prof_assignatura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `ras`
--
ALTER TABLE `ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id_session` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

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
--
-- Base de datos: `test`
--
DROP DATABASE IF EXISTS `test`;
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
