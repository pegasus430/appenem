-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: appenem
-- ------------------------------------------------------
-- Server version	5.7.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alternatives`
--

DROP TABLE IF EXISTS `alternatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alternatives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` int(10) unsigned NOT NULL,
  `label` varchar(1) NOT NULL,
  `content` text NOT NULL,
  `justification` text NOT NULL,
  `correct` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `label_UNIQUE` (`label`,`question_id`) USING BTREE,
  KEY `fk_alternatives_questions1_idx` (`question_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=170248 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `alternative_id` int(10) unsigned NOT NULL,
  `candidate_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`alternative_id`,`candidate_id`),
  KEY `fk_alternatives_has_candidates_alternatives1_idx` (`alternative_id`) USING BTREE,
  KEY `fk_answers_candidates1_idx` (`candidate_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `short_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exam_id` int(10) unsigned NOT NULL,
  `school_id` int(10) unsigned DEFAULT NULL,
  `city_id` int(10) unsigned DEFAULT NULL,
  `registration` bigint(19) unsigned NOT NULL,
  `presence` enum('missed','present','eliminated') NOT NULL,
  `consistency` enum('validated','overwritten','unpresent','unavailable') NOT NULL DEFAULT 'unavailable',
  `age` tinyint(3) unsigned DEFAULT NULL,
  `nationality` enum('natural','naturalized','foreign','abroad') DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `conclusion` enum('completed','current','future','incomplete') DEFAULT NULL,
  `conclusion_year` smallint(5) unsigned DEFAULT NULL,
  `school_type` enum('public','private','foreign') DEFAULT NULL,
  `conclusion_type` enum('regular','special','youth','professional') DEFAULT NULL,
  `marital_status` enum('single','married','divorced','widower') DEFAULT NULL,
  `color` enum('white','black','brown','yellow','indigene','unkown') DEFAULT NULL,
  `lc_type` enum('english','spanish') DEFAULT NULL,
  `essay_status` enum('ok','nullified','copy','empty','hurt','escape','incorrect','insufficient','disconnected','missed','other') DEFAULT NULL,
  `first_competence_score` decimal(5,1) DEFAULT NULL,
  `second_competence_score` decimal(5,1) DEFAULT NULL,
  `third_competence_score` decimal(5,1) DEFAULT NULL,
  `fourth_competence_score` decimal(5,1) DEFAULT NULL,
  `fifth_competence_score` decimal(5,1) DEFAULT NULL,
  `essay_score` decimal(5,1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `registration_UNIQUE` (`registration`),
  KEY `fk_candidates_schools1_idx` (`school_id`),
  KEY `fk_candidates_exams1_idx` (`exam_id`),
  KEY `fk_candidates_cities1_idx` (`city_id`),
  CONSTRAINT `fk_candidates_cities1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidates_exams1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidates_schools1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=59464486 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state_id` int(10) unsigned NOT NULL,
  `ibge_code` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ibge_code_UNIQUE` (`ibge_code`),
  KEY `fk_cities_states1_idx` (`state_id`),
  CONSTRAINT `fk_cities_states1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9779 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exams` (
  `id` int(10) unsigned NOT NULL,
  `year` smallint(5) unsigned NOT NULL,
  `essay_proposal` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frequencies`
--

DROP TABLE IF EXISTS `frequencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frequencies` (
  `school_id` int(10) unsigned NOT NULL,
  `exam_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  `alternative_id` int(10) unsigned NOT NULL,
  `frequency` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`school_id`,`exam_id`,`question_id`,`alternative_id`),
  KEY `fk_frequencies_exams1_idx` (`exam_id`),
  KEY `fk_frequencies_questions1_idx` (`question_id`),
  KEY `fk_frequencies_alternatives1_idx` (`alternative_id`),
  CONSTRAINT `fk_frequencies_alternatives1` FOREIGN KEY (`alternative_id`) REFERENCES `alternatives` (`id`),
  CONSTRAINT `fk_frequencies_exams1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`),
  CONSTRAINT `fk_frequencies_questions1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  CONSTRAINT `fk_frequencies_schools1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_groups_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_5e78cd340a` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups_schools`
--

DROP TABLE IF EXISTS `groups_schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_schools` (
  `group_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `origins`
--

DROP TABLE IF EXISTS `origins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `origins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `public_key` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_origins_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` int(10) unsigned NOT NULL,
  `exam_id` int(10) unsigned NOT NULL,
  `subject_id` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL,
  `label` char(4) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_questions_exams1_idx` (`exam_id`),
  KEY `fk_questions_skills1_idx` (`skill_id`),
  KEY `fk_questions_subjects1_idx` (`subject_id`),
  CONSTRAINT `fk_questions_exams1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`),
  CONSTRAINT `fk_questions_skills1` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`),
  CONSTRAINT `fk_questions_subjects1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35508 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawdata`
--

DROP TABLE IF EXISTS `rawdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rawdata` (
  `registration` bigint(20) unsigned NOT NULL,
  `year` smallint(5) unsigned NOT NULL,
  `consistency` enum('validated','overwritten','unpresent','unavailable') NOT NULL DEFAULT 'unavailable',
  `resident_city_code` mediumint(8) unsigned DEFAULT NULL,
  `resident_city_name` char(150) DEFAULT NULL,
  `resident_state_code` tinyint(3) unsigned DEFAULT NULL,
  `resident_state_name` char(2) DEFAULT NULL,
  `hospital_unity` tinyint(1) DEFAULT NULL,
  `training` tinyint(1) DEFAULT NULL,
  `school_code` int(10) unsigned DEFAULT NULL,
  `school_city_code` mediumint(8) unsigned DEFAULT NULL,
  `school_city_name` char(150) DEFAULT NULL,
  `school_state_code` tinyint(3) unsigned DEFAULT NULL,
  `school_state_name` char(2) DEFAULT NULL,
  `school_dependency` enum('federal','state','city','private') DEFAULT NULL,
  `school_location` enum('urban','rural') DEFAULT NULL,
  `school_status` enum('active','inactive','extinct') DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `nationality` enum('natural','naturalized','foreign','abroad') DEFAULT NULL,
  `birth_city_code` mediumint(8) unsigned DEFAULT NULL,
  `birth_city_name` char(150) DEFAULT NULL,
  `birth_state_code` tinyint(3) unsigned DEFAULT NULL,
  `birth_state_name` char(2) DEFAULT NULL,
  `conclusion` enum('completed','current','future','incomplete') DEFAULT NULL,
  `conclusion_year` smallint(5) unsigned DEFAULT NULL,
  `school_type` enum('public','private','foreign') DEFAULT NULL,
  `conclusion_type` enum('regular','special','youth','professional') DEFAULT NULL,
  `marital_status` enum('single','married','divorced','widower') DEFAULT NULL,
  `color` enum('white','black','brown','yellow','indigene','unkown') DEFAULT NULL,
  `low_vision` tinyint(1) DEFAULT NULL,
  `blind` tinyint(1) DEFAULT NULL,
  `deaf` tinyint(1) DEFAULT NULL,
  `hearing_deficiency` tinyint(1) DEFAULT NULL,
  `blind_deaf` tinyint(1) DEFAULT NULL,
  `physical_disability` tinyint(1) DEFAULT NULL,
  `mental_disability` tinyint(1) DEFAULT NULL,
  `attention_deficit` tinyint(1) DEFAULT NULL,
  `dyslexia` tinyint(1) DEFAULT NULL,
  `pregnancy` tinyint(1) DEFAULT NULL,
  `lactating` tinyint(1) DEFAULT NULL,
  `elderly` tinyint(1) DEFAULT NULL,
  `dyscalculia` tinyint(1) DEFAULT NULL,
  `autism` tinyint(1) DEFAULT NULL,
  `monocular_vision` tinyint(1) DEFAULT NULL,
  `sabbatista` tinyint(1) DEFAULT NULL,
  `other_deficiency` tinyint(1) DEFAULT NULL,
  `resource` tinyint(1) DEFAULT NULL,
  `social_name` tinyint(1) DEFAULT NULL,
  `braille` tinyint(1) DEFAULT NULL,
  `enlarged_big` tinyint(1) DEFAULT NULL,
  `enlarged_medium` tinyint(1) DEFAULT NULL,
  `reader` tinyint(1) DEFAULT NULL,
  `easy_access` tinyint(1) DEFAULT NULL,
  `transcription` tinyint(1) DEFAULT NULL,
  `hand_talk` tinyint(1) DEFAULT NULL,
  `lip_reading` tinyint(1) DEFAULT NULL,
  `wheelchair` tinyint(1) DEFAULT NULL,
  `separated_chair` tinyint(1) DEFAULT NULL,
  `leg_support` tinyint(1) DEFAULT NULL,
  `interpret_guide` tinyint(1) DEFAULT NULL,
  `litter` tinyint(1) DEFAULT NULL,
  `computer` tinyint(1) DEFAULT NULL,
  `special_chair` tinyint(1) DEFAULT NULL,
  `left_handed_chair` tinyint(1) DEFAULT NULL,
  `padded_chair` tinyint(1) DEFAULT NULL,
  `lying` tinyint(1) DEFAULT NULL,
  `obese_furniture` tinyint(1) DEFAULT NULL,
  `overlay_blade` tinyint(1) DEFAULT NULL,
  `hearing_protector` tinyint(1) DEFAULT NULL,
  `glucose_meter` tinyint(1) DEFAULT NULL,
  `braille_machine` tinyint(1) DEFAULT NULL,
  `soroban` tinyint(1) DEFAULT NULL,
  `pacemaker` tinyint(1) DEFAULT NULL,
  `probe` tinyint(1) DEFAULT NULL,
  `medicine` tinyint(1) DEFAULT NULL,
  `individual_room` tinyint(1) DEFAULT NULL,
  `special_room` tinyint(1) DEFAULT NULL,
  `companion_room` tinyint(1) DEFAULT NULL,
  `specific_forniture` tinyint(1) DEFAULT NULL,
  `specific_material` tinyint(1) DEFAULT NULL,
  `other_necessity` tinyint(1) DEFAULT NULL,
  `prison_unity` tinyint(1) DEFAULT NULL,
  `certification` tinyint(1) DEFAULT NULL,
  `certifier_name` char(150) DEFAULT NULL,
  `certifier_state_code` tinyint(3) unsigned DEFAULT NULL,
  `certifier_state_name` char(2) DEFAULT NULL,
  `test_city_code` mediumint(8) unsigned DEFAULT NULL,
  `test_city_name` char(150) DEFAULT NULL,
  `test_state_code` tinyint(3) unsigned DEFAULT NULL,
  `test_state_name` char(2) DEFAULT NULL,
  `cn_presence` enum('missed','present','eliminated') DEFAULT NULL,
  `ch_presence` enum('missed','present','eliminated') DEFAULT NULL,
  `lc_presence` enum('missed','present','eliminated') DEFAULT NULL,
  `mt_presence` enum('missed','present','eliminated') DEFAULT NULL,
  `cn_test_code` smallint(5) unsigned DEFAULT NULL,
  `ch_test_code` smallint(5) unsigned DEFAULT NULL,
  `lc_test_code` smallint(5) unsigned DEFAULT NULL,
  `mt_test_code` smallint(5) unsigned DEFAULT NULL,
  `cn_score` decimal(5,1) DEFAULT NULL,
  `ch_score` decimal(5,1) DEFAULT NULL,
  `lc_score` decimal(5,1) DEFAULT NULL,
  `mt_score` decimal(5,1) DEFAULT NULL,
  `cn_answers` char(45) DEFAULT NULL,
  `ch_answers` char(45) DEFAULT NULL,
  `lc_answers` char(45) DEFAULT NULL,
  `mt_answers` char(45) DEFAULT NULL,
  `lc_type` enum('english','spanish') DEFAULT NULL,
  `cn_key` char(45) DEFAULT NULL,
  `ch_key` char(45) DEFAULT NULL,
  `lc_key` char(45) DEFAULT NULL,
  `mt_key` char(45) DEFAULT NULL,
  `essay_status` enum('ok','nullified','copy','empty','hurt','escape','incorrect','insufficient','disconnected','missed','other') DEFAULT NULL,
  `first_competence_score` decimal(5,1) DEFAULT NULL,
  `second_competence_score` decimal(5,1) DEFAULT NULL,
  `third_competence_score` decimal(5,1) DEFAULT NULL,
  `fourth_competence_score` decimal(5,1) DEFAULT NULL,
  `fifth_competence_score` decimal(5,1) DEFAULT NULL,
  `essay_score` decimal(5,1) DEFAULT NULL,
  PRIMARY KEY (`registration`),
  KEY `cn_test_code_index1` (`cn_test_code`) USING BTREE,
  KEY `ch_test_code_index1` (`ch_test_code`),
  KEY `lc_test_code_index1` (`lc_test_code`,`lc_type`),
  KEY `mt_test_code_index1` (`mt_test_code`),
  KEY `school_code_index1` (`school_code`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `school_summary`
--

DROP TABLE IF EXISTS `school_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_summary` (
  `school_id` int(10) unsigned DEFAULT NULL,
  `exam_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schools`
--

DROP TABLE IF EXISTS `schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schools` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `city_id` int(10) unsigned NOT NULL,
  `inep_code` int(10) unsigned NOT NULL,
  `inep_name` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `dependency` enum('federal','state','city','private') NOT NULL,
  `location` enum('urban','rural') NOT NULL,
  `status` enum('active','inactive','extinct') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inep_code_UNIQUE` (`inep_code`),
  KEY `fk_schools_cities1_idx` (`city_id`),
  CONSTRAINT `fk_schools_cities1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=78645 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schools_users`
--

DROP TABLE IF EXISTS `schools_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schools_users` (
  `school_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  KEY `index_schools_users_on_school_id_and_user_id` (`school_id`,`user_id`),
  KEY `index_schools_users_on_user_id_and_school_id` (`user_id`,`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scores` (
  `area_id` int(10) unsigned NOT NULL,
  `candidate_id` int(10) unsigned NOT NULL,
  `presence` enum('missed','present','eliminated') NOT NULL,
  `score` decimal(5,1) DEFAULT NULL,
  PRIMARY KEY (`area_id`,`candidate_id`),
  KEY `fk_areas_has_candidate_areas1_idx` (`area_id`),
  KEY `fk_statuses_candidates1_idx` (`candidate_id`),
  CONSTRAINT `fk_areas_has_candidate_areas1` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_statuses_candidates1` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skills` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `area_id` int(10) unsigned NOT NULL,
  `label` char(4) NOT NULL,
  `description` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `fk_skills_areas1_idx` (`area_id`),
  CONSTRAINT `fk_skills_areas1` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ibge_code` int(10) unsigned NOT NULL,
  `acronym` char(2) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ibge_code_UNIQUE` (`ibge_code`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `area_id` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subjects_areas1_idx` (`area_id`),
  CONSTRAINT `fk_subjects_areas1` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `summaries`
--

DROP TABLE IF EXISTS `summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summaries` (
  `school_id` int(10) unsigned NOT NULL,
  `exam_id` int(10) unsigned NOT NULL,
  `ch_score` decimal(5,1) NOT NULL,
  `cn_score` decimal(5,1) NOT NULL,
  `lc_score` decimal(5,1) NOT NULL,
  `mt_score` decimal(5,1) NOT NULL,
  `general_score` decimal(5,1) NOT NULL,
  `city_ranking` int(11) NOT NULL DEFAULT '0',
  `state_ranking` int(11) NOT NULL DEFAULT '0',
  `country_ranking` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`school_id`,`exam_id`),
  KEY `fk_summaries_exams1_idx` (`exam_id`),
  CONSTRAINT `fk_summaries_exams1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`),
  CONSTRAINT `fk_summaries_schools1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggings`
--

DROP TABLE IF EXISTS `taggings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggings` (
  `tag_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`tag_id`,`question_id`),
  KEY `fk_questions_has_tags_tags1_idx` (`tag_id`),
  KEY `fk_questions_has_tags_questions1_idx` (`question_id`),
  CONSTRAINT `fk_questions_has_tags_questions1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  CONSTRAINT `fk_questions_has_tags_tags1` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5982 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(255) NOT NULL DEFAULT 'email',
  `uid` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tokens` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `origin_id` int(11) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `full_access` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_users_on_origin_id_and_email` (`origin_id`,`email`),
  UNIQUE KEY `index_users_on_uid_and_provider_and_origin_id` (`uid`,`provider`,`origin_id`),
  KEY `index_users_on_origin_id` (`origin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'appenem'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-31 12:39:14
INSERT INTO `schema_migrations` (version) VALUES
('20170717183309'),
('20170719162611'),
('20170719164900'),
('20170720162119'),
('20170720172357'),
('20170724150026'),
('20170731153719');


