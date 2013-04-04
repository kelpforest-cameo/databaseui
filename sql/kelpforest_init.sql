
DROP TABLE IF EXISTS `authors`;
CREATE TABLE IF NOT EXISTS `authors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `first_name` varchar(128) NOT NULL COMMENT 'author''s first name',
  `last_name` varchar(128) NOT NULL COMMENT 'author''s second name',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`first_name`,`last_name`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `author_cite`;
CREATE TABLE IF NOT EXISTS `author_cite` (
  `author_id` int(10) unsigned NOT NULL COMMENT 'foreign key into author table',
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`author_id`,`cite_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `citations`;
CREATE TABLE IF NOT EXISTS `citations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `title` varchar(255) NOT NULL COMMENT 'title of article',
  `document` varchar(255) DEFAULT NULL COMMENT 'link to document either on the hard drive or on the interwebs',
  `year` int(10) unsigned NOT NULL COMMENT 'year published',
  `abstract` text COMMENT 'short abstract from the article',
  `format` enum('Journal','Book','Book Section','Report','Thesis','Web Site','Other') NOT NULL DEFAULT 'Journal' COMMENT 'how was the citation published?',
  `format_title` varchar(255) DEFAULT NULL COMMENT 'name or title of journal, book, book section, etc',
  `publisher` varchar(255) DEFAULT NULL COMMENT 'publisher info',
  `number` int(10) unsigned DEFAULT NULL,
  `volume` int(10) DEFAULT NULL COMMENT 'volume num ber of journal',
  `pages` varchar(64) DEFAULT NULL COMMENT 'pages',

  `closed` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'setting this to 1 (true) will indicate that all citable variables from this publication have been entered cleanly and completely into the DB.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY ( `title`, `format`, `year`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `competition_interactions`;
CREATE TABLE IF NOT EXISTS `competition_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `competition_interaction_observation`;
CREATE TABLE IF NOT EXISTS `competition_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `competition_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into competition_interaction table',
  `location_id` int(10) unsigned DEFAULT NULL COMMENT 'foreign key into location table',
  `observation_type` enum('field observation','laboratory observation','chemical','gut','inferred','expert opinion','fishery','nest contents','scat','forensic') DEFAULT NULL,
  `competition_type` enum('space','interference') DEFAULT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
 
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`competition_interaction_id`, `location_id`, `observation_type`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `facilitation_interactions`;
CREATE TABLE IF NOT EXISTS `facilitation_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `facilitation_interaction_observation`;
CREATE TABLE IF NOT EXISTS `facilitation_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `facilitation_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into facilitation_interaction table',
  `location_id` int(10) unsigned DEFAULT NULL COMMENT 'foreign key into location table',
  `observation_type` enum('field observation','laboratory observation','chemical','gut','inferred','expert opinion','fishery','nest contents','scat','forensic') DEFAULT NULL,
  `facilitation_type` enum('habitat','mutualism','comensualism') DEFAULT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
 
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`facilitation_interaction_id`, `location_id`, `observation_type`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `functional_groups`;
CREATE TABLE IF NOT EXISTS `functional_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `name` varchar(255) NOT NULL COMMENT 'name of group',
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM ;


INSERT INTO `functional_groups` (`id`, `name`) VALUES
(1, 'piscivorous fishes (sharks, rays)'),
(2, 'mammals (pinnipend, otters)'),
(3, 'birds'),
(4, 'octopi'),
(5, 'predatory seastars'),
(6, 'carnivorous molluscs'),
(7, 'decapods (lobster, crabs, shrimp)'),
(8, 'carnivorous fishes'),
(9, 'detritivorous cucumbers'),
(10, 'detritivorous annelids'),
(11, 'abalones'),
(12, 'sea urchins'),
(13, 'herbivorous molluscs'),
(14, 'herbivorous crustaceans (e.g. isopods)'),
(15, 'herbivorous fishes'),
(16, 'planktivorous fishes'),
(17, 'brittle stars'),
(18, 'sessile invertebrates'),
(19, 'kelp'),
(20, 'brown macroalgae other'),
(21, 'red macroalgae'),
(22, 'crustose corallines'),
(23, 'other macroalgae'),
(24, 'zooplankton'),
(25, 'phytoplankton'),
(26, 'phytodetritus'),
(27, 'heterotrophic detritus'),
(28, 'non-living substrate');


DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `name` varchar(255) NOT NULL COMMENT 'name of the location (Western Pacific, Aleutians, Northern Alaska, etc)',
  `description` text COMMENT 'extra field for optional description if the short name is not descriptive enough',
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM ;


INSERT INTO `locations` (`id`, `name`, `description`) VALUES
(1, '0. Undefined/Not provided.', NULL),
(2, '1. Eastern Bering Sea (North of Aleutian archipelago)', NULL),
(3, '2. Aleutian archipelago (West of Unimak Pass)', NULL),
(4, '3. Gulf of Alaska (Unimak Pass to Dixon Entrance)', NULL),
(5, '      3.1. Alaska Peninsula: Unimak Pass to Cook Inlet (Cape Douglas) incl. Kodiak Isl.', NULL),
(6, '      3.2. Central Gulf of Alaska: Cook Inlet to Yakutat Bay (Ocean Cape)', NULL),
(7, '      3.3. Southeast Gulf of Alaska: Yakutat Bay to Dixon Entrance (=Alaska/Canada border)', NULL),
(8, '4. Southeast Alaska/Canada (Dixon Entrance to Cape Flattery)', NULL),
(9, '      4.1. Puget Sound/Georgia Basin', NULL),
(10, '5. Pacific Northwest (Cape Flattery to San Francisco Bay)', NULL),
(11, '      5.1. Pacific Northwest - North: Cape Flattery to Cape Blanco', NULL),
(12, '      5.2. Pacific Northwest - Central: Cape Blanco to Cape Mendocino', NULL),
(13, '      5.3. Pacific Northwest - South: Cape Mendocino to San Francisco Bay', NULL),
(14, '6. Central California (San Francisco Bay to Pt. Conception)', NULL),
(15, '      6.1. Central California - North: San Francisco Bay to Monterey Bay', NULL),
(16, '      6.2. Central California - Central: Monterey Bay to Pt. Buchon', NULL),
(17, '      6.3. Central California - South: Pt. Buchon to Pt. Conception', NULL),
(18, '7. Channel Islands', NULL),
(19, '      7.1. Channel Isl. West: San Miguel, Santa Rosa, San Nicolas, Santa Cruz West', NULL),
(20, '      7.2. Channel Isl. Central: Santa Cruz East, Santa Barbara, Anacapa', NULL),
(21, '      7.3. Channel Isl. East: Santa Catalina, San Clemente', NULL),
(22, '8. Southern California (Pt. Conception to Punta Baja)', NULL),
(23, '      8.1. Southern California - North: Pt. Conception to Santa Monica Bay', NULL),
(24, '      8.2. Southern California - South: Santa Monica Bay to Punta Baja', NULL),
(25, '9. Baja (Punta Baja to Cabo San Lucas)', NULL),
(26, '      9.1. Baja North: Punta Baja to Bahia Asuncion', NULL),
(27, '      9.2. Baja Central: Bahia Asuncion to Magdalena Bay', NULL),
(28, '      9.3. Baja South: Magdalena Bay to Cabo San Lucas', NULL),
(29, 'Other - Not on West Coast of North America', NULL);



DROP TABLE IF EXISTS `nodes`;
CREATE TABLE IF NOT EXISTS `nodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `itis_id` int(10) NOT NULL COMMENT 'foreign key into an external database known as ITIS, hosted by the US government.  ITIS has a unique id for every known and recoreded species, genus, family etc.  When we point to ITIS, we also know the taxanomic level.  To get the ITIS information, we us',
  `non_itis_id` int(10) NOT NULL COMMENT 'if we are working with a species or genus that is not in the ITIS database, we need to account for it ourselves.  This is  foreign key into the non_itis table. We cannot set null on it, so values <0 will mean null.',
  `working_name` varchar(255) NOT NULL COMMENT 'working name that we use to study this node.  This can be different than the traditional latin name or ITIS official name.   This needs to be fixed among scientists who use different working names for the same node.',
  `functional_group_id` int(10) unsigned NOT NULL COMMENT 'functional group classification.   foreign key into functional group table.',
  `native_status` enum('native','non-native', 'unknown') NOT NULL COMMENT 'native, non-native (introduced, invasive, or non-endemic), or unknown',
  `is_assemblage` int(1) NOT NULL COMMENT 'if it is an assemblage, then we will have NO itis_id and NO non-itis_id. it will just have a working name.  (eg. photoplankton)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`working_name`,`itis_id`,`non_itis_id`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS `node_max_age`;
CREATE TABLE IF NOT EXISTS `node_max_age` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
  `max_age` double NOT NULL COMMENT 'maximum age for this node (species, genus, or further up the tax tree)',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`node_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `node_range`;
