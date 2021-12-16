-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rocks
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rocks
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rocks` DEFAULT CHARACTER SET utf8 ;
USE `rocks` ;

-- -----------------------------------------------------
-- Table `rocks`.`Mineral`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`Mineral` ;

CREATE TABLE IF NOT EXISTS `rocks`.`Mineral` (
  `min_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `colors` VARCHAR(80) NOT NULL,
  `special_prop` VARCHAR(45) NULL,
	`hardness` INT(2) NOT NULL,
  `luster` VARCHAR(45) NOT NULL,
  `streak` VARCHAR(45) NOT NULL,
	`cleavage or fracture` VARCHAR(45) NULL, 
    `composition` VARCHAR(45) NOT NULL, 
  PRIMARY KEY (`min_id`),
  UNIQUE INDEX `min_id_UNIQUE` (`min_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`location` ;

CREATE TABLE IF NOT EXISTS `rocks`.`location` (
  `loc_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `area_type` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`loc_id` ASC) VISIBLE,
  PRIMARY KEY (`loc_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rocks`.`rocks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`rocks` ;

CREATE TABLE IF NOT EXISTS `rocks`.`rocks` (
  `rock_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type` ENUM("Sedimentary", "Metamorphic", "Igneous") NOT NULL,
  `sed_type` ENUM("Biochemical", "Clastic", "Organic", "Chemical") NULL,
  `loc_id` INT UNSIGNED NOT NULL,
  `min_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`rock_id`),
  UNIQUE INDEX `id_UNIQUE` (`rock_id` ASC) VISIBLE,
  INDEX `fk_rocks_location1_idx` (`loc_id` ASC) VISIBLE,
  INDEX `fk_rocks_Mineral1_idx` (`min_id` ASC) VISIBLE,
  CONSTRAINT `fk_rocks_location1`
    FOREIGN KEY (`loc_id`)
    REFERENCES `rocks`.`location` (`loc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rocks_Mineral1`
    FOREIGN KEY (`min_id`)
    REFERENCES `rocks`.`Mineral` (`min_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rocks`.`fossil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`fossil` ;

CREATE TABLE IF NOT EXISTS `rocks`.`fossil` (
  `fossil_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `class` VARCHAR(45) NOT NULL,
  `genus` VARCHAR(45) NULL,
  `species` VARCHAR(45) NULL,
  PRIMARY KEY (`fossil_id`),
  UNIQUE INDEX `id_UNIQUE` (`fossil_id` ASC) VISIBLE,
  UNIQUE INDEX `species_UNIQUE` (`species` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rocks`.`structures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`structures` ;

CREATE TABLE IF NOT EXISTS `rocks`.`structures` (
  `struct_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`struct_id`),
  UNIQUE INDEX `struct_id_UNIQUE` (`struct_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rocks`.`texture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`texture` ;

CREATE TABLE IF NOT EXISTS `rocks`.`texture` (
  `text_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`text_id` ASC) VISIBLE,
  PRIMARY KEY (`text_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rocks`.`rocks_has_fossil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`rocks_has_fossil` ;

CREATE TABLE IF NOT EXISTS `rocks`.`rocks_has_fossil` (
  `rock_id` INT NOT NULL,
  `fossil_id` INT UNSIGNED NOT NULL,
  `fragmented` TINYINT(1) NOT NULL,
  PRIMARY KEY (`rock_id`, `fossil_id`),
  INDEX `fk_rocks_has_fossil_fossil1_idx` (`fossil_id` ASC) VISIBLE,
  INDEX `fk_rocks_has_fossil_rocks_idx` (`rock_id` ASC) VISIBLE,
  CONSTRAINT `fk_rocks_has_fossil_rocks`
    FOREIGN KEY (`rock_id`)
    REFERENCES `rocks`.`rocks` (`rock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rocks_has_fossil_fossil1`
    FOREIGN KEY (`fossil_id`)
    REFERENCES `rocks`.`fossil` (`fossil_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rocks`.`rocks_has_texture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`rocks_has_texture` ;

CREATE TABLE IF NOT EXISTS `rocks`.`rocks_has_texture` (
  `rock_id` INT NOT NULL,
  `text_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`rock_id`, `text_id`),
  INDEX `fk_rocks_has_texture_texture1_idx` (`text_id` ASC) VISIBLE,
  INDEX `fk_rocks_has_texture_rocks1_idx` (`rock_id` ASC) VISIBLE,
  CONSTRAINT `fk_rocks_has_texture_rocks1`
    FOREIGN KEY (`rock_id`)
    REFERENCES `rocks`.`rocks` (`rock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rocks_has_texture_texture1`
    FOREIGN KEY (`text_id`)
    REFERENCES `rocks`.`texture` (`text_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rocks`.`rocks_has_structures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rocks`.`rocks_has_structures` ;

CREATE TABLE IF NOT EXISTS `rocks`.`rocks_has_structures` (
  `rock_id` INT NOT NULL,
  `struct_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`rock_id`, `struct_id`),
  INDEX `fk_rocks_has_structures_rocks1_idx` (`rock_id` ASC) VISIBLE,
  INDEX `fk_rocks_has_structures_structures1_idx` (`struct_id` ASC) VISIBLE,
  CONSTRAINT `fk_rocks_has_structures_rocks1`
    FOREIGN KEY (`rock_id`)
    REFERENCES `rocks`.`rocks` (`rock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rocks_has_structures_structures1`
    FOREIGN KEY (`struct_id`)
    REFERENCES `rocks`.`structures` (`struct_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insert Statements minerals

INSERT INTO mineral VALUES (DEFAULT, "Quartz", "Colorless, Black, Pink, White, Green, Yellow, Purple, Brown, Red", DEFAULT, 7, "Waxy, Resinous", "Colorless", "Conchoidal", "Felsic"); 
SET @quartz = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Plagioclase", "Gray, White, Colorless", "Striations", 6, "Vitreous, Pearly", "Colorless", "2 Cleavage Planes, 90 degrees", "Felsic"); 
SET @plagioclase = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Orthoclase", "Salmon, Pink, Gray, Green, White, Colorless", DEFAULT, 6, "Virtreous, Pearly", "Colorless", "2 Cleavage Planes, 90 degrees", "Felsic, Mafic"); 
SET @orthoclase = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Calcite", "Colorless, White, Gray, Yellow", "Effervesces with HCL", 3, "Pearly", "Colorless", "3 Cleavage Planes, 90 degrees", "Felsic"); 
SET @calcite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Talc", "Gray, White, Green, Brown, Colorless", DEFAULT, 1, "Pearly, Greasy", "Colorless", "1 Cleavage Plane", "Carbonate"); 
SET @talc = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Gypsum", "Gray, White, Colorless", DEFAULT, 2, "Virtreous, Dull", "Colorless", "3 Cleavage Planes", "Sulfate"); 
SET @gypsum = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Muscovite", "Yellow, Silver, Light Brown, Colorless", "Thin, flexible sheets", 2, "Virtreous", "Colorless", "1 Cleavage Plane", "Felsic"); 
SET @muscovite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Biotite", "Black, Brown, Dark Green", "Thin, flexible sheets", 3, "Virtreous", "Gray, Brown", "1 Cleavage Plane", "Mafic"); 
SET @biotite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Halite", "White, Colorless", "Taste", 2.5, "Vitreous, Waxy", "Colorless", "3 Cleavage Planes, not 90 degrees", "Halide"); 
SET @halite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Dolomite", "Gray, Tan, Pink", "Effervesces poorly with HCL", 4, "Virtreous, Pearly, Waxy", "Colorless", "3 Cleavage Planes, not 90 degrees", "Carbonate");
SET @dolomite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Fluorite", "Purple, Colorless, White, Yellow, Green", DEFAULT, 4, "Vitreous", "Colorless", "4 Cleavage Planes", "Halide");  
SET @fluorite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Hornblende", "Black, Dark Green", "Splintery fracture pattern", 5.5, "Vitreous, Resinous", "Colorless", "2 Cleavage Planes, 60 and 120 degrees", "Mafic"); 
SET @hornblende = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Augite", "Black, Dark Green", DEFAULT, 6, "Virtreous, Resinous", "Colorless", "2 Cleavage Planes, 60 and 120 degrees", "Mafic"); 
SET @augite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Garnet", "Red, Brown, Green", "Soccer ball shape", 7, "Virtreous, Resinous", "Colorless", "Conchoidal", "Felsic"); 
SET @garnet = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Olivine", "Green, Yellow-green", DEFAULT, 7, "Virtreous, Resinous", "Colorless", "Conchoidal", "Felsic"); 
SET @olivine = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Chalcedony", "White, Blue, Red, Green, Yellow, Orange, Brown, Pink, Purple, Gray, Black", "Structureless appearance", 7, "Waxy", "Colorless", "Conchoidal", "Felsic"); 
SET @chalcedony = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Graphite", "Black, Gray", "Gray residue", 1, "Metallic, Dull", "Black, Gray", "1 Cleavage Plane", "Carbon"); 
SET @graphite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Sulfur", "Yellow", "Smell", 2, "Resinous, Earthy", "Yellow", "Conchoidal, Blocky", "Sulfur"); 
SET @sulfur = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Galena", "Silver, Gray", "High specific gravity", 2.5, "Metallic, Dull", "Black, Gray", "3 Cleavage Planes, 90 degrees", "Lead, Silver"); 
SET @galena = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Chalcopyrite", "Copper-gold", DEFAULT, 3.5, "Metallic", "Black", "Irregular", "Copper"); 
SET @chalcopyrite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Sphalerite", "Yellow-brown, Red-brown, Black", "Smell", 4, "Resinous, Adamantine", "White, Yellow-brown", "6 Cleavage Planes", "Zinc"); 
SET @sphalerite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Limonite", "Yellow-brown, Brown", DEFAULT, 4.5, "Earthy", "Yellow-brown", "Irregular", "Iron"); 
SET @limonite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Malachite", "Green", "Effervesces with HCL", 3.5, "Earthy", "Earthy", "Irregular", "Copper"); 
SET @malachite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Azurite", "Blue", "Effervesces with HCL", 3.5, "Earthy", "Blue", "Irregular", "Copper"); 
SET @azurite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Magnetite", "Black", "Magnetic", 6, "Metallic, Dull", "Black, Gray", "4 Cleavage Planes", "Iron"); 
SET @magnetite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Earthy Hematite", "Reddish-brown", DEFAULT, 6, "Earthy", "Reddish-brown", "Irregular", "Iron"); 
SET @earthy_hematite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Specular Hematite", "Silver, Black", DEFAULT, 6, "Metallic", "Reddish-brown", "Irregular", "Iron"); 
SET @specular_hematite = last_insert_id();

INSERT INTO mineral VALUES (DEFAULT, "Pyrite", "Yellow-gold", DEFAULT, 6, "Metallic", "Black, Gray", "Irregular", "Iron"); 
SET @pyrite = last_insert_id();

-- textures

INSERT INTO texture VALUES (DEFAULT, "Vesicular");
SET @vesicular = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Pyroclastic");
SET @pyroclastic = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Phaneritic");
SET @phaneritic = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Porphyritic");
SET @porphyritic = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Aphantic");
SET @aphantic = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Glassy");
SET @glassy = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Foliated"); 
SET @foliated = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Crystalline"); 
SET @crystalline = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Fine-grained"); 
SET @fine_grained = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Medium-grained"); 
SET @medium_grained = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Coarse-grained"); 
SET @coarse_grained = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Matrix-supported"); 
SET @matrix = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Clast-supported"); 
SET @clast = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Pebble-sized"); 
SET @pebble = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Cobble-sized"); 
SET @cobble = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Boulder-sized"); 
SET @boulder = last_insert_id();

INSERT INTO texture VALUES (DEFAULT, "Polymictic"); 
SET @polymictic = last_insert_id();

-- structures

INSERT INTO structures VALUES (DEFAULT, "Graded bedding"); 
SET @graded = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Cross bedding");
SET @cross = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Symmetrical ripple marks");
SET @symmetrical = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Asymmetrical ripple marks");
SET @asymmetrical = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Mudcracks");
SET @mudcracks = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Laminations");
SET @laminations = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Burrows");
SET @burrows = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Intraclasts");
SET @intraclasts = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Ooids");
SET @ooids = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Well-sorted");
SET @well_sorted = last_insert_id();

INSERT INTO structures VALUES (DEFAULT, "Poorly-Sorted");
SET @poorly_sorted = last_insert_id();

-- location

INSERT INTO location VALUES (DEFAULT, "Deep Ocean Basin"); 
SET @ocean_basin = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Lagoon");
SET @lagoon = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Tidal Flat"); 
SET @tidal_flat = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Alluvial Fan"); 
SET @alluvial = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Reef"); 
SET @reef = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Beach"); 
SET @beach = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Delta"); 
SET @delta = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Playa Lake"); 
SET @playa = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Desert"); 
SET @desert = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Lake Basin");
SET @lake = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "River");  
SET @river = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Glacier"); 
SET @glacier = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Swamp"); 
SET @swamp = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Shallow Marine"); 
SET @shallow_marine = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Mountain Range"); 
SET @mountain = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Volcano"); 
SET @volcano = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Lava Flow"); 
SET @flow = last_insert_id();

INSERT INTO location VALUES (DEFAULT, "Mid-Oceanic Ridge"); 
SET @mor = last_insert_id();

-- fossils

INSERT INTO fossil VALUES (DEFAULT, "Porifera", DEFAULT, DEFAULT); 
SET @porifera = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Cnidarian", DEFAULT, DEFAULT); 
SET @cnidarian = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Mollusk", "Monoplacophoran", DEFAULT); 
SET @monoplacophoran = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Mollusk", "Gastropod", DEFAULT); 
SET @gastropod = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Mollusk", "Bivalve", DEFAULT); 
SET @bivalve = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Mollusk", "Cephalopod", "Ammonoid"); 
SET @ammonoid = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Mollusk", "Cephalopod", "Nautiloid");
SET @nautiloid = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Mollusk", "Cephalopod", "Belemnoid");
SET @belemnoid = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Arthropod", "Trilobite", DEFAULT);
SET @trilobite = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Arthropod", "Crustacean", DEFAULT);
SET @crustacean = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Arthropod", "Insect", DEFAULT);
SET @insect = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Lophophorate", "Byrozoan", DEFAULT);
SET @byrozoan = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Lophophorate", "Brachiopod", "Inarticulate");
SET @inarticulate = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Lophophorate", "Brachiopod", "Articulate");
SET @articulate = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Enchinoderm", "Asteroid", DEFAULT);
SET @asteroid = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Enchinoderm", "Blastoid", DEFAULT);
SET @blastoid = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Enchinoderm", "Crinoid", DEFAULT);
SET @crinoid = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Enchinoderm", "Echinoid", DEFAULT);
SET @echinoid = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Enchinoderm", "Ophiuroid", DEFAULT);
SET @ophiuroid = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Graptolite", DEFAULT, DEFAULT);
SET @graptolite = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Chordate", DEFAULT, DEFAULT);
SET @chordate = last_insert_id();

INSERT INTO fossil VALUES (DEFAULT, "Plant", DEFAULT, DEFAULT);
SET @plant = last_insert_id();


-- igneous rocks

INSERT INTO rocks VALUES (DEFAULT, "Granite", "Igneous", DEFAULT, "1", "15"); 
SET @granite = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Gabbro","Igneous", DEFAULT, "2", "17"); 
SET @gabbro = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Peridotite", "Igneous", DEFAULT, "15", "18"); 
SET @peridotite = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Rhyolite", "Igneous", DEFAULT, "1", "16"); 
SET @rhyolite = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Andesite", "Igneous", DEFAULT, "2", "17"); 
SET @andesite = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Basalt", "Igneous", DEFAULT, "2", "18"); 
SET @basalt = last_insert_id();

-- metamorphic rocks

INSERT INTO rocks VALUES (DEFAULT, "Slate", "Metamorphic", DEFAULT, "1", "15"); 
SET @slate = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Schist", "Metamorphic", DEFAULT, "7", "15"); 
SET @schist = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Gneiss", "Metamorphic", DEFAULT, "8", "15"); 
SET @gneiss = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Marble", "Metamorphic", DEFAULT, "4", "15"); 
SET @marble = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Quartzite", "Metamorphic", DEFAULT, "1", "15"); 
SET @quartzite = last_insert_id();

-- sedimentary rocks 

INSERT INTO rocks VALUES (DEFAULT, "Quartz Arenite", "Sedimentary", "Clastic", "1", "6"); 
SET @quartz_arenite = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Halite", "Sedimentary", "Chemical", "9", "8"); 
SET @halite = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Coal", "Sedimentary", "Organic", "28", "14");
SET @coal = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Shale", "Sedimentary", "Clastic", "1", "1");
SET @shale = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Siltstone", "Sedimentary", "Clastic", "7", "14");
SET @siltstone = last_insert_id();

INSERT INTO rocks VALUES (DEFAULT, "Packstone", "Sedimentary", "Biochemical", "4", "2");
SET @packstone = last_insert_id();

-- rocks fossils

INSERT INTO rocks_has_fossil VALUES(@quartz_arenite, @trilobite, 1); 

INSERT INTO rocks_has_fossil VALUES(@coal, @plant, 0); 

INSERT INTO rocks_has_fossil VALUES(@shale, @bivalve , 0);

INSERT INTO rocks_has_fossil VALUES(@packstone, @echinoid, 0);

INSERT INTO rocks_has_fossil VALUES(@packstone, @crinoid, 1);

-- rocks structures

INSERT INTO rocks_has_structures VALUES(@quartz_arenite, @graded); 

INSERT INTO rocks_has_structures VALUES(@quartz_arenite, @cross);

INSERT INTO rocks_has_structures VALUES(@quartz_arenite, @well_sorted); 

INSERT INTO rocks_has_structures VALUES(@shale, @burrows); 

INSERT INTO rocks_has_structures VALUES(@siltstone, @laminations); 

INSERT INTO rocks_has_structures VALUES(@packstone, @intraclasts); 

INSERT INTO rocks_has_structures VALUES(@packstone, @ooids); 

-- rocks textures

INSERT INTO rocks_has_texture VALUES(@granite, @porphyritic);

INSERT INTO rocks_has_texture VALUES(@granite, @phaneritic);

INSERT INTO rocks_has_texture VALUES(@gabbro, @porphyritic);

INSERT INTO rocks_has_texture VALUES(@gabbro, @phaneritic);

INSERT INTO rocks_has_texture VALUES(@peridotite, @phaneritic);

INSERT INTO rocks_has_texture VALUES(@rhyolite, @vesicular);

INSERT INTO rocks_has_texture VALUES(@rhyolite, @aphantic);

INSERT INTO rocks_has_texture VALUES(@andesite, @aphantic);

INSERT INTO rocks_has_texture VALUES(@andesite, @porphyritic);

INSERT INTO rocks_has_texture VALUES(@basalt, @vesicular);

INSERT INTO rocks_has_texture VALUES(@basalt, @aphantic);

INSERT INTO rocks_has_texture VALUES(@basalt, @porphyritic);

INSERT INTO rocks_has_texture VALUES(@slate, @foliated);

INSERT INTO rocks_has_texture VALUES(@schist, @foliated);

INSERT INTO rocks_has_texture VALUES(@gneiss, @foliated);

INSERT INTO rocks_has_texture VALUES(@marble, @non_foliated);

INSERT INTO rocks_has_texture VALUES(@quartzite, @non_foliated);

INSERT INTO rocks_has_texture VALUES(@quartz_arenite, @fine_grained);

INSERT INTO rocks_has_texture VALUES(@quartz_arenite, @coarse_grained);

INSERT INTO rocks_has_texture VALUES(@siltstone, @fine_grained);

INSERT INTO rocks_has_texture VALUES(@shale, @fine_grained);

INSERT INTO rocks_has_texture VALUES(@coal, @crystalline);

INSERT INTO rocks_has_texture VALUES(@halite, @crystalline);









