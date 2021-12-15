CREATE TABLE `esx_adrp_dealership` (
	`plate` VARCHAR(8) NOT NULL,
	`owner` VARCHAR(22) NOT NULL,
	`network_id` INT(11) NOT NULL,
	`label` VARCHAR(50) NOT NULL DEFAULT '0',
	`vehicle_props` LONGTEXT NOT NULL,
	`price` INT(11) NOT NULL DEFAULT '0',

	PRIMARY KEY (`plate`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