DROP TABLE IF EXISTS `node_range_old`;
CREATE TABLE IF NOT EXISTS `node_range` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
  `location_n_id` int(10) NOT NULL COMMENT 'northern-most location',
  `location_s_id` int(10) NOT NULL COMMENT 'southern-most location',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`node_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `non_itis`;
CREATE TABLE IF NOT EXISTS `non_itis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `parent_id` int(10) unsigned NOT NULL,
  `latin_name` varchar(255) NOT NULL COMMENT 'latin name',
  `taxonomy_level` enum('kingdom','phylum','class','order','family','genus','species') NOT NULL COMMENT 'name of stage',
  `parent_id_is_itis` tinyint(1) NOT NULL COMMENT 'if parent id is from ITIS db, we can get info there',
  `info` text,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`parent_id`,`latin_name`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `parasitic_interactions`;
CREATE TABLE IF NOT EXISTS `parasitic_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `parasitic_interaction_observation`;
CREATE TABLE IF NOT EXISTS `parasitic_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `parasitic_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into parasitic_interaction table',
  `location_id` int(10) unsigned DEFAULT NULL COMMENT 'foreign key into location table',
  `endo_ecto` enum('endo','ecto') DEFAULT NULL,
  `lethality` enum('benign','lethal') DEFAULT NULL,
  `prevalence` double DEFAULT NULL COMMENT "Prevalence - % of hosts infected.",
  `intensity` double DEFAULT NULL COMMENT "Intensity - #parasites/host",
  `parasite_type` enum('pathogen','castrator','parasitoid','trophically transmitted larva') DEFAULT NULL,
  `observation_type` enum('field observation','laboratory observation','chemical','gut','inferred','expert opinion','fishery','nest contents','scat','forensic') DEFAULT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`parasitic_interaction_id`, `location_id`, `observation_type`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stages`;
