-- Food-web interactions database dump (structure)
-- Host: localhost:8889

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


--
-- Database: `kelpforest`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `first_name` varchar(128) NOT NULL COMMENT 'author''s first name',
  `last_name` varchar(128) NOT NULL COMMENT 'author''s second name',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`first_name`,`last_name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `author_cite`
--

CREATE TABLE `author_cite` (
  `author_id` int(10) unsigned NOT NULL COMMENT 'foreign key into author table',
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`author_id`,`cite_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `citations`
--

CREATE TABLE `citations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `title` varchar(255) NOT NULL COMMENT 'title of article',
  `document` varchar(255) DEFAULT NULL COMMENT 'link to document either on the hard drive or on the interwebs',
  `year` int(10) unsigned NOT NULL COMMENT 'year published',
  `abstract` text COMMENT 'short abstract from the article',
  `format` enum('Journal','Book','Book Section','Report','Thesis','Web Site','Other','Personal Observation','Unpublished Data') NOT NULL DEFAULT 'Journal' COMMENT 'how was the citation published?',
  `format_title` varchar(255) DEFAULT NULL COMMENT 'name or title of journal, book, book section, etc',
  `publisher` varchar(255) DEFAULT NULL COMMENT 'publisher info',
  `number` int(10) unsigned DEFAULT NULL,
  `volume` int(10) DEFAULT NULL COMMENT 'volume num ber of journal',
  `pages` varchar(64) DEFAULT NULL COMMENT 'pages',
  `closed` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'setting this to 1 (true) will indicate that all citable variables from this publication have been entered cleanly and completely into the DB.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`title`,`format`,`year`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `competition_interactions`
--

CREATE TABLE `competition_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `competition_interaction_observation`
--

