ALTER TABLE `users` ADD `landlevel` INT(4) DEFAULT 0
INSERT INTO `jobs` (`name`, `label`) VALUES	('landscaper', 'Landscaper');
INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('landscaper',0,'recruit','Employee',500,'{}','{}'),
