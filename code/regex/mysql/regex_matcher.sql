DROP PROCEDURE IF EXISTS regex_matcher;

DELIMITER $$
CREATE PROCEDURE regex_matcher()
	BEGIN
		DECLARE n INT DEFAULT 29;
		DECLARE i INT DEFAULT 0;

		DECLARE s1 VARCHAR(58) DEFAULT "";
		DECLARE s2 VARCHAR(29) DEFAULT "";
		DECLARE regex VARCHAR(87);

		WHILE i < n - 1 DO
			SET s1 = CONCAT(s1, 'a?');
			SET s2 = CONCAT(s2, 'a');
			SET regex = CONCAT(s1, s2);

			SELECT
				CASE
					WHEN s2 REGEXP regex THEN (SELECT CONCAT(s2, ' matches ', regex))
				END
			FROM dual;

			SET i = i + 1;
		END WHILE;
	END
$$

CALL regex_matcher();