CREATE TABLE `competition_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `competition_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into competition_interaction table',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'foreign key into location table',
  `observation_type` enum('field observation','laboratory observation','chemical','gut','inferred','expert opinion','fishery','nest contents','scat','forensic') NOT NULL DEFAULT 'field observation',
  `competition_type` enum('space','interference') DEFAULT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`competition_interaction_id`,`location_id`,`observation_type`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilitation_interactions`
--

CREATE TABLE `facilitation_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilitation_interaction_observation`
--

CREATE TABLE `facilitation_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `facilitation_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into facilitation_interaction table',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'foreign key into location table',
  `observation_type` enum('field observation','laboratory observation','chemical','gut','inferred','expert opinion','fishery','nest contents','scat','forensic') NOT NULL DEFAULT 'field observation',
  `facilitation_type` enum('habitat','mutualism','comensualism') DEFAULT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`facilitation_interaction_id`,`location_id`,`observation_type`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `functional_groups`
--

CREATE TABLE `functional_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `name` varchar(255) NOT NULL COMMENT 'name of group',
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `region` geometry DEFAULT NULL,
  `centroid` geometry DEFAULT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `parent` int(11) NOT NULL,
  `active` tinyint(4) DEFAULT '1',
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  `zoom_min` int(11) NOT NULL DEFAULT '-1',
  `zoom_max` int(11) NOT NULL DEFAULT '15',
  `z_index` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `name` (`name`,`lft`,`rgt`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `location_data`
--

CREATE TABLE `location_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `sdata` geometry DEFAULT NULL,
  `datum` varchar(255) NOT NULL DEFAULT '',
  `comment` text,
  `refcount` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `location_id_2` (`location_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nodes`
--

CREATE TABLE `nodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `itis_id` int(10) NOT NULL COMMENT 'foreign key into an external database known as ITIS, hosted by the US government.  ITIS has a unique id for every known and recoreded species, genus, family etc.  When we point to ITIS, we also know the taxanomic level.  To get the ITIS information, we us',
  `non_itis_id` int(10) NOT NULL COMMENT 'if we are working with a species or genus that is not in the ITIS database, we need to account for it ourselves.  This is  foreign key into the non_itis table. We cannot set null on it, so values <0 will mean null.',
  `working_name` varchar(255) NOT NULL COMMENT 'working name that we use to study this node.  This can be different than the traditional latin name or ITIS official name.   This needs to be fixed among scientists who use different working names for the same node.',
  `functional_group_id` int(10) unsigned NOT NULL COMMENT 'functional group classification.   foreign key into functional group table.',
  `native_status` enum('native','non-native','unknown') NOT NULL COMMENT 'native, non-native (introduced, invasive, or non-endemic), or unknown',
  `is_assemblage` int(1) NOT NULL COMMENT 'if it is an assemblage, then we will have NO itis_id and NO non-itis_id. it will just have a working name.  (eg. photoplankton)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`working_name`,`itis_id`,`non_itis_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `node_geo_range`
--

CREATE TABLE `node_geo_range` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
  `geo_range` varchar(255) NOT NULL COMMENT 'comma-separated list of location ids (HACK HACK HACK)',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`node_id`,`geo_range`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `node_max_age`
--

CREATE TABLE `node_max_age` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table.',
  `max_age` double NOT NULL COMMENT 'maximum age for this node (species, genus, or further up the tax tree)',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`node_id`,`max_age`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `non_itis`
--

CREATE TABLE `non_itis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique id',
  `parent_id` int(10) unsigned NOT NULL,
  `latin_name` varchar(255) NOT NULL COMMENT 'latin name',
  `taxonomy_level` enum('kingdom','phylum','class','order','family','genus','species') NOT NULL COMMENT 'name of stage',
  `parent_id_is_itis` tinyint(1) NOT NULL COMMENT 'if parent id is from ITIS db, we can get info there',
  `info` text,
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`parent_id`,`latin_name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `parasitic_interactions`
--

CREATE TABLE `parasitic_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `parasitic_interaction_observation`
--

CREATE TABLE `parasitic_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `parasitic_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into parasitic_interaction table',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'foreign key into location table',
  `endo_ecto` enum('endo','ecto') DEFAULT NULL,
  `lethality` enum('benign','lethal') DEFAULT NULL,
  `prevalence` double DEFAULT NULL COMMENT 'Prevalence - % of hosts infected.',
  `intensity` double DEFAULT NULL COMMENT 'Intensity - #parasites/host',
  `parasite_type` enum('pathogen','castrator','parasitoid','trophically transmitted larva') DEFAULT NULL,
  `observation_type` enum('field observation','laboratory observation','chemical','gut','inferred','expert opinion','fishery','nest contents','scat','forensic') NOT NULL DEFAULT 'field observation',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`parasitic_interaction_id`,`location_id`,`observation_type`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stages`
--

CREATE TABLE `stages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `name` enum('general','adult','juvenile','larval','egg','sporophyte','gametophyte','dead') NOT NULL COMMENT 'name of stage',
  `node_id` int(10) unsigned NOT NULL COMMENT 'foreign key into node table',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`node_id`,`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_biomass_change`
--

CREATE TABLE `stage_biomass_change` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `biomass_change` double NOT NULL COMMENT 'tones per km ^2',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`biomass_change`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_biomass_density`
--

CREATE TABLE `stage_biomass_density` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `biomass_density` double NOT NULL COMMENT 'tons per km^2',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`biomass_density`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_consumer_strategy`
--

CREATE TABLE `stage_consumer_strategy` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `consumer_strategy` enum('autotroph','grazer','filterfeeder','passive sit','active cursorial','detritivore','scavenger') NOT NULL DEFAULT 'autotroph',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`consumer_strategy`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_consum_biomass_ratio`
--

CREATE TABLE `stage_consum_biomass_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `consum_biomass_ratio` double NOT NULL COMMENT 'tones per km^2 per year',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`consum_biomass_ratio`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_drymass`
--

CREATE TABLE `stage_drymass` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `drymass` double NOT NULL COMMENT 'drymass in grams',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`drymass`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_duration`
--

CREATE TABLE `stage_duration` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `duration` double NOT NULL COMMENT 'days',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`duration`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_fecundity`
--

CREATE TABLE `stage_fecundity` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `fecundity` varchar(255) NOT NULL COMMENT 'how much does it reproduce at this stage. value is not yet determined...need to ask the ecologists.',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`fecundity`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_habitat`
--

CREATE TABLE `stage_habitat` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `habitat` enum('rocky subst.','soft bottom','water column','pelagic') NOT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`habitat`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_length`
--

CREATE TABLE `stage_length` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length` double NOT NULL COMMENT 'length in millimeters (mm)',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`length`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_length_fecundity`
--

CREATE TABLE `stage_length_fecundity` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length_fecundity` enum('none exists - constant fecundity','power law F=a*L^b','exponential F=a*exp^(b*L)','linear F=a+b*L') NOT NULL DEFAULT 'none exists - constant fecundity',
  `a` double NOT NULL DEFAULT '0' COMMENT 'variable a',
  `b` double NOT NULL DEFAULT '0' COMMENT 'variable b',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`length_fecundity`,`a`,`b`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_length_weight`
--

CREATE TABLE `stage_length_weight` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `length_weight` enum('none exists - constant weight','power law W=a*L^b','exponential W=a*exp^(b*L)','linear W=a+b*L') NOT NULL DEFAULT 'none exists - constant weight',
  `a` double NOT NULL DEFAULT '0' COMMENT 'variable a',
  `b` double NOT NULL DEFAULT '0' COMMENT 'variable b',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`length_weight`,`a`,`b`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_lifestyle`
--

CREATE TABLE `stage_lifestyle` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `lifestyle` enum('non-living','free-living','infectious') NOT NULL DEFAULT 'non-living',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`lifestyle`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_mass`
--

CREATE TABLE `stage_mass` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `mass` double NOT NULL COMMENT 'mass in grams',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`mass`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_max_depth`
--

CREATE TABLE `stage_max_depth` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `max_depth` double NOT NULL COMMENT 'max depth',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`max_depth`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_mobility`
--

CREATE TABLE `stage_mobility` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `mobility` enum('sessile','mobile','drifter') NOT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`mobility`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_population`
--

CREATE TABLE `stage_population` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `population` double NOT NULL COMMENT 'percentage of population',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`population`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_prod_biomass_ratio`
--

CREATE TABLE `stage_prod_biomass_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `prod_biomass_ratio` double NOT NULL COMMENT 'tons per km^2 per year',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`prod_biomass_ratio`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_prod_consum_ratio`
--

CREATE TABLE `stage_prod_consum_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `prod_consum_ratio` double NOT NULL COMMENT 'percentage, but I do not know how it will be calculated yet.',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`prod_consum_ratio`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_reproductive_strategy`
--

CREATE TABLE `stage_reproductive_strategy` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `reproductive_strategy` enum('broadcast','brooder','parental care') NOT NULL COMMENT 'what is the reproductive strategy of this node',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`reproductive_strategy`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_residency`
--

CREATE TABLE `stage_residency` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `residency` enum('resident','migrant') NOT NULL,
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`residency`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_residency_time`
--

CREATE TABLE `stage_residency_time` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `residency_time` double NOT NULL COMMENT 'res time',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`residency_time`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stage_unassimilated_consum_ratio`
--

CREATE TABLE `stage_unassimilated_consum_ratio` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'foreign key into citation table.',
  `stage_id` int(10) unsigned NOT NULL COMMENT 'foreign key into stage table.',
  `unassimilated_consum_ratio` double NOT NULL COMMENT 'percentage',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`stage_id`,`unassimilated_consum_ratio`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trophic_interactions`
--

CREATE TABLE `trophic_interactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `stage_1_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_2_id)',
  `stage_2_id` int(10) unsigned NOT NULL COMMENT 'primary key (with stage_1_id)',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`stage_1_id`,`stage_2_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trophic_interaction_observation`
