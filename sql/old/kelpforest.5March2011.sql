
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `kelpforest`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
CREATE TABLE IF NOT EXISTS `authors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `first_name` varchar(128) NOT NULL COMMENT 'author''s first name',
  `last_name` varchar(128) NOT NULL COMMENT 'author''s second name',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`first_name`,`last_name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

-- --------------------------------------------------------

--
-- Table structure for table `author_cite`
--

DROP TABLE IF EXISTS `author_cite`;
CREATE TABLE IF NOT EXISTS `author_cite` (
  `author_id` int(10) unsigned NOT NULL COMMENT 'foreign key into author table',
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`author_id`,`cite_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `citations`
--

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
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8  ;

-- --------------------------------------------------------

--
-- Table structure for table `citations_link`
--
 DROP TABLE IF EXISTS `citations_link`;
-- CREATE TABLE IF NOT EXISTS `citations_link` (
--  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table',
--  `table_id` int(10) unsigned NOT NULL COMMENT 'foreign key into unknown table',
--  `table_name` varchar(128) NOT NULL COMMENT 'name of foreign table',
--  `field_name` varchar(128) NOT NULL COMMENT 'name of foreign field',
--  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
--  PRIMARY KEY (`cite_id`,`table_id`,`table_name`,`field_name`)
-- ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `competition_interactions`
--

DROP TABLE IF EXISTS `competition_interactions`;
CREATE TABLE IF NOT EXISTS `competition_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

-- --------------------------------------------------------

--
-- Table structure for table `competition_interaction_observation`
--

DROP TABLE IF EXISTS `competition_interaction_observation`;
CREATE TABLE IF NOT EXISTS `competition_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `competition_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
  `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
  `observation_type` enum('field observation','laboratory observation', 'chemical', 'gut', 'inferred', 'expert opinion', 'fishery', 'nest contents', 'scat','forensic') NOT NULL,
  `competition_type` enum('space','interference') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`competition_interaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `facilitation_interactions`
--

DROP TABLE IF EXISTS `facilitation_interactions`;
CREATE TABLE IF NOT EXISTS `facilitation_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

-- --------------------------------------------------------

--
-- Table structure for table `facilitation_interaction_observation`
--

DROP TABLE IF EXISTS `facilitation_interaction_observation`;
CREATE TABLE IF NOT EXISTS `facilitation_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `facilitation_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
  `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
  `observation_type` enum('field observation','laboratory observation', 'chemical', 'gut', 'inferred', 'expert opinion', 'fishery', 'nest contents', 'scat','forensic') NOT NULL,
  `facilitation_type` enum('habitat','mutualism','comensualism') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`facilitation_interaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `functional_groups`
--

DROP TABLE IF EXISTS `functional_groups`;
CREATE TABLE IF NOT EXISTS `functional_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `name` varchar(255) NOT NULL COMMENT 'name of group',
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8  ;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `name` varchar(255) NOT NULL COMMENT 'name of the location (Western Pacific, Aleutians, Northern Alaska, etc)',
  `description` text COMMENT 'extra field for optional description if the short name is not descriptive enough',
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8  ;

-- --------------------------------------------------------

--
-- Table structure for table `nodes`
--

DROP TABLE IF EXISTS `nodes`;
CREATE TABLE IF NOT EXISTS `nodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `itis_id` int(10) NOT NULL COMMENT 'foreign key into an external database known as ITIS, hosted by the US government.  ITIS has a unique id for every known and recoreded species, genus, family etc.  When we point to ITIS, we also know the taxanomic level.  To get the ITIS information, we us',
  `non_itis_id` int(10) NOT NULL COMMENT 'if we are working with a species or genus that is not in the ITIS database, we need to account for it ourselves.  This is  foreign key into the non_itis table. We cannot set null on it, so values <0 will mean null.',
  `working_name` varchar(255) NOT NULL COMMENT 'working name that we use to study this node.  This can be different than the traditional latin name or ITIS official name.   This needs to be fixed among scientists who use different working names for the same node.',
  `functional_group_id` int(10) unsigned NOT NULL COMMENT 'functional group classification.   foreign key into functional group table.',
  `native_status` enum('native','non-native') NOT NULL COMMENT 'native or non-native (introduced, invasive, or non-endemic)',
  `is_assemblage` int(1) NOT NULL COMMENT 'if it is an assemblage, then we will have NO itis_id and NO non-itis_id. it will just have a working name.  (eg. photoplankton)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`working_name`,`itis_id`,`non_itis_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

-- --------------------------------------------------------

--
-- Table structure for table `node_max_age`
--

DROP TABLE IF EXISTS `node_max_age`;
CREATE TABLE IF NOT EXISTS `node_max_age` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
  `max_age` double NOT NULL COMMENT 'maximum age for this node (species, genus, or further up the tax tree)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `node_range`
--

DROP TABLE IF EXISTS `node_range`;
CREATE TABLE IF NOT EXISTS `node_range` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
  `lat_n` double NULL COMMENT 'northern latitude range' DEFAULT NULL,
  `lat_s` double COMMENT 'southern latitude range' DEFAULT NULL,
  `lng_e` double COMMENT 'eastern longitude range' DEFAULT NULL,
  `lng_w` double COMMENT 'western longitude range' DEFAULT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`, `node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `node_reproductive_strategy`
--

DROP TABLE IF EXISTS `node_reproductive_strategy`;
CREATE TABLE IF NOT EXISTS `node_reproductive_strategy` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
  `reproductive_strategy` enum('broadcast','brooder','parental care') NOT NULL COMMENT 'what is the reproductive strategy of this node',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `non_itis`
--

DROP TABLE IF EXISTS `non_itis`;
CREATE TABLE IF NOT EXISTS `non_itis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `parent_id` int(10) unsigned NOT NULL,
  `latin_name` varchar(255) NOT NULL COMMENT 'latin name',
  `taxonomy_level` enum('kingdom','phylum','class','order','family','genus','species') NOT NULL COMMENT 'name of stage',
  `parent_id_is_itis` tinyint(1) NOT NULL COMMENT 'if parent id is from ITIS db, we can get info there',
  `info` text CHARACTER SET utf8 NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`parent_id`,`latin_name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

-- --------------------------------------------------------

--
-- Table structure for table `parasitic_interactions`
--

DROP TABLE IF EXISTS `parasitic_interactions`;
CREATE TABLE IF NOT EXISTS `parasitic_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

-- --------------------------------------------------------

--
-- Table structure for table `parasitic_interaction_observation`
--

DROP TABLE IF EXISTS `parasitic_interaction_observation`;
CREATE TABLE IF NOT EXISTS `parasitic_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `parasitic_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
  `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
  `endo_ecto` enum('endo','ecto') NOT NULL,
  `lethality` enum('benign','lethal') NOT NULL,
  `prevalence` enum('prevalence', 'intensity') NOT NULL,
  `parasite_type` enum('pathogen','castrator', 'parasitoid', 'trophically transmitted larva') NOT NULL,
  `observation_type` enum('field observation','laboratory observation', 'chemical', 'gut', 'inferred', 'expert opinion', 'fishery', 'nest contents', 'scat','forensic') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`parasitic_interaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stages`
--

DROP TABLE IF EXISTS `stages`;
CREATE TABLE IF NOT EXISTS `stages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `name` enum('general','adult','juvenile','larval','egg','sporophyte','gametophyte') NOT NULL COMMENT 'name of stage',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`node_id`,`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

-- --------------------------------------------------------

--
-- Table structure for table `stage_biomass_change`
--

DROP TABLE IF EXISTS `stage_biomass_change`;
CREATE TABLE IF NOT EXISTS `stage_biomass_change` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `biomass_change` double NOT NULL COMMENT 'tones per km ^2',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_biomass_density`
--

DROP TABLE IF EXISTS `stage_biomass_density`;
CREATE TABLE IF NOT EXISTS `stage_biomass_density` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `biomass_density` double NOT NULL COMMENT 'tons per km^2',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_consumer_strategy`
--

DROP TABLE IF EXISTS `stage_consumer_strategy`;
CREATE TABLE IF NOT EXISTS `stage_consumer_strategy` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `consumer_strategy` enum('autotroph','grazer','filterfeeder','passive sit','active cursorial','detritivore','scavenger') DEFAULT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_consum_biomass_ratio`
--

DROP TABLE IF EXISTS `stage_consum_biomass_ratio`;
CREATE TABLE IF NOT EXISTS `stage_consum_biomass_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `consum_biomass_ratio` double NOT NULL COMMENT 'tones per km^2 per year',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_drymass`
--

DROP TABLE IF EXISTS `stage_drymass`;
CREATE TABLE IF NOT EXISTS `stage_drymass` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `drymass` double NOT NULL COMMENT 'drymass in grams',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_duration`
--

DROP TABLE IF EXISTS `stage_duration`;
CREATE TABLE IF NOT EXISTS `stage_duration` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `duration` double NOT NULL COMMENT 'days',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


--
-- Table structure for table `stage_fecundity`
--

DROP TABLE IF EXISTS `stage_fecundity`;
CREATE TABLE IF NOT EXISTS `stage_fecundity` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `fecundity` varchar(255) NOT NULL COMMENT 'how much does it reproduce at this stage. value is not yet determined...need to ask the ecologists.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_habitat`
--

DROP TABLE IF EXISTS `stage_habitat`;
CREATE TABLE IF NOT EXISTS `stage_habitat` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `habitat` enum('rocky subst.','soft bottom','water column','pelagic') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_length`
--

DROP TABLE IF EXISTS `stage_length`;
CREATE TABLE IF NOT EXISTS `stage_length` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length` double NOT NULL COMMENT 'length in millimeters (mm)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_length_weight`
--

DROP TABLE IF EXISTS `stage_length_weight`;
CREATE TABLE IF NOT EXISTS `stage_length_weight` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length_weight` enum('none exists - constant weight','power law W=a*L^b','exponential W=a*exp^(b*L)','linear W=a+b*L') NOT NULL DEFAULT 'none exists - constant weight',
  `a` double NULL COMMENT 'variable a',
  `b` double NULL COMMENT 'variable b',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_length_fecundity`
--

DROP TABLE IF EXISTS `stage_length_fecundity`;
CREATE TABLE IF NOT EXISTS `stage_length_fecundity` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length_fecundity` enum('none exists - constant fecundity','power law F=a*L^b','exponential F=a*exp^(b*L)','linear F=a+b*L') NOT NULL DEFAULT 'none exists - constant fecundity',
  `a` double NULL COMMENT 'variable a',
  `b` double NULL COMMENT 'variable b',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `stage_lifestyle`
--

DROP TABLE IF EXISTS `stage_lifestyle`;
CREATE TABLE IF NOT EXISTS `stage_lifestyle` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `lifestyle` enum('non-living','free-living','infectious') DEFAULT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Table structure for table `stage_residency_time`
--

DROP TABLE IF EXISTS `stage_residency_time`;
CREATE TABLE IF NOT EXISTS `stage_residency_time` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `residency_time` double NOT NULL COMMENT 'res time',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


--
-- Table structure for table `stage_max_depth`
--

DROP TABLE IF EXISTS `stage_max_depth`;
CREATE TABLE IF NOT EXISTS `stage_max_depth` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `max_depth` double NOT NULL COMMENT 'max depth',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_mass`
--

DROP TABLE IF EXISTS `stage_mass`;
CREATE TABLE IF NOT EXISTS `stage_mass` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `mass` double NOT NULL COMMENT 'mass in grams',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_mobility`
--

DROP TABLE IF EXISTS `stage_mobility`;
CREATE TABLE IF NOT EXISTS `stage_mobility` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `mobility` enum('sessile','mobile','drifter') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_prod_biomass_ratio`
--

DROP TABLE IF EXISTS `stage_prod_biomass_ratio`;
CREATE TABLE IF NOT EXISTS `stage_prod_biomass_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `prod_biomass_ratio` double NOT NULL COMMENT 'tons per km^2 per year',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_prod_consum_ratio`
--

DROP TABLE IF EXISTS `stage_prod_consum_ratio`;
CREATE TABLE IF NOT EXISTS `stage_prod_consum_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `prod_consum_ratio` double NOT NULL COMMENT 'percentage, but I do not know how it will be calculated yet.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_residency`
--

DROP TABLE IF EXISTS `stage_residency`;
CREATE TABLE IF NOT EXISTS `stage_residency` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `residency` enum('resident','migrant') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stage_unassimilated_consum_ratio`
--

DROP TABLE IF EXISTS `stage_unassimilated_consum_ratio`;
CREATE TABLE IF NOT EXISTS `stage_unassimilated_consum_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `unassimilated_consum_ratio` double NOT NULL COMMENT 'percentage',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trophic_interactions`
--

DROP TABLE IF EXISTS `trophic_interactions`;
CREATE TABLE IF NOT EXISTS `trophic_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8  ;

-- --------------------------------------------------------

--
-- Table structure for table `trophic_interaction_observation`
--

DROP TABLE IF EXISTS `trophic_interaction_observation`;
CREATE TABLE IF NOT EXISTS `trophic_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `trophic_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
  `location_id` int(10) unsigned NOT NULL COMMENT 'foreign key into location table',
  `lethality` enum('lethal whole','lethal partial','nonlethal partial') NOT NULL COMMENT 'for trophic interactions, this observation value records the lethality of the interaction...if the species dies or is injured and dies or is just injured.',
  `structures_consumed` enum('whole organism','flesh', 'frond') NOT NULL DEFAULT "whole organism" COMMENT  'there will be about 10 fixed options here.',
  `percentage_consumed` double NULL COMMENT '1->100%  how much of the prey is consumed by the predator',
  `preference` enum('none', 'more preferred','less preferred') NOT NULL DEFAULT "none" COMMENT 'is this a preferred diet of the predator',
  `observation_type` enum('field observation','laboratory observation', 'chemical', 'gut', 'inferred', 'expert opinion', 'fishery', 'nest contents', 'scat','forensic') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`trophic_interaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `email` varchar(128) CHARACTER SET utf8 NOT NULL,
  `password` varchar(64) CHARACTER SET utf8 NOT NULL,
  `first_name` varchar(128) CHARACTER SET utf8 NULL,
  `last_name` varchar(128) CHARACTER SET utf8 NULL,
  `info` text CHARACTER SET utf8 NULL,
  `can_write` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'is the user able to create entries in the DB?',
  `can_modify_others` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'can the user modify (edit or delete) entries from other users?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;



INSERT into functional_groups (name) VALUES ("piscivorous fishes (sharks, rays)"), 
("mammals (pinnipend, otters)"),
("birds"),
("octopi"),
("predatory seastars"),
("carnivorous molluscs"),
("decapods (lobster, crabs, shrimp)"),
("carnivorous fishes"),
("detritivorous cucumbers"),
("detritivorous annelids"),
("abalones"),
("sea urchins"),
("herbivorous molluscs"),
("herbivorous crustaceans (e.g. isopods)"),
("herbivorous fishes"),
("planktivorous fishes"),
("brittle stars"),
("sessile invertebrates"),
("kelp"),
("brown macroalgae other"),
("red macroalgae"),
("crustose corallines"),
("other macroalgae"),
("zooplankton"),
("phytoplankton"),
("phytodetritus"),
("heterotrophic detritus"),
("non-living substrate");


INSERT into locations (name) VALUES ("Western Pacific"),
	("Aleutians"),
	("Alaska Peninsula"),
	("Northern Alaska"),
	("Gulf of Alaska"),
	("SE Alaska"),
	("BC"),
	("WA"),
	("OR"),
	("No.CA (N of SFBay)"),
	("CeCA (Pt.Conception-SFBay)"),
	("SoCA mainland"),
	("Channel Islands East (islands: _____)"),
	("Channel Islands West (islands: ______)"),
	("Baja"),
	("Other");

INSERT INTO `users` (`email`, `password`, `first_name`,`last_name`,`info`, `can_write`, `can_modify_others`) VALUES
('august@alien.mur.at', 'hackme', 'August', 'Black', '', 1, 0),
('nowrite', 'hackme', 'Rico', 'Suave', '', 0, 0),
('kelpforest', 'RC.1ab', 'RC', 'lab', '', 1, 1);

