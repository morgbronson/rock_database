USE rocks;

-- fossil
-- insert new fossil into database

DROP PROCEDURE IF EXISTS insert_fossil;

DELIMITER //

CREATE PROCEDURE insert_fossil
(
    IN class_param VARCHAR(25),
    IN genus_param VARCHAR(25), 
    IN species_param VARCHAR(25)
)
BEGIN
INSERT INTO fish VALUES(DEFAULT, class, genus, species);
END //

CALL insert_fossil('Myxini', NULL, NULL);

-- update crustacean row in fossil table 

DROP PROCEDURE IF EXISTS update_fossil;

DELIMITER //


CREATE  PROCEDURE update_fossil


(
    IN fossil_id_param INT,
    IN class_param VARCHAR(25),
    IN genus_param VARCHAR(25), 
    IN species_param VARCHAR(25)
)
BEGIN
UPDATE  fossil
SET class = class_param, genus = genus_param, species = species_param
WHERE fossil_id = fossil_id_param;

END //

CALL update_fossil(10, 'Arthropod', 'Crustacean', "Brachyura");

-- delete newly inserted fossil

DROP PROCEDURE IF EXISTS delete_fossil;

DELIMITER //

CREATE  PROCEDURE delete_fossil
(
    IN fossil_id_param INT

)
BEGIN
DELETE 
FROM fossil
WHERE fossil_id = fossil_id_param;

END //

CALL delete_fossil(23);

-- delete new fossil

DROP PROCEDURE IF EXISTS retrieve_fossil;

DELIMITER //

CREATE PROCEDURE retrieve_fossil

(
    IN class_param VARCHAR(25)

)
BEGIN
SELECT * 
FROM fossil
WHERE class like CONCAT(class_param, '%');

END //

-- location
-- insert new location into database

DROP PROCEDURE IF EXISTS insert_location;

DELIMITER //

CREATE PROCEDURE insert_location
(
    IN area_type_param VARCHAR(25)

)
BEGIN
INSERT INTO location VALUES(DEFAULT, area_type);
END //

CALL insert_location("Sand Dune");

-- update update sand dune in location table

DROP PROCEDURE IF EXISTS update_location;

DELIMITER //


CREATE PROCEDURE update_location

(
    IN loc_id_param INT,
    IN area_type_param VARCHAR(25)
)
BEGIN
UPDATE  location
SET area_type = area_type_param
WHERE loc_id = loc_id_param;

END //

CALL update_location(19, "Sand Dunes");

-- delete newly inserted location

DROP PROCEDURE IF EXISTS delete_location;

DELIMITER //

CREATE  PROCEDURE delete_location
(
    IN loc_id_param INT

)
BEGIN
DELETE 
FROM location
WHERE loc_id = loc_id_param;

END //

CALL delete_location(19);

-- see if sand dunes got deleted

DROP PROCEDURE IF EXISTS retrieve_location;

DELIMITER //

CREATE PROCEDURE retrieve_location

(
    IN area_type_param VARCHAR(25)

)
BEGIN
SELECT * 
FROM location
WHERE area_type like CONCAT(area_type_param, '%');

END //

CALL retrieve_location('Sand Dunes');

-- insert mineral 

DELIMITER //

DROP PROCEDURE IF EXISTS insert_mineral; 

CREATE PROCEDURE insert_mineral
(
    IN name_param VARCHAR(25),
    IN colors_param VARCHAR(40),
    IN special_prop_param VARCHAR(25),
    IN hardness_param VARCHAR(25), 
    IN luster_param VARCHAR(25), 
    IN streak_param VARCHAR(25), 
    IN cleavage_fracture_param VARCHAR(25), 
    IN composition VARCHAR(25)

)
BEGIN
INSERT INTO mineral VALUES(DEFAULT, name, colors, special_prop, hardness, luster, streak, cleavage_fracture, composition);
END //

CALL insert_mineral("Asebtos", "Green, red, yellow, white, blue", NULL, 4.5, "Silky", "White", "Fibrous", "Felsic");

-- update mineral name to spell right and add a color

DROP PROCEDURE IF EXISTS update_mineral;

DELIMITER //


CREATE  PROCEDURE update_mineral


(
    IN min_id_param INT,
    IN name_param VARCHAR(25),
    IN colors_param VARCHAR(80)
)
BEGIN
UPDATE  mineral
SET colors = colors_param
WHERE min_id = min_id_param;

END //

CALL update_mineral(53, "Asbestos", "Green, red, yellow, white, gray, blue");

-- delete asbestos

DROP PROCEDURE IF EXISTS delete_mineral;

