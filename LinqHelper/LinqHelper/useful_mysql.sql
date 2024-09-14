CREATE DEFINER=`root`@`%` PROCEDURE `SplitString`(IN `input_str` text,IN `delimiter` char(1))
BEGIN
	#Routine body goes here...
    DECLARE start_pos INT DEFAULT 1;
    DECLARE delim_pos INT DEFAULT 1;
  -- 创建临时表
	CREATE TEMPORARY TABLE IF NOT EXISTS temp_split (
			part INT
	);
		-- 清空临时表
	TRUNCATE TABLE temp_split;
    -- 分割字符串并插入临时表
    WHILE delim_pos > 0 DO
        SET delim_pos = LOCATE(delimiter, input_str, start_pos);
        IF delim_pos > 0 THEN
            INSERT INTO temp_split (part)
            VALUES (SUBSTRING(input_str, start_pos, delim_pos - start_pos));
            SET start_pos = delim_pos + 1;
        ELSE
            INSERT INTO temp_split (part)
            VALUES (SUBSTRING(input_str, start_pos));
        END IF;
    END WHILE;
		
	-- select * from temp_split;
END




CREATE DEFINER=`root`@`%` PROCEDURE `SplitStringToInt`(IN `input_str` text,IN `delimiter` char(1))
BEGIN
	#Routine body goes here...
	DECLARE start_pos INT DEFAULT 1;
	DECLARE delim_pos INT DEFAULT 1;
	DECLARE part_str VARCHAR(255);
	DECLARE part_int INT;
  -- 创建临时表
	CREATE TEMPORARY TABLE IF NOT EXISTS temp_split (
			part INT
	);
		-- 清空临时表
	TRUNCATE TABLE temp_split;
	-- 分割字符串并插入临时表
	WHILE delim_pos > 0 DO
			SET delim_pos = LOCATE(delimiter, input_str, start_pos);
			IF delim_pos > 0 THEN
					SET part_str = SUBSTRING(input_str, start_pos, delim_pos - start_pos);
					SET start_pos = delim_pos + 1;
			ELSE
					SET part_str = SUBSTRING(input_str, start_pos);
			END IF;

			-- 尝试将部分转换为整数并插入临时表
			SET part_int = CAST(part_str AS UNSIGNED);
			INSERT INTO temp_split (part)
			VALUES (part_int);
	END WHILE;
		
	-- select * from temp_split;
END
