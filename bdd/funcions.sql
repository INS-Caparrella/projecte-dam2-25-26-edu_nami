--FUNCIONS

DROP FUNCTION IF EXISTS majorEdat;
DELIMITER //
CREATE FUNCTION majorEdat(dni VARCHAR(9))
RETURNS BOOLEAN
BEGIN
    DECLARE edat INT;
    DECLARE major BOOLEAN DEFAULT FALSE;

    SELECT TIMESTAMPDIFF(YEAR, data_naix, CURDATE()) 
    INTO edat FROM persones p 
    WHERE p.dni = dni;

    IF edat IS NOT NULL AND edat >= 18 THEN
        SET major = TRUE;
    END IF;

    RETURN major;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS intentsLogin;
DELIMITER //
CREATE FUNCTION intentsLogin(userId INT, rang1 DATETIME, rang2 DATETIME)
RETURNS INT
BEGIN
    DECLARE result INT DEFAULT 0;

    SELECT COUNT(*) INTO result
    FROM logs_login l
    WHERE l.id_user = userId
      AND l.data BETWEEN rang1 AND rang2;

    RETURN result;
END//
DELIMITER ;

SELECT intentsLogin(5, '2025-11-13 08:00:00', '2025-11-13 12:00:00');


--PROCEDURES

DROP PROCEDURE IF EXISTS llistatMajorsEdatEstudiants;
DELIMITER //
CREATE PROCEDURE llistatMajorsEdatEstudiants()
BEGIN
    SELECT p.nom AS nom,p.cognom AS cognom, TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) AS edat
    FROM persones p JOIN estudiant e ON e.dni = p.dni
    WHERE TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) >= 18
    ORDER BY p.nom,p.cognom;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS alumnesGrup;
DELIMITER //
CREATE PROCEDURE alumnesGrup(IN grup VARCHAR(11))
BEGIN
    SELECT p.nom,p.cognom,p.dni, TIMESTAMPDIFF(YEAR, p.data_naix, CURDATE()) AS edat
    FROM persones p
    JOIN estudiants e ON e.dni=p.dni 
    WHERE e.nom_grup = grup
    ORDER BY p.nom,p.cognom;
END//
DELIMITER ;
CALL alumnesGrup('A1');

--TRIGGERS

DROP TRIGGER IF EXISTS generarUsuari;
DELIMITER //
CREATE TRIGGER generarUsuari
AFTER INSERT ON persones
FOR EACH ROW
BEGIN
    DECLARE usernameBase VARCHAR(50);
    DECLARE usernameFinal VARCHAR(50);
    DECLARE cont INT DEFAULT 0;

    SET usernameBase = CONCAT(
        LOWER(LEFT(NEW.nom, 1)),
        LOWER(NEW.cognom)
    );

    SET usernameFinal = usernameBase;

    WHILE EXISTS (
        SELECT 1 FROM usuaris WHERE username = usernameFinal
    ) DO
        SET cont = cont + 1;
        SET usernameFinal = CONCAT(usernameBase, cont);
    END WHILE;

    INSERT INTO usuaris (username, dni)
    VALUES (usernameFinal, NEW.dni);
END//
DELIMITER ;



DROP TRIGGER IF EXISTS estudiantHistoric;
DELIMITER //
CREATE TRIGGER estudiantHistoric
AFTER UPDATE ON estudiants
FOR EACH ROW
BEGIN
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
END//
DELIMITER ;

DROP TRIGGER IF EXISTS promocio_fp_update;
DELIMITER //
CREATE TRIGGER promocio_fp_update
AFTER UPDATE ON estudiants_ras
FOR EACH ROW
BEGIN
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
END//
DELIMITER ;

DROP TRIGGER IF EXISTS promocio_fp_insert;
DELIMITER //
CREATE TRIGGER promocio_fp_insert
AFTER INSERT ON estudiants_ras
FOR EACH ROW
BEGIN
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
END//
DELIMITER ;