DELIMITER //

CREATE  PROCEDURE delete_mineral
(
    IN min_id_param INT

)
BEGIN
DELETE 
FROM mineral
WHERE min_id = min_id_param;

END //

CALL delete_mineral(53);

-- see if asbestos got deleted

DROP PROCEDURE IF EXISTS retrieve_mineral;

DELIMITER //

CREATE PROCEDURE retrieve_mineral

(
    IN name_param VARCHAR(25)

)
BEGIN
SELECT * 
FROM mineral
WHERE name like CONCAT(name_param, '%');

END //

CALL retrieve_mineral('Asbestos');

-- rocks
-- insert wackestone 

DELIMITER //

DROP PROCEDURE IF EXISTS insert_rocks; 

CREATE PROCEDURE insert_rocks
(
    IN name_param VARCHAR(25), 
    IN type_param VARCHAR(25), 
    IN sed_type_param VARCHAR(25), 
    IN loc_id_param INT, 
    IN min_id_param INT

)
BEGIN
INSERT INTO mineral VALUES(DEFAULT, name, type, sed_type, loc_id, min_id);
END //

CALL insert_location("Wackestone", "Sedimentary", "Biochemical", 5, 1);

-- update mineral from quartz to calcite

DROP PROCEDURE IF EXISTS update_rocks;

DELIMITER //

CREATE  PROCEDURE update_rocks


(
    IN rock_id_param INT,
    IN min_id VARCHAR(25)
)
BEGIN
UPDATE  rock
SET min_id = min_id_param
WHERE rock_id = rock_id_param;

END //

CALL update_rocks(16, 4);

-- delete wackestone

DROP PROCEDURE IF EXISTS delete_rocks;

DELIMITER //

CREATE  PROCEDURE delete_rocks
(
    IN rock_id_param INT

)
BEGIN
DELETE 
FROM rocks
WHERE rock_id = rock_id_param;

END //

CALL delete_rocks(18);

-- see if wackestone got deleted

DROP PROCEDURE IF EXISTS retrieve_rocks;

DELIMITER //

CREATE PROCEDURE retrieve_rocks

(
    IN name_param VARCHAR(25)

)
BEGIN
SELECT * 
FROM rocks
WHERE name like CONCAT(name_param, '%');

END //

CALL retrieve_rocks('Wackestone');

-- structures
-- insert folded as a structure

DELIMITER //

DROP PROCEDURE IF EXISTS insert_structure;
 
CREATE PROCEDURE insert_structure
(
    IN type_param VARCHAR(25)

)
BEGIN
INSERT INTO structures VALUES(DEFAULT, type);
END //

CALL insert_structure("Folded");

-- update folded to syncline

DROP PROCEDURE IF EXISTS update_structure;

DELIMITER //


CREATE  PROCEDURE update_structure


(
    IN struct_id_param INT,
    IN area_type_param VARCHAR(25)
)
BEGIN
UPDATE  structure
SET type = type_param
WHERE struct_id = struct_id_param;

END //

CALL update_structure(12, "Syncline");

-- delete newly inserted structure

DROP PROCEDURE IF EXISTS delete_structure;

DELIMITER //

CREATE  PROCEDURE delete_structure
(
    IN struct_id_param INT

)
BEGIN
DELETE 
FROM structures
WHERE struct_id = struct_id_param;

END //

CALL delete_structures(12);

-- retrieve syncline

DROP PROCEDURE IF EXISTS retrieve_structure;

DELIMITER //

CREATE PROCEDURE retrieve_structure

(
    IN type_param VARCHAR(25)

)
BEGIN
SELECT * 
FROM location
WHERE area_type like CONCAT(type_param, '%');

END //

CALL retrieve_structure('Syncline');

-- texture
-- insert vesicular texture

DELIMITER //

DROP PROCEDURE IF EXISTS insert_texture; 

CREATE PROCEDURE insert_texture
(
    IN type_param VARCHAR(25)

)
BEGIN
INSERT INTO texture VALUES(DEFAULT, type);
END //

CALL insert_texture("Vesicules");

-- update vesicular to scoraious

DROP PROCEDURE IF EXISTS update_texture;

DELIMITER //


CREATE  PROCEDURE update_texture


(
    IN text_id_param INT,
    IN type_param VARCHAR(25)
)
BEGIN
UPDATE  texture
SET type = type_param
WHERE text_id = text_id_param;

END //

CALL update_texture(18, "Scoraious");

-- delete scoraious texture

DROP PROCEDURE IF EXISTS delete_texture;

DELIMITER //

