-- MySQL Workbench Synchronization
-- Generated: 2021-05-07 18:29
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: carvalhgui

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE TABLE IF NOT EXISTS `datainfo_capes`.`instituicao_ensino` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `estado` CHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `datainfo_capes`.`cursos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `nivel_escolaridade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `datainfo_capes`.`instituicao_ensino_cursos` (
  `instituicao_ensino_id` INT(11) NOT NULL,
  `cursos_id` INT(11) NOT NULL,
  PRIMARY KEY (`instituicao_ensino_id`, `cursos_id`),
  INDEX `fk_instituicao_ensino_has_cursos_cursos1_idx` (`cursos_id` ASC),
  INDEX `fk_instituicao_ensino_has_cursos_instituicao_ensino_idx` (`instituicao_ensino_id` ASC),
  CONSTRAINT `fk_instituicao_ensino_has_cursos_instituicao_ensino`
    FOREIGN KEY (`instituicao_ensino_id`)
    REFERENCES `datainfo_capes`.`instituicao_ensino` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instituicao_ensino_has_cursos_cursos1`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `datainfo_capes`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
