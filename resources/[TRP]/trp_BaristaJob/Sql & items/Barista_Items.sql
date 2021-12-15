INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('Milk', 'Fresh Milk', 5, 0, 1),
	('Sugar', 'Sugar', 5, 0, 1),
	('WaterJug', 'Water jug', 5, 0, 1),
    ('Half_Made_Coffee', 'Half_Made_Coffee', 5, 0, 1),
    ('Half_Made_Small_Coffee', 'Half_Made_Small_Coffee', 5, 0, 1),
	('Coffee_Beans', 'Coffee Beans', 2, 0, 1),
    ('Black_Coffee', 'Black Coffee', 5, 0, 1),
    ('White_Coffee', 'White Coffee', 5, 0, 1),
    ('Espresso', 'Espresso', 5, 0, 1),
    ('Cappuccino', 'Cappuccino', 5, 0, 1),
    ('FlatWhite', 'FlatWhite', 5, 0, 1),
    ('Frappe', 'FRAPPÉ', 5, 0, 1),
    ('IrishCoffee', 'IRISH COFFEE', 5, 0, 1),
    ('irishwhisky', 'IRISH Whisky', 5, 0, 1),
    ('Latte', 'Latte', 5, 0, 1),
    ('Coffee_Grounds', 'Coffee_Grounds', 5, 0, 1),
    ('DbleEspresso', 'Double Espresso', 5, 0, 1),
    ('Ice', 'Ice', 5, 0, 1),
    ('frothedmilk', 'frothedmilk', 5, 0, 1),
    ('cloth', 'cloth', 5, 0, 1)	,
    ('dirtycloth', 'dirtycloth', 5, 0, 1),
    ('whitecoffee2go', 'White Coffee 2 go', 5, 0, 1), 
    ('cocainecoffee', 'C0ffee to Go', 5, 0, 1), 
    ('EmptyJug', 'Coffee to Go', 5, 0, 1),
    ('emptycoffeecup', 'empty coffee cup', 5, 0, 1),
    ('emptycoffeecup2', 'emptycoffeecup', 5, 0, 1),
    ('cocainewhitecoffee', 'White C0ffee', 5, 0, 1);
    
INSERT INTO `jobs` (`name`, `label`) VALUES	('barista', 'barista');

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_barista','Barista',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_barista','Barista',1)
;


INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('barista',0,'recruit','Recrue',500,'{}','{}'),
	('barista',1,'novice','Novice',600,'{}','{}'),
	('barista',2,'experienced','Experimente',700,'{}','{}'),
	('barista',3,'boss','Patron',800,'{}','{}')
;