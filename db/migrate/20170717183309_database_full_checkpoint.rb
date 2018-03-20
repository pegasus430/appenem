class DatabaseFullCheckpoint < ActiveRecord::Migration[5.0]
  def up
    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `alternatives` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `question_id` INT(10) UNSIGNED NOT NULL,
        `label` VARCHAR(1) NOT NULL,
        `content` TEXT NOT NULL,
        `justification` TEXT NOT NULL,
        `correct` TINYINT(1) NOT NULL DEFAULT '0',
        PRIMARY KEY (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `label_UNIQUE` USING BTREE ON `alternatives` (`label` ASC, `question_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_alternatives_questions1_idx` USING BTREE ON `alternatives` (`question_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `answers` (
        `alternative_id` INT(10) UNSIGNED NOT NULL,
        `candidate_id` INT(10) UNSIGNED NOT NULL,
        PRIMARY KEY (`alternative_id`, `candidate_id`))
      ENGINE = MyISAM
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `fk_alternatives_has_candidates_alternatives1_idx` USING BTREE ON `answers` (`alternative_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_answers_candidates1_idx` USING BTREE ON `answers` (`candidate_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `areas` (
        `id` INT(10) UNSIGNED NOT NULL,
        `name` VARCHAR(64) NOT NULL,
        `short_name` VARCHAR(64) NOT NULL,
        PRIMARY KEY (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `states` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `ibge_code` INT(10) UNSIGNED NOT NULL,
        `acronym` CHAR(2) NOT NULL,
        `name` VARCHAR(64) NOT NULL,
        PRIMARY KEY (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `ibge_code_UNIQUE` ON `states` (`ibge_code` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `cities` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `state_id` INT(10) UNSIGNED NOT NULL,
        `ibge_code` INT(10) UNSIGNED NOT NULL,
        `name` VARCHAR(128) NOT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_cities_states1`
          FOREIGN KEY (`state_id`)
          REFERENCES `states` (`id`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `ibge_code_UNIQUE` ON `cities` (`ibge_code` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_cities_states1_idx` ON `cities` (`state_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `exams` (
        `id` INT(10) UNSIGNED NOT NULL,
        `year` SMALLINT(5) UNSIGNED NOT NULL,
        `essay_proposal` TEXT NOT NULL,
        PRIMARY KEY (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `schools` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `city_id` INT(10) UNSIGNED NOT NULL,
        `inep_code` INT(10) UNSIGNED NOT NULL,
        `inep_name` VARCHAR(128) NOT NULL,
        `name` VARCHAR(128) NOT NULL,
        `dependency` ENUM('federal', 'state', 'city', 'private') NOT NULL,
        `location` ENUM('urban', 'rural') NOT NULL,
        `status` ENUM('active', 'inactive', 'extinct') NOT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_schools_cities1`
          FOREIGN KEY (`city_id`)
          REFERENCES `cities` (`id`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `inep_code_UNIQUE` ON `schools` (`inep_code` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_schools_cities1_idx` ON `schools` (`city_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `candidates` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `exam_id` INT(10) UNSIGNED NOT NULL,
        `school_id` INT(10) UNSIGNED NULL DEFAULT NULL,
        `city_id` INT(10) UNSIGNED NULL DEFAULT NULL,
        `registration` BIGINT(19) UNSIGNED NOT NULL,
        `presence` ENUM('missed', 'present', 'eliminated') NOT NULL,
        `consistency` ENUM('validated', 'overwritten', 'unpresent', 'unavailable') NOT NULL DEFAULT 'unavailable',
        `age` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
        `nationality` ENUM('natural', 'naturalized', 'foreign', 'abroad') NULL DEFAULT NULL,
        `gender` ENUM('male', 'female') NULL DEFAULT NULL,
        `conclusion` ENUM('completed', 'current', 'future', 'incomplete') NULL DEFAULT NULL,
        `conclusion_year` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
        `school_type` ENUM('public', 'private', 'foreign') NULL DEFAULT NULL,
        `conclusion_type` ENUM('regular', 'special', 'youth', 'professional') NULL DEFAULT NULL,
        `marital_status` ENUM('single', 'married', 'divorced', 'widower') NULL DEFAULT NULL,
        `color` ENUM('white', 'black', 'brown', 'yellow', 'indigene', 'unkown') NULL DEFAULT NULL,
        `lc_type` ENUM('english', 'spanish') NULL DEFAULT NULL,
        `essay_status` ENUM('ok', 'nullified', 'copy', 'empty', 'hurt', 'escape', 'incorrect', 'insufficient', 'disconnected', 'missed', 'other') NULL DEFAULT NULL,
        `first_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `second_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `third_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `fourth_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `fifth_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `essay_score` DECIMAL(5,1) NULL DEFAULT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_candidates_cities1`
          FOREIGN KEY (`city_id`)
          REFERENCES `cities` (`id`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION,
        CONSTRAINT `fk_candidates_exams1`
          FOREIGN KEY (`exam_id`)
          REFERENCES `exams` (`id`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION,
        CONSTRAINT `fk_candidates_schools1`
          FOREIGN KEY (`school_id`)
          REFERENCES `schools` (`id`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `registration_UNIQUE` ON `candidates` (`registration` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_candidates_schools1_idx` ON `candidates` (`school_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_candidates_exams1_idx` ON `candidates` (`exam_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_candidates_cities1_idx` ON `candidates` (`city_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `skills` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `area_id` INT(10) UNSIGNED NOT NULL,
        `label` CHAR(4) NOT NULL,
        `description` VARCHAR(1024) NOT NULL DEFAULT '',
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_skills_areas1`
          FOREIGN KEY (`area_id`)
          REFERENCES `areas` (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `fk_skills_areas1_idx` ON `skills` (`area_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `subjects` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `area_id` INT(10) UNSIGNED NOT NULL,
        `name` VARCHAR(64) NOT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_subjects_areas1`
          FOREIGN KEY (`area_id`)
          REFERENCES `areas` (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `fk_subjects_areas1_idx` ON `subjects` (`area_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `questions` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `skill_id` INT(10) UNSIGNED NOT NULL,
        `exam_id` INT(10) UNSIGNED NOT NULL,
        `subject_id` INT(10) UNSIGNED NOT NULL,
        `position` INT(10) UNSIGNED NOT NULL,
        `label` CHAR(4) NOT NULL,
        `content` TEXT NOT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_questions_exams1`
          FOREIGN KEY (`exam_id`)
          REFERENCES `exams` (`id`),
        CONSTRAINT `fk_questions_skills1`
          FOREIGN KEY (`skill_id`)
          REFERENCES `skills` (`id`),
        CONSTRAINT `fk_questions_subjects1`
          FOREIGN KEY (`subject_id`)
          REFERENCES `subjects` (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `fk_questions_exams1_idx` ON `questions` (`exam_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_questions_skills1_idx` ON `questions` (`skill_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_questions_subjects1_idx` ON `questions` (`subject_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `frequencies` (
        `school_id` INT(10) UNSIGNED NOT NULL,
        `exam_id` INT(10) UNSIGNED NOT NULL,
        `question_id` INT(10) UNSIGNED NOT NULL,
        `alternative_id` INT(10) UNSIGNED NOT NULL,
        `frequency` INT(10) UNSIGNED NOT NULL DEFAULT '0',
        PRIMARY KEY (`school_id`, `exam_id`, `question_id`, `alternative_id`),
        CONSTRAINT `fk_frequencies_alternatives1`
          FOREIGN KEY (`alternative_id`)
          REFERENCES `alternatives` (`id`),
        CONSTRAINT `fk_frequencies_exams1`
          FOREIGN KEY (`exam_id`)
          REFERENCES `exams` (`id`),
        CONSTRAINT `fk_frequencies_questions1`
          FOREIGN KEY (`question_id`)
          REFERENCES `questions` (`id`),
        CONSTRAINT `fk_frequencies_schools1`
          FOREIGN KEY (`school_id`)
          REFERENCES `schools` (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `fk_frequencies_exams1_idx` ON `frequencies` (`exam_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_frequencies_questions1_idx` ON `frequencies` (`question_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_frequencies_alternatives1_idx` ON `frequencies` (`alternative_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `users` (
        `id` INT(11) NOT NULL AUTO_INCREMENT,
        `provider` VARCHAR(255) NOT NULL DEFAULT 'email',
        `uid` VARCHAR(255) NOT NULL DEFAULT '',
        `encrypted_password` VARCHAR(255) NOT NULL DEFAULT '',
        `reset_password_token` VARCHAR(255) NULL DEFAULT NULL,
        `reset_password_sent_at` DATETIME NULL DEFAULT NULL,
        `remember_created_at` DATETIME NULL DEFAULT NULL,
        `sign_in_count` INT(11) NOT NULL DEFAULT '0',
        `current_sign_in_at` DATETIME NULL DEFAULT NULL,
        `last_sign_in_at` DATETIME NULL DEFAULT NULL,
        `current_sign_in_ip` VARCHAR(255) NULL DEFAULT NULL,
        `last_sign_in_ip` VARCHAR(255) NULL DEFAULT NULL,
        `confirmation_token` VARCHAR(255) NULL DEFAULT NULL,
        `confirmed_at` DATETIME NULL DEFAULT NULL,
        `confirmation_sent_at` DATETIME NULL DEFAULT NULL,
        `unconfirmed_email` VARCHAR(255) NULL DEFAULT NULL,
        `name` VARCHAR(255) NULL DEFAULT NULL,
        `email` VARCHAR(255) NULL DEFAULT NULL,
        `tokens` TEXT NULL DEFAULT NULL,
        `created_at` DATETIME NOT NULL,
        `updated_at` DATETIME NOT NULL,
        `phone` VARCHAR(255) NULL DEFAULT NULL,
        PRIMARY KEY (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `index_users_on_uid_and_provider` ON `users` (`uid` ASC, `provider` ASC);
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `index_users_on_email` ON `users` (`email` ASC);
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `index_users_on_reset_password_token` ON `users` (`reset_password_token` ASC);
    SQL

    execute <<~SQL
      CREATE UNIQUE INDEX `index_users_on_confirmation_token` ON `users` (`confirmation_token` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `groups` (
        `id` INT(11) NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(255) NULL DEFAULT NULL,
        `created_at` DATETIME NOT NULL,
        `updated_at` DATETIME NOT NULL,
        `user_id` INT(11) NULL DEFAULT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_rails_5e78cd340a`
          FOREIGN KEY (`user_id`)
          REFERENCES `users` (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `index_groups_on_user_id` ON `groups` (`user_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `groups_schools` (
        `group_id` INT(11) NOT NULL,
        `school_id` INT(11) NOT NULL)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `rawdata` (
        `registration` BIGINT(20) UNSIGNED NOT NULL,
        `year` SMALLINT(5) UNSIGNED NOT NULL,
        `consistency` ENUM('validated', 'overwritten', 'unpresent', 'unavailable') NOT NULL DEFAULT 'unavailable',
        `resident_city_code` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
        `resident_city_name` CHAR(150) NULL DEFAULT NULL,
        `resident_state_code` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
        `resident_state_name` CHAR(2) NULL DEFAULT NULL,
        `hospital_unity` TINYINT(1) NULL DEFAULT NULL,
        `training` TINYINT(1) NULL DEFAULT NULL,
        `school_code` INT(10) UNSIGNED NULL DEFAULT NULL,
        `school_city_code` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
        `school_city_name` CHAR(150) NULL DEFAULT NULL,
        `school_state_code` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
        `school_state_name` CHAR(2) NULL DEFAULT NULL,
        `school_dependency` ENUM('federal', 'state', 'city', 'private') NULL DEFAULT NULL,
        `school_location` ENUM('urban', 'rural') NULL DEFAULT NULL,
        `school_status` ENUM('active', 'inactive', 'extinct') NULL DEFAULT NULL,
        `age` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
        `gender` ENUM('male', 'female') NULL DEFAULT NULL,
        `nationality` ENUM('natural', 'naturalized', 'foreign', 'abroad') NULL DEFAULT NULL,
        `birth_city_code` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
        `birth_city_name` CHAR(150) NULL DEFAULT NULL,
        `birth_state_code` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
        `birth_state_name` CHAR(2) NULL DEFAULT NULL,
        `conclusion` ENUM('completed', 'current', 'future', 'incomplete') NULL DEFAULT NULL,
        `conclusion_year` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
        `school_type` ENUM('public', 'private', 'foreign') NULL DEFAULT NULL,
        `conclusion_type` ENUM('regular', 'special', 'youth', 'professional') NULL DEFAULT NULL,
        `marital_status` ENUM('single', 'married', 'divorced', 'widower') NULL DEFAULT NULL,
        `color` ENUM('white', 'black', 'brown', 'yellow', 'indigene', 'unkown') NULL DEFAULT NULL,
        `low_vision` TINYINT(1) NULL DEFAULT NULL,
        `blind` TINYINT(1) NULL DEFAULT NULL,
        `deaf` TINYINT(1) NULL DEFAULT NULL,
        `hearing_deficiency` TINYINT(1) NULL DEFAULT NULL,
        `blind_deaf` TINYINT(1) NULL DEFAULT NULL,
        `physical_disability` TINYINT(1) NULL DEFAULT NULL,
        `mental_disability` TINYINT(1) NULL DEFAULT NULL,
        `attention_deficit` TINYINT(1) NULL DEFAULT NULL,
        `dyslexia` TINYINT(1) NULL DEFAULT NULL,
        `pregnancy` TINYINT(1) NULL DEFAULT NULL,
        `lactating` TINYINT(1) NULL DEFAULT NULL,
        `elderly` TINYINT(1) NULL DEFAULT NULL,
        `dyscalculia` TINYINT(1) NULL DEFAULT NULL,
        `autism` TINYINT(1) NULL DEFAULT NULL,
        `monocular_vision` TINYINT(1) NULL DEFAULT NULL,
        `sabbatista` TINYINT(1) NULL DEFAULT NULL,
        `other_deficiency` TINYINT(1) NULL DEFAULT NULL,
        `resource` TINYINT(1) NULL DEFAULT NULL,
        `social_name` TINYINT(1) NULL DEFAULT NULL,
        `braille` TINYINT(1) NULL DEFAULT NULL,
        `enlarged_big` TINYINT(1) NULL DEFAULT NULL,
        `enlarged_medium` TINYINT(1) NULL DEFAULT NULL,
        `reader` TINYINT(1) NULL DEFAULT NULL,
        `easy_access` TINYINT(1) NULL DEFAULT NULL,
        `transcription` TINYINT(1) NULL DEFAULT NULL,
        `hand_talk` TINYINT(1) NULL DEFAULT NULL,
        `lip_reading` TINYINT(1) NULL DEFAULT NULL,
        `wheelchair` TINYINT(1) NULL DEFAULT NULL,
        `separated_chair` TINYINT(1) NULL DEFAULT NULL,
        `leg_support` TINYINT(1) NULL DEFAULT NULL,
        `interpret_guide` TINYINT(1) NULL DEFAULT NULL,
        `litter` TINYINT(1) NULL DEFAULT NULL,
        `computer` TINYINT(1) NULL DEFAULT NULL,
        `special_chair` TINYINT(1) NULL DEFAULT NULL,
        `left_handed_chair` TINYINT(1) NULL DEFAULT NULL,
        `padded_chair` TINYINT(1) NULL DEFAULT NULL,
        `lying` TINYINT(1) NULL DEFAULT NULL,
        `obese_furniture` TINYINT(1) NULL DEFAULT NULL,
        `overlay_blade` TINYINT(1) NULL DEFAULT NULL,
        `hearing_protector` TINYINT(1) NULL DEFAULT NULL,
        `glucose_meter` TINYINT(1) NULL DEFAULT NULL,
        `braille_machine` TINYINT(1) NULL DEFAULT NULL,
        `soroban` TINYINT(1) NULL DEFAULT NULL,
        `pacemaker` TINYINT(1) NULL DEFAULT NULL,
        `probe` TINYINT(1) NULL DEFAULT NULL,
        `medicine` TINYINT(1) NULL DEFAULT NULL,
        `individual_room` TINYINT(1) NULL DEFAULT NULL,
        `special_room` TINYINT(1) NULL DEFAULT NULL,
        `companion_room` TINYINT(1) NULL DEFAULT NULL,
        `specific_forniture` TINYINT(1) NULL DEFAULT NULL,
        `specific_material` TINYINT(1) NULL DEFAULT NULL,
        `other_necessity` TINYINT(1) NULL DEFAULT NULL,
        `prison_unity` TINYINT(1) NULL DEFAULT NULL,
        `certification` TINYINT(1) NULL DEFAULT NULL,
        `certifier_name` CHAR(150) NULL DEFAULT NULL,
        `certifier_state_code` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
        `certifier_state_name` CHAR(2) NULL DEFAULT NULL,
        `test_city_code` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
        `test_city_name` CHAR(150) NULL DEFAULT NULL,
        `test_state_code` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
        `test_state_name` CHAR(2) NULL DEFAULT NULL,
        `cn_presence` ENUM('missed', 'present', 'eliminated') NULL DEFAULT NULL,
        `ch_presence` ENUM('missed', 'present', 'eliminated') NULL DEFAULT NULL,
        `lc_presence` ENUM('missed', 'present', 'eliminated') NULL DEFAULT NULL,
        `mt_presence` ENUM('missed', 'present', 'eliminated') NULL DEFAULT NULL,
        `cn_test_code` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
        `ch_test_code` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
        `lc_test_code` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
        `mt_test_code` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
        `cn_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `ch_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `lc_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `mt_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `cn_answers` CHAR(45) NULL DEFAULT NULL,
        `ch_answers` CHAR(45) NULL DEFAULT NULL,
        `lc_answers` CHAR(45) NULL DEFAULT NULL,
        `mt_answers` CHAR(45) NULL DEFAULT NULL,
        `lc_type` ENUM('english', 'spanish') NULL DEFAULT NULL,
        `cn_key` CHAR(45) NULL DEFAULT NULL,
        `ch_key` CHAR(45) NULL DEFAULT NULL,
        `lc_key` CHAR(45) NULL DEFAULT NULL,
        `mt_key` CHAR(45) NULL DEFAULT NULL,
        `essay_status` ENUM('ok', 'nullified', 'copy', 'empty', 'hurt', 'escape', 'incorrect', 'insufficient', 'disconnected', 'missed', 'other') NULL DEFAULT NULL,
        `first_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `second_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `third_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `fourth_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `fifth_competence_score` DECIMAL(5,1) NULL DEFAULT NULL,
        `essay_score` DECIMAL(5,1) NULL DEFAULT NULL,
        PRIMARY KEY (`registration`))
      ENGINE = MyISAM
      DEFAULT CHARACTER SET = latin1;
    SQL

    execute <<~SQL
      CREATE INDEX `cn_test_code_index1` USING BTREE ON `rawdata` (`cn_test_code` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `ch_test_code_index1` ON `rawdata` (`ch_test_code` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `lc_test_code_index1` ON `rawdata` (`lc_test_code` ASC, `lc_type` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `mt_test_code_index1` ON `rawdata` (`mt_test_code` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `school_code_index1` USING BTREE ON `rawdata` (`school_code` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `school_summary` (
        `school_id` INT(10) UNSIGNED NULL DEFAULT NULL,
        `exam_id` INT(10) UNSIGNED NOT NULL)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `schools_users` (
        `school_id` INT(11) NOT NULL,
        `user_id` INT(11) NOT NULL)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `index_schools_users_on_school_id_and_user_id` ON `schools_users` (`school_id` ASC, `user_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `index_schools_users_on_user_id_and_school_id` ON `schools_users` (`user_id` ASC, `school_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `scores` (
        `area_id` INT(10) UNSIGNED NOT NULL,
        `candidate_id` INT(10) UNSIGNED NOT NULL,
        `presence` ENUM('missed', 'present', 'eliminated') NOT NULL,
        `score` DECIMAL(5,1) NULL DEFAULT NULL,
        PRIMARY KEY (`area_id`, `candidate_id`),
        CONSTRAINT `fk_areas_has_candidate_areas1`
          FOREIGN KEY (`area_id`)
          REFERENCES `areas` (`id`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION,
        CONSTRAINT `fk_statuses_candidates1`
          FOREIGN KEY (`candidate_id`)
          REFERENCES `candidates` (`id`)
          ON DELETE NO ACTION
          ON UPDATE NO ACTION)
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `fk_areas_has_candidate_areas1_idx` ON `scores` (`area_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_statuses_candidates1_idx` ON `scores` (`candidate_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `summaries` (
        `school_id` INT(10) UNSIGNED NOT NULL,
        `exam_id` INT(10) UNSIGNED NOT NULL,
        `ch_score` DECIMAL(5,1) NOT NULL,
        `cn_score` DECIMAL(5,1) NOT NULL,
        `lc_score` DECIMAL(5,1) NOT NULL,
        `mt_score` DECIMAL(5,1) NOT NULL,
        `general_score` DECIMAL(5,1) NOT NULL,
        `city_ranking` INT(11) NOT NULL DEFAULT '0',
        `state_ranking` INT(11) NOT NULL DEFAULT '0',
        `country_ranking` INT(11) NOT NULL DEFAULT '0',
        PRIMARY KEY (`school_id`, `exam_id`),
        CONSTRAINT `fk_summaries_exams1`
          FOREIGN KEY (`exam_id`)
          REFERENCES `exams` (`id`),
        CONSTRAINT `fk_summaries_schools1`
          FOREIGN KEY (`school_id`)
          REFERENCES `schools` (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `fk_summaries_exams1_idx` ON `summaries` (`exam_id` ASC);
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `tags` (
        `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(128) NOT NULL,
        PRIMARY KEY (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE TABLE IF NOT EXISTS `taggings` (
        `tag_id` INT(10) UNSIGNED NOT NULL,
        `question_id` INT(10) UNSIGNED NOT NULL,
        PRIMARY KEY (`tag_id`, `question_id`),
        CONSTRAINT `fk_questions_has_tags_questions1`
          FOREIGN KEY (`question_id`)
          REFERENCES `questions` (`id`),
        CONSTRAINT `fk_questions_has_tags_tags1`
          FOREIGN KEY (`tag_id`)
          REFERENCES `tags` (`id`))
      ENGINE = InnoDB
      DEFAULT CHARACTER SET = utf8;
    SQL

    execute <<~SQL
      CREATE INDEX `fk_questions_has_tags_tags1_idx` ON `taggings` (`tag_id` ASC);
    SQL

    execute <<~SQL
      CREATE INDEX `fk_questions_has_tags_questions1_idx` ON `taggings` (`question_id` ASC);
    SQL
  end

  def down
    execute 'DROP TABLE taggings'
    execute 'DROP TABLE tags'
    execute 'DROP TABLE summaries'
    execute 'DROP TABLE scores'
    execute 'DROP TABLE schools_users'
    execute 'DROP TABLE school_summary'
    execute 'DROP TABLE rawdata'
    execute 'DROP TABLE groups_schools'
    execute 'DROP TABLE groups'
    execute 'DROP TABLE users'
    execute 'DROP TABLE frequencies'
    execute 'DROP TABLE questions'
    execute 'DROP TABLE subjects'
    execute 'DROP TABLE skills'
    execute 'DROP TABLE candidates'
    execute 'DROP TABLE schools'
    execute 'DROP TABLE exams'
    execute 'DROP TABLE cities'
    execute 'DROP TABLE states'
    execute 'DROP TABLE areas'
    execute 'DROP TABLE answers'
    execute 'DROP TABLE alternatives'
  end
end