CREATE TABLE IF NOT EXISTS `stages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `name` enum('general','adult','juvenile','larval','egg','sporophyte','gametophyte', 'dead') NOT NULL COMMENT 'name of stage',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`node_id`,`name`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS `node_reproductive_strategy`;
DROP TABLE IF EXISTS `stage_reproductive_strategy`;
CREATE TABLE IF NOT EXISTS `stage_reproductive_strategy` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `reproductive_strategy` enum('broadcast','brooder','parental care') NOT NULL COMMENT 'what is the reproductive strategy of this node',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_biomass_change`;
CREATE TABLE IF NOT EXISTS `stage_biomass_change` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `biomass_change` double NOT NULL COMMENT 'tones per km ^2',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_biomass_density`;
CREATE TABLE IF NOT EXISTS `stage_biomass_density` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `biomass_density` double NOT NULL COMMENT 'tons per km^2',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_consumer_strategy`;
CREATE TABLE IF NOT EXISTS `stage_consumer_strategy` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `consumer_strategy` enum('autotroph','grazer','filterfeeder','passive sit','active cursorial','detritivore','scavenger') DEFAULT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_consum_biomass_ratio`;
CREATE TABLE IF NOT EXISTS `stage_consum_biomass_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `consum_biomass_ratio` double NOT NULL COMMENT 'tones per km^2 per year',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS `stage_drymass`;
CREATE TABLE IF NOT EXISTS `stage_drymass` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `drymass` double NOT NULL COMMENT 'drymass in grams',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_duration`;
CREATE TABLE IF NOT EXISTS `stage_duration` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `duration` double NOT NULL COMMENT 'days',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_fecundity`;
CREATE TABLE IF NOT EXISTS `stage_fecundity` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `fecundity` varchar(255) NOT NULL COMMENT 'how much does it reproduce at this stage. value is not yet determined...need to ask the ecologists.',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_habitat`;
CREATE TABLE IF NOT EXISTS `stage_habitat` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `habitat` enum('rocky subst.','soft bottom','water column','pelagic') NOT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS `stage_population`;
CREATE TABLE IF NOT EXISTS `stage_population` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `population` double NOT NULL COMMENT 'percentage of population',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS `stage_length`;
CREATE TABLE IF NOT EXISTS `stage_length` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length` double NOT NULL COMMENT 'length in millimeters (mm)',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_length_fecundity`;
CREATE TABLE IF NOT EXISTS `stage_length_fecundity` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length_fecundity` enum('none exists - constant fecundity','power law F=a*L^b','exponential F=a*exp^(b*L)','linear F=a+b*L') NOT NULL DEFAULT 'none exists - constant fecundity',
  `a` double DEFAULT NULL COMMENT 'variable a',
  `b` double DEFAULT NULL COMMENT 'variable b',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_length_weight`;
CREATE TABLE IF NOT EXISTS `stage_length_weight` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length_weight` enum('none exists - constant weight','power law W=a*L^b','exponential W=a*exp^(b*L)','linear W=a+b*L') NOT NULL DEFAULT 'none exists - constant weight',
  `a` double DEFAULT NULL COMMENT 'variable a',
  `b` double DEFAULT NULL COMMENT 'variable b',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_lifestyle`;
CREATE TABLE IF NOT EXISTS `stage_lifestyle` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `lifestyle` enum('non-living','free-living','infectious') DEFAULT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_mass`;
CREATE TABLE IF NOT EXISTS `stage_mass` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `mass` double NOT NULL COMMENT 'mass in grams',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_max_depth`;
CREATE TABLE IF NOT EXISTS `stage_max_depth` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `max_depth` double NOT NULL COMMENT 'max depth',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_mobility`;
CREATE TABLE IF NOT EXISTS `stage_mobility` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `mobility` enum('sessile','mobile','drifter') NOT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_prod_biomass_ratio`;
CREATE TABLE IF NOT EXISTS `stage_prod_biomass_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `prod_biomass_ratio` double NOT NULL COMMENT 'tons per km^2 per year',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_prod_consum_ratio`;
CREATE TABLE IF NOT EXISTS `stage_prod_consum_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `prod_consum_ratio` double NOT NULL COMMENT 'percentage, but I do not know how it will be calculated yet.',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_residency`;
CREATE TABLE IF NOT EXISTS `stage_residency` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `residency` enum('resident','migrant') NOT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_residency_time`;
CREATE TABLE IF NOT EXISTS `stage_residency_time` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `residency_time` double NOT NULL COMMENT 'res time',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `stage_unassimilated_consum_ratio`;
CREATE TABLE IF NOT EXISTS `stage_unassimilated_consum_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `unassimilated_consum_ratio` double NOT NULL COMMENT 'percentage',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `trophic_interactions`;
CREATE TABLE IF NOT EXISTS `trophic_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `trophic_interaction_observation`;
CREATE TABLE IF NOT EXISTS `trophic_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `trophic_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
  `location_id` int(10) unsigned DEFAULT NULL COMMENT 'foreign key into location table',
  `lethality` enum('lethal whole','lethal partial','nonlethal partial', 'nonlethal behavioural modification') DEFAULT NULL COMMENT 'for trophic interactions, this observation value records the lethality of the interaction...if the species dies or is injured and dies or is just injured.',
  `structures_consumed` enum('whole organism','flesh','frond') DEFAULT NULL  COMMENT 'there will be about 10 fixed options here.',
  `percentage_consumed` double DEFAULT NULL COMMENT '1->100%  how much of the prey is consumed by the predator',
  `percentage_diet` double DEFAULT NULL COMMENT '1->100%  how much of the predators diet',
  `preference` enum('none','more preferred','less preferred') DEFAULT NULL  COMMENT 'is this a preferred diet of the predator',
  `observation_type` enum('field observation','laboratory observation','chemical','gut','inferred','expert opinion','fishery','nest contents','scat','forensic') DEFAULT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`trophic_interaction_id`, `location_id`, `observation_type`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `email` varchar(128) NOT NULL,
  `password` varchar(64) NOT NULL,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `info` text,
  `can_write` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'is the user able to create entries in the DB?',
  `can_modify_others` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'can the user modify (edit or delete) entries from other users?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) TYPE=MyISAM ;


INSERT INTO `users` (`id`, `email`, `password`, `first_name`, `last_name`, `info`, `can_write`, `can_modify_others`) VALUES
(1, 'august@alien.mur.at', 'hackme', 'August', 'Black', '', 1, 0),
(2, 'kelpforest', 'RC.1ab', 'RC', 'lab', '', 1, 1);

