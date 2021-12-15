-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.5.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping data for table essentialmode_dev.items: ~144 rows (approximately)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('advancedlockpick', 'Multi-pick', 5, 0, 1),
	('airbag', 'Airbag', 5, 0, 1),
	('alive_chicken', 'Living chicken', 5, 0, 1),
	('armor', 'Armor', 2, 0, 1),
	('armor2', 'Dense Armor', 2, 0, 1),
	('avengersendgamedvd', 'Avengers-DVD', 3, 0, 1),
	('baggy', 'Baggy', 10, 0, 1),
	('bandage', 'EMS Bandage', 10, 0, 1),
	('bandage2', 'Small Bandage', 10, 0, 1),
	('battery', 'Car Battery', 5, 0, 1),
	('black_money', 'Dirty Money', -1, 0, 1),
	('blowpipe', 'Blowtorch', 5, 0, 1),
	('blunt', 'Blunt', 10, 0, 1),
	('bluntwrap', 'Blunt Wrap', 10, 0, 1),
	('boxpistol', 'Ammo Box Pistol', 10, 0, 1),
	('boxrifle', 'Ammo Box Rifle', 10, 0, 1),
	('boxshot', 'Ammo Box Shotgun', 10, 0, 1),
	('boxsmg', 'Ammo Box SMG', 10, 0, 1),
	('boxsniper', 'Ammo Box Sniper', 10, 0, 1),
	('bread', 'Bread', 15, 0, 1),
	('bulletproof', 'Skottsäker vest', 1, 0, 1),
	('cannabis', 'Cannabis', 10, 0, 1),
	('carokit', 'Body Kit', 10, 0, 1),
	('carotool', 'Tools', 10, 0, 1),
	('cash', 'notusedcash', 10, 0, 1),
	('cburger', 'Cheese Burger', 10, 0, 1),
	('chemicals', 'Crack Chems', 10, 0, 1),
	('chemicals1', 'Meth Chems', 10, 0, 1),
	('chemicals2', 'Opium Chems', 10, 0, 1),
	('clothe', 'Cloth', 5, 0, 1),
	('coca', 'CocaPlant', 10, 0, 1),
	('coke', 'Coke', 10, 0, 1),
	('cola', 'Can of Cola', 5, 0, 1),
	('coldwar', 'PS5 ColdWar', 2, 0, 1),
	('copper', 'Copper', 10, 0, 1),
	('crack', 'Crack', 10, 0, 1),
	('cuffs', 'Police Handcuff', 5, 0, 1),
	('cuff_keys', 'Handcuff Key', 1, 0, 1),
	('cutted_wood', 'Cut wood', 30, 0, 1),
	('cyberpunk', 'PS4 CyberPunk', 2, 0, 1),
	('dabs', 'Dabs', 10, 0, 1),
	('daredbl500ml', 'Dare Ice Coffee', 10, 0, 1),
	('darkknightbluray', 'Dark Knight Bluray', 10, 0, 1),
	('darknet', 'Dark Net', 1, 0, 1),
	('dcburger', 'Double Cheese Burger', 10, 0, 1),
	('diamond', 'Diamond', 25, 0, 1),
	('diamondring', 'Diamond Ring', 4, 0, 1),
	('donut', 'Glazed Donut', 10, 0, 1),
	('donut2', 'Super Donut', 10, 0, 1),
	('drugpress', 'Drug Press', 10, 0, 1),
	('ephedra', 'Ephedra', 10, 0, 1),
	('essence', 'Gas', 25, 0, 1),
	('fabric', 'Fabric', 25, 0, 1),
	('fish', 'Fish', 25, 0, 1),
	('fishbait', 'Fish Bait', 10, 0, 1),
	('fishingrod', 'Fishing Rod', 2, 0, 1),
	('fixkit', 'Repair Kit', 10, 0, 1),
	('fixtool', 'Repair Tools', 10, 0, 1),
	('fountain', 'Fountain Firework', 2, 0, 1),
	('fries', 'Small Fries', 5, 0, 1),
	('fries2', 'Large Fries', 5, 0, 1),
	('gazbottle', 'Gas Bottle', 10, 0, 1),
	('gold', 'Gold', 5, 0, 1),
	('gold_o', 'Scrap gold', 50, 0, 1),
	('gold_t', 'Gold', 25, 0, 1),
	('gta5', 'PS4 GTA V', 3, 0, 1),
	('heroine', 'Heroine', 10, 0, 1),
	('highradio', 'Aftermarket Radio', 5, 0, 1),
	('highrim', 'Nice Rim', 5, 0, 1),
	('hotdog', 'Hotdog', 10, 0, 1),
	('iron', 'Iron', 15, 0, 1),
	('jewels', 'Jewels', 200, 0, 1),
	('joint', 'Joint', 10, 0, 1),
	('juicewrldalbum', 'Juice Wrld Album', 2, 0, 1),
	('keycard', 'Keycard', 5, 0, 1),
	('landscaperFinish', 'Landscaper Finish', 10, 0, 1),
	('landscaperStart', 'Landscaper GPS', 1, 0, 1),
	('landscaperTools', 'Landscaper Gardening Tools', 1, 0, 1),
	('licenseplate', 'License plate', 5, 0, 1),
	('louisvuittionbag', 'Louis Vuittion Bag', 1, 0, 1),
	('lowradio', 'Stock Radio', 5, 0, 1),
	('lsd', 'LSD', 10, 0, 1),
	('macbook', 'Mac Book', 1, 0, 1),
	('marijuana', 'Marijuana', 100, 0, 1),
	('medicalrestraints', 'EMS Medical Restraints', 1, 0, 1),
	('medikit', 'EMS Medikit', 15, 0, 1),
	('medikit1', 'EMS Splint', 10, 0, 1),
	('meth', 'Meth', 10, 0, 1),
	('Minecraft', 'Xbox One Minecraft', 10, 0, 1),
	('mleko', 'Unpasturized Milk', 50, 0, 1),
	('molly', 'Molly', 10, 0, 1),
	('money', 'Money', -1, 0, 1),
	('monster', 'Monster Energy', 5, 0, 1),
	('narcan', 'Narcan', 10, 0, 1),
	('needle', 'Hypodermic Needle', 10, 0, 1),
	('nerfgun', 'Nerf Gun', 10, 0, 1),
	('nikeairforceone', 'Nike Air Force', 10, 0, 1),
	('opium', 'Opium', 10, 0, 1),
	('oxygen_mask', 'Oxygen Mask', 2, 0, 1),
	('packaged_chicken', 'Chicken fillet', 10, 0, 1),
	('packaged_plank', 'Packaged wood', 25, 0, 1),
	('petrol', 'Oil', 30, 0, 1),
	('petrol_raffin', 'Processed oil', 30, 0, 1),
	('phone', 'Phone', 5, 0, 1),
	('picnic', 'Picknick kit', 1, 0, 1),
	('poppy', 'Poppy', 10, 0, 1),
	('ps5', 'PS5', 10, 0, 1),
	('radio', 'radio', 2, 0, 1),
	('redgull', 'Redbull', 4, 0, 1),
	('repairkit', 'Vehicle Repair Kit', 20, 0, 1),
	('rolex', 'Rolex Watch', 10, 0, 1),
	('rose', 'Röd ros', 1, 0, 1),
	('sandwich', 'Macka', 5, 0, 1),
	('shotburst', 'Shotburst Firework', 2, 0, 1),
	('shroom', 'Shrooms', 10, 0, 1),
	('slaughtered_chicken', 'Slaughtered chicken', 25, 0, 1),
	('spice', 'Spice', 30, 0, 1),
	('sprite', 'Bottle of 7UP', 5, 0, 1),
	('starburst', 'Starburst Firework', 2, 0, 1),
	('stockrim', 'Stock Rim', 5, 0, 1),
	('stone', 'Stone', 25, 0, 1),
	('sudafed', 'Sudafed', 10, 0, 1),
	('supremehoodie', 'Supreme Hoodie', 10, 0, 1),
	('taco', 'Taco', 5, 0, 1),
	('taco2', 'Deluxe Taco', 5, 0, 1),
	('taco3', 'Steves Special Taco', 5, 0, 1),
	('taco4', 'Super Taco', 5, 0, 1),
	('trailburst', 'Trailburst Firework', 2, 0, 1),
	('travisscottjordan', 'Travis Scott Jordan', 10, 0, 1),
	('trimmers', 'Trimmers', 10, 0, 1),
	('truckersGPS', 'Trucking GPS', 10, 0, 1),
	('TruckingDeliver', 'Unload Truck', 10, 0, 1),
	('TruckingFinish', 'Finish Trucking', 10, 0, 1),
	('tuning_laptop', 'Tuning Laptop', 10, 0, 1),
	('turbo', 'Turbo', 5, 0, 1),
	('turtlebait', 'Turtle Bait', 10, 0, 1),
	('umbrella', 'Paraply', 2, 0, 1),
	('washed_stone', 'Washed stone', 25, 0, 1),
	('water', 'Water', 15, 0, 1),
	('wetshroom', 'Wetshroom', 10, 0, 1),
	('wood', 'Wood', 25, 0, 1),
	('wool', 'Wool', 25, 0, 1),
	('xbox', 'Xbox Series X', 10, 0, 1),
	('xxxalbum', 'XXX Album', 10, 0, 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;