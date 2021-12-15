INSERT INTO `jobs` (name, label) VALUES
  ('offpolice','Off-Duty'),
  ('offambulance','Off-Duty'),
  ('offmecano','Off-Duty')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('offpolice',0,'recruit','Recrue',500,'{}','{}'),
  ('offpolice',1,'officer','Officier',500,'{}','{}'),
  ('offpolice',2,'sergeant','Sergent',500,'{}','{}'),
  ('offpolice',3,'lieutenant','Lieutenant',650,'{}','{}'),
  ('offpolice',4,'boss','Commandant',1000,'{}','{}'),
  ('offambulance',0,'ambulance','Ambulance',500,'{}','{}'),
  ('offambulance',1,'doctor','Doctor',500,'{}','{}'),
  ('offambulance',2,'chief_doctor','Chief Doctor',650,'{}','{}'),
  ('offambulance',3,'boss','Boss',1000,'{}','{}'),
  ('offmecano',0,'recrue','Technician',500,'{}','{}'),
  ('offmecano',1,'novice','Technician',500,'{}','{}'),
  ('offmecano',2,'experimente','Technician',500,'{}','{}'),
  ('offmecano',3,'chief','Chef déquipe',650,'{}','{}'),
  ('offmecano',4,'boss','Patron',1000,'{}','{}')
;