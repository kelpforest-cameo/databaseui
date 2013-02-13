

DROP TABLE IF EXISTS `nodes`;
CREATE TABLE IF NOT EXISTS `nodes` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `itis_id` int(10) unsigned NOT NULL COMMENT 'foreign key into an external database known as ITIS, hosted by the US government.  ITIS has a unique id for every known and recoreded species, genus, family etc.  When we point to ITIS, we also know the taxanomic level.  To get the ITIS information, we use SOAP.',
   `non_itis_id` int(10) unsigned NOT NULL COMMENT 'if we are working with a species or genus that is not in the ITIS database, we need to account for it ourselves.  This is  foreign key into the non_itis table.',
   `working_name` varchar(255) NOT NULL COMMENT 'working name that we use to study this node.  This can be different than the traditional latin name or ITIS official name.   This needs to be fixed among scientists who use different working names for the same node.',
   `functional_group_id` int(10) unsigned NOT NULL COMMENT 'functional group classification.   foreign key into functional group table.',
   `is_assemblage` int(1) NOT NULL COMMENT 'if it is an assemblage, then we will have NO itis_id and NO non-itis_id. it will just have a working name.  (eg. photoplankton)',
   `range_north_lat` double NOT NULL COMMENT 'northern latitude range',
   `range_north_long` double   NOT NULL COMMENT 'northern longitude range',
   `range_south_lat` double  NOT NULL COMMENT 'southern lattitude range',
   `range_south_long` double NOT NULL COMMENT 'southern longitude range',
   `max_age` double  NOT NULL COMMENT 'maximum age for this node (species, genus, or further up the tax tree)',
   `reproductive_strategy` enum('broadcast', 'brooder', 'parental care') NOT NULL COMMENT 'what is the reproductive strategy of this node',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `stages`;
CREATE TABLE IF NOT EXISTS `stages` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `name` enum('general','adult','juvenile','larval','egg','sporophyte','gametophyte') NOT NULL COMMENT 'name of stage',
   `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table',
   `length` double NOT NULL COMMENT 'length in millimeters (mm)',
   `mass` double NOT NULL COMMENT 'mass in grams',
   `drymass` double NOT NULL COMMENT 'drymass in grams',
   `durations` double NOT NULL COMMENT 'days',
   `mobility` enum ('sessile', 'mobile', 'drifter') NOT NULL,
   `residency` enum ('resident', 'migrant') NOT NULL,
   `habitat` enum ('rocky subst.', 'soft bottom', 'water column', 'pelagic') NOT NULL ,
   `consumer_strategy` enum ('autotroph', 'grazer', 'filterfeeder', 'passive sit', 'active cursorial', 'detritivore', 'scavenger'),
   `lifestyle` enum  ('non-living', 'free-living', 'infectious'),
   `length_weight_id` int(10) unsigned NOT NULL COMMENT 'foreign key into L-W table',
   `fecundity`   varchar(255) NOT NULL COMMENT 'how much does it reproduce at this stage. value is not yet determined...need to ask the ecologists.',
   `biomass`  double   NOT NULL COMMENT 'tons per km^2',
   `prod_biomass_ratio` double NOT NULL COMMENT 'tons per km^2 per year',
   `consum_biomass_ratio` double NOT NULL COMMENT 'tones per km^2 per year',
   `ecotrophic_efficiency` double NOT NULL COMMENT 'percentage ',
   `prod_consum_ratio` double  NOT NULL COMMENT 'percentage, but I do not know how it will be calculated yet.',
   `biomass_accumulation` double NOT NULL COMMENT 'tones per km ^2',
   `unassimilated_consum_ratio` double NOT NULL COMMENT 'percentage',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `non_itis`;
CREATE TABLE IF NOT EXISTS `non_itis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `parent_id` int(10) unsigned NOT NULL,
  `latin_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'latin name',
  `taxonomy_level` enum('kingdom', 'phylum', 'class', 'order', 'family', 'genus', 'species') NOT NULL COMMENT 'name of stage',
  `parent_id_is_itis` tinyint(1) NOT NULL COMMENT 'if parent id is from ITIS db, we can get info there',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `functional_group`;
CREATE TABLE IF NOT EXISTS `functional_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'name of group',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


DROP TABLE IF EXISTS `trophic_interactions`;
CREATE TABLE IF NOT EXISTS `trophic_interactions` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
   `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
   `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
   `lethality` enum('lethal whole', 'lethal partial', 'nonlethal partial') NOT NULL COMMENT 'for trophic interactions, this observation value records the lethality of the interaction...if the species dies or is injured and dies or is just injured.',
   `structures_consumed` enum('one','two') NOT NULL COMMENT 'there will be about 10 fixed options here.',
   `percentage_consumed` double NOT NULL COMMENT '1->100%  how much of the prey is consumed by the predator',
   `preference`  enum ('more preferred', 'no preference', 'less preferred') NOT NULL COMMENT 'is this a preferred diet of the predator',
   `observation_type` enum ('visual', 'gut', 'scat', 'isotope', 'inferred', 'expert opinion') NOT NULL COMMENT 'type of observation',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `parasitic_interactions`;
CREATE TABLE IF NOT EXISTS `parasitic_interactions` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
   `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
   `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
   `endo_ecto` enum ('endo', 'ecto') NOT NULL ,
   `lethality` enum ('benign', 'lethal') NOT NULL ,
   `observation_type` enum ('visual', 'gut', 'scat', 'isotope', 'inferred', 'expert opinion') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `facilitation_interactions`;
CREATE TABLE IF NOT EXISTS `facilitation_interactions` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
   `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
   `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
   `observation_type` enum ('visual', 'gut', 'scat', 'isotope', 'inferred', 'expert opinion') NOT NULL,
   `type` enum  ('habitat', 'mutualism', 'comensualism') NOT NULL ,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;



DROP TABLE IF EXISTS `competition_interactions`;
CREATE TABLE IF NOT EXISTS `competition_interactions` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
   `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
   `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
   `observation_type` enum ('visual', 'gut', 'scat', 'isotope', 'inferred', 'expert opinion') NOT NULL,
   `type` enum  ('space', 'interference') NOT NULL ,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
   `name` varchar(255) NOT NULL COMMENT 'name of the location (Western Pacific, Aleutians, Northern Alaska, etc)',
   `description` text COMMENT 'extra field for optional description if the short name is not descriptive enough',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


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
   `first_name` varchar(255) NOT NULL  COMMENT 'author\'s first name',
   `last_name`  varchar(255) NOT NULL  COMMENT 'author\'s second name',
	PRIMARY KEY (`id`),
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
CREATE TABLE IF NOT EXISTS `citations_link` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table',
  `table_id` int(10) unsigned NOT NULL COMMENT 'foreign key into unknown table',
   `table_name`  varchar(128) NOT NULL  COMMENT 'name of foreign table',
   `field_name`  varchar(128) NOT NULL  COMMENT 'name of foreign field',
	PRIMARY KEY (`cite_id`, `table_id`,`table_name`,`field_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


