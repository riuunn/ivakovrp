INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
  ('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('ambulance',1,'ambulance','Ambulancier',20,'{"tshirt_1":15,"tshirt_2":0,"torso_1":249,"torso_2":1,"pants_1":96,"pants_2":1,"shoes":9,"decals_1":57,"decals_2":0,"helmet_1":122,"helmet_2":1,"arms":90}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
  ('ambulance',2,'doctor','Medecin',40,'{"tshirt_1":15,"tshirt_2":0,"torso_1":249,"torso_2":1,"pants_1":96,"pants_2":1,"shoes":9,"decals_1":57,"decals_2":0,"helmet_1":122,"helmet_2":1,"arms":90}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
  ('ambulance',3,'chief_doctor','Medecin-chef',60,'{"tshirt_1":15,"tshirt_2":0,"torso_1":249,"torso_2":1,"pants_1":96,"pants_2":1,"shoes":9,"decals_1":57,"decals_2":0,"helmet_1":122,"helmet_2":1,"arms":90}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
  ('ambulance',4,'boss','Chirurgien',80,'{"tshirt_1":15,"tshirt_2":0,"torso_1":249,"torso_2":1,"pants_1":96,"pants_2":1,"shoes":9,"decals_1":57,"decals_2":0,"helmet_1":122,"helmet_2":1,"arms":90}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}')
;

INSERT INTO `jobs` (name, label) VALUES
  ('ambulance','Ambulance')
;

INSERT INTO `items` (name, label, `limit`) VALUES
  ('bandage','Bandage', 20),
  ('medikit','Medikit', 10)
;

ALTER TABLE `users` ADD `isDead` BIT(1) DEFAULT b'0'