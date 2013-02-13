

DROP TABLE IF EXISTS `nodes`;
CREATE TABLE IF NOT EXISTS `nodes` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `itis_id` int(10) NOT NULL COMMENT 'foreign key into an external database known as ITIS, hosted by the US government.  ITIS has a unique id for every known and recoreded species, genus, family etc.  When we point to ITIS, we also know the taxanomic level.  To get the ITIS information, we use SOAP. We cannot set null on it and still have it be our primary key, so values <0 will mean null.',
   `non_itis_id` int(10) NOT NULL COMMENT 'if we are working with a species or genus that is not in the ITIS database, we need to account for it ourselves.  This is  foreign key into the non_itis table. We cannot set null on it, so values <0 will mean null.',
   `working_name` varchar(255) NOT NULL COMMENT 'working name that we use to study this node.  This can be different than the traditional latin name or ITIS official name.   This needs to be fixed among scientists who use different working names for the same node.',
   `functional_group_id` int(10) unsigned NOT NULL COMMENT 'functional group classification.   foreign key into functional group table.',
   `is_assemblage` int(1) NOT NULL COMMENT 'if it is an assemblage, then we will have NO itis_id and NO non-itis_id. it will just have a working name.  (eg. photoplankton)',
  PRIMARY KEY (`working_name`, `itis_id`, `non_itis_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `node_reproductive_strategy`;
CREATE TABLE IF NOT EXISTS `node_reproductive_strategy` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
   `reproductive_strategy` enum('broadcast', 'brooder', 'parental care') NOT NULL COMMENT 'what is the reproductive strategy of this node',
  PRIMARY KEY (`cite_id`, `node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `node_max_age`;
CREATE TABLE IF NOT EXISTS `node_max_age` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
   `max_age` double  NOT NULL COMMENT 'maximum age for this node (species, genus, or further up the tax tree)',
  PRIMARY KEY (`cite_id`, `node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `node_range`;
CREATE TABLE IF NOT EXISTS `node_range` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
   `north_south` enum ('north', 'south') NOT NULL COMMENT 'north or south',
   `lat_long` enum ('latitude', 'longitude') NOT NULL COMMENT 'north or south',
   `value` double   NOT NULL COMMENT 'northern longitude range',
  PRIMARY KEY (`cite_id`, `north_south`, `lat_long`, `node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `stages`;
CREATE TABLE IF NOT EXISTS `stages` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `name` enum('general','adult','juvenile','larval','egg','sporophyte','gametophyte') NOT NULL COMMENT 'name of stage',
   `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table',
  PRIMARY KEY (`node_id`, `name` ),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `stage_unassimilated_consum_ratio`;
CREATE TABLE IF NOT EXISTS `stage_unassimilated_consum_ratio` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `unassimilated_consum_ratio` double NOT NULL COMMENT 'percentage',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `stage_ecotrophic_efficiency`;
CREATE TABLE IF NOT EXISTS `stage_ecotrophic_efficiency` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `ecotrophic_efficiency` double NOT NULL COMMENT 'percentage ',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `stage_biomass_accumulation`;
CREATE TABLE IF NOT EXISTS `stage_biomass_accumulation` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `biomass_accumulation` double NOT NULL COMMENT 'tones per km ^2',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_prod_consum_ratio`;
CREATE TABLE IF NOT EXISTS `stage_prod_consum_ratio` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `prod_consum_ratio` double  NOT NULL COMMENT 'percentage, but I do not know how it will be calculated yet.',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_consum_biomass_ratio`;
CREATE TABLE IF NOT EXISTS `stage_consum_biomass_ratio` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `consum_biomass_ratio` double NOT NULL COMMENT 'tones per km^2 per year',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_prod_biomass_ratio`;
CREATE TABLE IF NOT EXISTS `stage_prod_biomass_ratio` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `prod_biomass_ratio` double NOT NULL COMMENT 'tons per km^2 per year',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_biomass`;
CREATE TABLE IF NOT EXISTS `stage_biomass` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `biomass`  double   NOT NULL COMMENT 'tons per km^2',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_fecundity`;
CREATE TABLE IF NOT EXISTS `stage_fecundity` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `fecundity`   varchar(255) NOT NULL COMMENT 'how much does it reproduce at this stage. value is not yet determined...need to ask the ecologists.',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_length_weight`;
CREATE TABLE IF NOT EXISTS `stage_length_weight` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `length_weight_id` int(10) unsigned NOT NULL COMMENT 'foreign key into L-W table',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_lifestyle`;
CREATE TABLE IF NOT EXISTS `stage_lifestyle` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `lifestyle` enum  ('non-living', 'free-living', 'infectious'),
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_consumer_strategy`;
CREATE TABLE IF NOT EXISTS `stage_consumer_strategy` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `consumer_strategy` enum ('autotroph', 'grazer', 'filterfeeder', 'passive sit', 'active cursorial', 'detritivore', 'scavenger'),
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_habitat`;
CREATE TABLE IF NOT EXISTS `stage_habitat` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `habitat` enum ('rocky subst.', 'soft bottom', 'water column', 'pelagic') NOT NULL ,
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_residency`;
CREATE TABLE IF NOT EXISTS `stage_residency` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `residency` enum ('resident', 'migrant') NOT NULL,
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_mobility`;
CREATE TABLE IF NOT EXISTS `stage_mobility` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `mobility` enum ('sessile', 'mobile', 'drifter') NOT NULL,
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `stage_duration`;
CREATE TABLE IF NOT EXISTS `stage_duration` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `duration` double NOT NULL COMMENT 'days',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `stage_drymass`;
CREATE TABLE IF NOT EXISTS `stage_drymass` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `drymass` double NOT NULL COMMENT 'drymass in grams',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `stage_mass`;
CREATE TABLE IF NOT EXISTS `stage_mass` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `mass` double NOT NULL COMMENT 'mass in grams',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stage_length`;
CREATE TABLE IF NOT EXISTS `stage_length` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
   `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
   `length` double NOT NULL COMMENT 'length in millimeters (mm)',
  PRIMARY KEY (`cite_id`, `stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `non_itis`;
CREATE TABLE IF NOT EXISTS `non_itis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `parent_id` int(10) unsigned NOT NULL,
  `latin_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'latin name',
  `taxonomy_level` enum('kingdom', 'phylum', 'class', 'order', 'family', 'genus', 'species') NOT NULL COMMENT 'name of stage',
  `parent_id_is_itis` tinyint(1) NOT NULL COMMENT 'if parent id is from ITIS db, we can get info there',
  PRIMARY KEY (`parent_id`, `latin_name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `functional_groups`;
CREATE TABLE IF NOT EXISTS `functional_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'name of group',
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

INSERT into functional_groups (name) VALUES ("group 1"), ("group 2"),("group 3"),("group 4");

DROP TABLE IF EXISTS `trophic_interactions`;
CREATE TABLE IF NOT EXISTS `trophic_interactions` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
   `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  PRIMARY KEY (`stage_1_id`, `stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `trophic_interaction_observation`;
CREATE TABLE IF NOT EXISTS `trophic_interaction_observation` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
   `trophic_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
   `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
   `lethality` enum('lethal whole', 'lethal partial', 'nonlethal partial') NOT NULL COMMENT 'for trophic interactions, this observation value records the lethality of the interaction...if the species dies or is injured and dies or is just injured.',
   `structures_consumed` enum('one','two') NOT NULL COMMENT 'there will be about 10 fixed options here.',
   `percentage_consumed` double NOT NULL COMMENT '1->100%  how much of the prey is consumed by the predator',
   `preference` enum ('more preferred', 'no preference', 'less preferred') NOT NULL COMMENT 'is this a preferred diet of the predator',
   `observation_type` enum ('visual', 'gut', 'scat', 'isotope', 'inferred', 'expert opinion') NOT NULL COMMENT 'type of observation',
  PRIMARY KEY ( `cite_id`, `trophic_interaction_id` )
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;


DROP TABLE IF EXISTS `parasitic_interactions`;
CREATE TABLE IF NOT EXISTS `parasitic_interactions` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
   `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  PRIMARY KEY (`stage_1_id`, `stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `parasitic_interaction_observation`;
CREATE TABLE IF NOT EXISTS `parasitic_interaction_observation` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
   `parasitic_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
   `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
   `endo_ecto` enum ('endo', 'ecto') NOT NULL ,
   `lethality` enum ('benign', 'lethal') NOT NULL ,
   `observation_type` enum ('visual', 'gut', 'scat', 'isotope', 'inferred', 'expert opinion') NOT NULL,
  PRIMARY KEY (`cite_id`, `parasitic_interaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `facilitation_interactions`;
CREATE TABLE IF NOT EXISTS `facilitation_interactions` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
   `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  PRIMARY KEY (`stage_1_id`, `stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `facilitation_interaction_observation`;
CREATE TABLE IF NOT EXISTS `facilitation_interaction_observation` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
   `facilitation_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
   `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
   `observation_type` enum ('visual', 'gut', 'scat', 'isotope', 'inferred', 'expert opinion') NOT NULL,
   `facilitation_type` enum  ('habitat', 'mutualism', 'comensualism') NOT NULL ,
  PRIMARY KEY (`cite_id`, `facilitation_interaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `competition_interactions`;
CREATE TABLE IF NOT EXISTS `competition_interactions` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
   `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  PRIMARY KEY (`stage_1_id`, `stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `competition_interaction_observation`;
CREATE TABLE IF NOT EXISTS `competition_interaction_observation` (
   `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
   `competition_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
   `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
   `observation_type` enum ('visual', 'gut', 'scat', 'isotope', 'inferred', 'expert opinion') NOT NULL,
   `competition_type` enum  ('space', 'interference') NOT NULL ,
  PRIMARY KEY (`cite_id`, `competition_interaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `name` varchar(255) NOT NULL COMMENT 'name of the location (Western Pacific, Aleutians, Northern Alaska, etc)',
   `description` text COMMENT 'extra field for optional description if the short name is not descriptive enough',
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT into locations (name) VALUES ("Western Ontario"), ("Central California"),("Alaska"),("Arctic");

DROP TABLE IF EXISTS `length_weight`;
CREATE TABLE IF NOT EXISTS `length_weight` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `equation_type` enum ('power law', 'linear', 'exponential') NOT NULL,
   `param_a`       double   NOT NULL,
   `param_b`       double   NOT NULL,
	PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `authors`;
CREATE TABLE IF NOT EXISTS `authors` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `first_name` varchar(128) NOT NULL  COMMENT 'author\'s first name',
   `last_name`  varchar(128) NOT NULL  COMMENT 'author\'s second name',
	PRIMARY KEY (`first_name`, `last_name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `author_cite`;
CREATE TABLE IF NOT EXISTS `author_cite` (
  `author_id` int(10) unsigned NOT NULL COMMENT 'foreign key into author table',
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table',
	PRIMARY KEY (`author_id`, `cite_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `citations`;
CREATE TABLE IF NOT EXISTS `citations` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `title` varchar(255) NOT NULL  COMMENT 'title of article',
   `document`  varchar(255) NOT NULL  COMMENT 'link to document either on the hard drive or on the interwebs',
   `year` int(10) unsigned  NOT NULL COMMENT 'year published',
   `abstract` text COMMENT 'short abstract from the article',
   `number` int(10) unsigned NOT NULL  COMMENT '',
   `pages` int(10) unsigned NOT NULL COMMENT 'pages',
   `journal`  varchar(255) NOT NULL COMMENT 'name of journal',
   `volume`   varchar(255) NOT NULL COMMENT 'name of the published volume',
	PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `citations_link`;