--

CREATE TABLE `trophic_interaction_observation` (
  `cite_id` int(10) unsigned NOT NULL COMMENT 'citation',
  `trophic_interaction_id` int(10) unsigned NOT NULL COMMENT 'foreign key into trophic_interaction table',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'foreign key into location table',
  `lethality` enum('lethal whole','lethal partial','nonlethal partial','nonlethal behavioural modification') DEFAULT NULL COMMENT 'for trophic interactions, this observation value records the lethality of the interaction...if the species dies or is injured and dies or is just injured.',
  `structures_consumed` enum('whole organism','flesh','frond') DEFAULT NULL COMMENT 'there will be about 10 fixed options here.',
  `percentage_consumed` double DEFAULT NULL COMMENT '1->100%  how much of the prey is consumed by the predator',
  `percentage_diet` double DEFAULT NULL COMMENT '1->100%  how much of the predators diet',
  `percentage_diet_by` enum('Volume','Mass','Count') DEFAULT NULL,
  `preference` enum('none','more preferred','less preferred') DEFAULT NULL COMMENT 'is this a preferred diet of the predator',
  `observation_type` enum('field observation','laboratory observation','chemical','gut','inferred','expert opinion','fishery','nest contents','scat','forensic') NOT NULL DEFAULT 'field observation',
  `comment` text COMMENT 'extra field for optional comment on this entry',
  `datum` varchar(255) NOT NULL DEFAULT '' COMMENT 'extra field for optional date(s) on this entry.',
  `owner_id` int(10) unsigned NOT NULL COMMENT 'foreign key into users table, tells us who owns this data',
  PRIMARY KEY (`cite_id`,`trophic_interaction_id`,`location_id`,`observation_type`,`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