CREATE  PROCEDURE delete_texture
(
    IN text_id_param INT

)
BEGIN
DELETE 
FROM texture
WHERE text_id = text_id_param;

END //

CALL delete_texture(18);

-- retrieve scoraious

DROP PROCEDURE IF EXISTS retrieve_texture;

DELIMITER //

CREATE PROCEDURE retrieve_texture

(
    IN type_param VARCHAR(25)

)
BEGIN
SELECT * 
FROM texture
WHERE type like CONCAT(type_param, '%');

END //

CALL retrieve_texture('Scoraious');

-- rock has fossil
-- update shale with bivalve to fragmented

DROP PROCEDURE IF EXISTS update_rock_fossil;

DELIMITER //

CREATE  PROCEDURE update_rock_fossil

(
    IN rock_id_param INT,
    IN fossil_id_param INT,
    IN fragmented_param VARCHAR(25)
)
BEGIN
UPDATE  rocks_has_fossils
SET fragmented = fragmented_param
WHERE rock_id = rock_id_param AND fossil_id = fossil_id_param;

END //

CALL update_rock_fossil(15, 5, 1);

-- delete coal with plant fossil

DROP PROCEDURE IF EXISTS delete_rock_fossil;

DELIMITER //

CREATE  PROCEDURE delete_rock_fossil
(
    IN rock_id_param INT, 
    IN fossil_id_param INT

)
BEGIN
DELETE 
FROM rocks_has_fossil
WHERE rock_id = rock_id_param AND fossil_id = rock_id_param;

END //

CALL delete_rock_fossil(14, 22);

-- retrieve coal with plant to see if deleted

DROP PROCEDURE IF EXISTS retrieve_rock_fossil;

DELIMITER //

CREATE PROCEDURE retrieve_rock_fossil

(
    IN rock_id_param INT, 
    IN fossil_id_param INT

)
BEGIN
SELECT * 
FROM rocks_has_fossil
WHERE rock_id = rock_id_param AND fossil_id = fossil_id_param;

END //

CALL retrieve_rock_fossil(14, 22);

-- rock has texture
-- update granite to porphyritic

DROP PROCEDURE IF EXISTS update_rock_texture;

DELIMITER //

CREATE  PROCEDURE update_rock_texture


(
    IN rock_id_param INT,
    IN text_id_param INT
)
BEGIN
UPDATE  rocks_has_texture
SET text_id = text_id_param
WHERE rock_id = rock_id_param;

END //

CALL update_rock_texture(1, 4);

-- delete all rocks with porphyritic texture

DROP PROCEDURE IF EXISTS delete_rock_texture;

DELIMITER //

CREATE  PROCEDURE delete_rock_texture
(
    IN text_id_param INT

)
BEGIN
DELETE 
FROM rocks_has_texture
WHERE text_id = text_id_param;

END //

CALL delete_rock_texture(4);

-- retrieve granite porphyritic rocks

DROP PROCEDURE IF EXISTS retrieve_rock_texture;

DELIMITER //

CREATE PROCEDURE retrieve_rock_texture

(
	IN rock_id_param INT,
    IN text_id_param INT

)
BEGIN
SELECT * 
FROM rocks_has_texture
WHERE text_id = text_id_param AND rock_id = rock_id_param;

END //

CALL retrieve_rock_texture(10, 4);

-- rocks structures
-- update 

DROP PROCEDURE IF EXISTS update_rock_structure;

DELIMITER //


CREATE  PROCEDURE update_rock_structure

(
    IN rock_id_param INT,
    IN struct_id_param INT
    
)
BEGIN
UPDATE  rocks_has_structures
SET struct_id = struct_id_param
WHERE rock_id = rock_id_param;

END //

CALL update_rock_structure(1, 3);

-- delete rocks with well-sorted structure

DROP PROCEDURE IF EXISTS delete_rock_structure;

DELIMITER //

CREATE  PROCEDURE delete_rock_structure
(
    IN struct_id_param INT

)
BEGIN
DELETE 
FROM rocks_has_structures
WHERE struct_id = struct_id_param;

END //

CALL delete_rock_structure(10);

-- retrieve the one well-sorted rock and see if deleted

DROP PROCEDURE IF EXISTS retrieve_rock_structure;

DELIMITER //

CREATE PROCEDURE retrieve_rock_structure

(
	IN rock_id_param INT,
    IN struct_id_param INT

)
BEGIN
SELECT * 
FROM rocks_has_structures
WHERE struct_id = struct_id_param AND rock_id = rock_id_param;

END //

CALL retrieve_rock_structure(1, 10);