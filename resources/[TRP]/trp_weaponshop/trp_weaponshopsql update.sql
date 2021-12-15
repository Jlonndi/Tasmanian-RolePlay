-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.14-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for essentialmode
CREATE DATABASE IF NOT EXISTS `essentialmode` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `essentialmode`;

-- Dumping structure for table essentialmode.trp_weashops
CREATE TABLE IF NOT EXISTS `trp_weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `imglink` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55556 DEFAULT CHARSET=utf8;

-- Dumping data for table essentialmode.trp_weashops: ~7 rows (approximately)
/*!40000 ALTER TABLE `trp_weashops` DISABLE KEYS */;
INSERT INTO `trp_weashops` (`id`, `zone`, `item`, `price`, `imglink`) VALUES
	(1, 'GunShop', 'WEAPON_PISTOL', 20000, 'https://cdn.discordapp.com/attachments/764098140236152859/770487363025371156/WEAPON_PISTOL50.png'),
	(3, 'GunShop', 'WEAPON_KNUCKLE', 5000, 'https://cdn.discordapp.com/attachments/764098140236152859/770487204593139753/WEAPON_KNUCKLE.png'),
	(4, 'GunShop', 'WEAPON_KNIFE', 6000, 'https://cdn.discordapp.com/attachments/764098140236152859/770487239263256606/WEAPON_KNIFE.png'),
	(5, 'GunShop', 'WEAPON_FLASHLIGHT', 3000, 'https://cdn.discordapp.com/attachments/764098140236152859/770487284725448714/WEAPON_FLASHLIGHT.png'),
	(6, 'BlackWeashop', 'WEAPON_PISTOL', 35000, 'https://cdn.discordapp.com/attachments/764098140236152859/770487363025371156/WEAPON_PISTOL50.png'),
	(9, 'BlackWeashop', 'WEAPON_HATCHET', 6000, 'https://cdn.discordapp.com/attachments/764098140236152859/770487471115862016/WEAPON_HATCHET.png'),
	(10, 'BlackWeashop', 'WEAPON_HAMMER', 5000, 'https://cdn.discordapp.com/attachments/764098140236152859/770487424387121172/WEAPON_HAMMER.png'),
	(11, 'BlackWeashop', 'WEAPON_CARBINERIFLE', 100000, 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/grand-theft-auto-5/e/e0/Carbine-rifle-mk2.png?width=1280');
/*!40000 ALTER TABLE `trp_weashops` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
