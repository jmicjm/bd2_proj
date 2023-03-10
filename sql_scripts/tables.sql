-- MySQL Script generated by MySQL Workbench
-- Mon Dec  5 18:19:27 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mpk_bd2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mpk_bd2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mpk_bd2` DEFAULT CHARACTER SET utf8mb3 ;
USE `mpk_bd2` ;

-- -----------------------------------------------------
-- Table `mpk_bd2`.`miejscowosc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`miejscowosc` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`miejscowosc` (
  `id_miejscowosc` INT NOT NULL AUTO_INCREMENT,
  `nazwa_miejscowosci` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_miejscowosc`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`ulica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`ulica` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`ulica` (
  `id_ulica` INT NOT NULL AUTO_INCREMENT,
  `nazwa_ulicy` VARCHAR(255) NULL DEFAULT NULL,
  `id_miejscowosc` INT NOT NULL,
  PRIMARY KEY (`id_ulica`),
  INDEX `id_miejscowosc_idx` (`id_miejscowosc` ASC) VISIBLE,
  CONSTRAINT `ulica_miejscowosc_key`
    FOREIGN KEY (`id_miejscowosc`)
    REFERENCES `mpk_bd2`.`miejscowosc` (`id_miejscowosc`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`adres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`adres` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`adres` (
  `id_adres` INT NOT NULL AUTO_INCREMENT,
  `nr_domu` VARCHAR(16) NOT NULL,
  `nr_lokalu` VARCHAR(16) NULL DEFAULT NULL,
  `id_ulica` INT NOT NULL,
  PRIMARY KEY (`id_adres`),
  INDEX `id_ulica_idx` (`id_ulica` ASC) VISIBLE,
  CONSTRAINT `adres_ulica_key`
    FOREIGN KEY (`id_ulica`)
    REFERENCES `mpk_bd2`.`ulica` (`id_ulica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`pracownik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`pracownik` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`pracownik` (
  `id_pracownik` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(255) NULL DEFAULT NULL,
  `nazwisko` VARCHAR(255) NULL DEFAULT NULL,
  `data_urodzenia` DATE NULL DEFAULT NULL,
  `data_zatrudnienia` DATE NULL DEFAULT NULL,
  `pesel` CHAR(11) NULL DEFAULT NULL,
  `id_adres` INT NOT NULL,
  PRIMARY KEY (`id_pracownik`),
  INDEX `id_adres_idx` (`id_adres` ASC) VISIBLE,
  INDEX `imie_nazwisko_idx` (`imie` ASC, `nazwisko` ASC) VISIBLE,
  CONSTRAINT `pracownik_adres_key`
    FOREIGN KEY (`id_adres`)
    REFERENCES `mpk_bd2`.`adres` (`id_adres`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`administrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`administrator` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`administrator` (
  `id_administrator` INT NOT NULL AUTO_INCREMENT,
  `id_pracownik` INT NOT NULL,
  PRIMARY KEY (`id_administrator`),
  INDEX `administrator_pracownik_key_idx` (`id_pracownik` ASC) VISIBLE,
  CONSTRAINT `administrator_pracownik_key`
    FOREIGN KEY (`id_pracownik`)
    REFERENCES `mpk_bd2`.`pracownik` (`id_pracownik`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`brygadzista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`brygadzista` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`brygadzista` (
  `id_brygadzista` INT NOT NULL AUTO_INCREMENT,
  `id_pracownik` INT NOT NULL,
  PRIMARY KEY (`id_brygadzista`),
  INDEX `brygadzista_pracownik_key_idx` (`id_pracownik` ASC) VISIBLE,
  CONSTRAINT `brygadzista_pracownik_key`
    FOREIGN KEY (`id_pracownik`)
    REFERENCES `mpk_bd2`.`pracownik` (`id_pracownik`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`brygada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`brygada` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`brygada` (
  `id_brygada` INT NOT NULL AUTO_INCREMENT,
  `id_brygadzista` INT NOT NULL,
  PRIMARY KEY (`id_brygada`),
  INDEX `brygada_brygadzista_key_idx` (`id_brygadzista` ASC) VISIBLE,
  CONSTRAINT `brygada_brygadzista_key`
    FOREIGN KEY (`id_brygadzista`)
    REFERENCES `mpk_bd2`.`brygadzista` (`id_brygadzista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`cennik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`cennik` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`cennik` (
  `id_cennik` INT NOT NULL AUTO_INCREMENT,
  `cena` INT NULL DEFAULT NULL,
  `rodzaj` CHAR(1) NULL DEFAULT NULL,
  `typ_przejazdu` VARCHAR(255) NULL DEFAULT NULL,
  `id_administrator` INT NOT NULL,
  PRIMARY KEY (`id_cennik`),
  INDEX `Cennik_administrator_key_idx` (`id_administrator` ASC) VISIBLE,
  CONSTRAINT `Cennik_administrator_key`
    FOREIGN KEY (`id_administrator`)
    REFERENCES `mpk_bd2`.`administrator` (`id_administrator`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`przystanek`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`przystanek` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`przystanek` (
  `id_przystanek` INT NOT NULL AUTO_INCREMENT,
  `nazwa_przystanek` VARCHAR(255) NULL DEFAULT NULL,
  `id_adres` INT NOT NULL,
  PRIMARY KEY (`id_przystanek`),
  INDEX `przystanek_adres_key_idx` (`id_adres` ASC) VISIBLE,
  INDEX `nazwa_przystanku_idx` (`nazwa_przystanek` ASC) VISIBLE,
  CONSTRAINT `przystanek_adres_key`
    FOREIGN KEY (`id_adres`)
    REFERENCES `mpk_bd2`.`adres` (`id_adres`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`linia_autobusowa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`linia_autobusowa` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`linia_autobusowa` (
  `id_linia_autobusowa` INT NOT NULL,
  `typ_linii` CHAR(1) NULL,
  PRIMARY KEY (`id_linia_autobusowa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`trasa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`trasa` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`trasa` (
  `nr_linii` INT NOT NULL AUTO_INCREMENT,
  `nr_przystanku_na_trasie` INT NULL DEFAULT NULL,
  `id_przystanek` INT NOT NULL,
  `id_trasa` INT NOT NULL,
  INDEX `linia_przystanek_key_idx` (`id_przystanek` ASC) VISIBLE,
  PRIMARY KEY (`id_trasa`),
  INDEX `linia_key_idx` (`nr_linii` ASC) VISIBLE,
  CONSTRAINT `linia_przystanek_key`
    FOREIGN KEY (`id_przystanek`)
    REFERENCES `mpk_bd2`.`przystanek` (`id_przystanek`),
  CONSTRAINT `linia_key`
    FOREIGN KEY (`nr_linii`)
    REFERENCES `mpk_bd2`.`linia_autobusowa` (`id_linia_autobusowa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`fragment_kursu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`fragment_kursu` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`fragment_kursu` (
  `id_kurs` INT NOT NULL AUTO_INCREMENT,
  `nr_linii` INT NOT NULL,
  `godzina_startu` DATETIME(6) NULL DEFAULT NULL,
  `przystanek_startowy` INT NOT NULL,
  `przystanek_koncowy` INT NOT NULL,
  PRIMARY KEY (`id_kurs`),
  INDEX `kurs_linia_view_idx` (`nr_linii` ASC) VISIBLE,
  INDEX `kurs_przystanek_start_key_idx` (`przystanek_startowy` ASC) VISIBLE,
  INDEX `kurs_przystanek_end_key_idx` (`przystanek_koncowy` ASC) VISIBLE,
  CONSTRAINT `kurs_linia_view`
    FOREIGN KEY (`nr_linii`)
    REFERENCES `mpk_bd2`.`linia_autobusowa` (`id_linia_autobusowa`),
  CONSTRAINT `kurs_przystanek_end_key`
    FOREIGN KEY (`przystanek_koncowy`)
    REFERENCES `mpk_bd2`.`przystanek` (`id_przystanek`),
  CONSTRAINT `kurs_przystanek_start_key`
    FOREIGN KEY (`przystanek_startowy`)
    REFERENCES `mpk_bd2`.`przystanek` (`id_przystanek`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`kierowca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`kierowca` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`kierowca` (
  `id_kierowca` INT NOT NULL AUTO_INCREMENT,
  `nr_seryjny_prawa_jazdy` INT NULL DEFAULT NULL,
  `kat_prawa_jazdy` VARCHAR(3) NULL DEFAULT NULL,
  `id_pracownik` INT NOT NULL,
  `id_brygada` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_kierowca`, `id_pracownik`),
  INDEX `id_pracownik_idx` (`id_pracownik` ASC) INVISIBLE,
  INDEX `kierowca_brygada_key_idx` (`id_brygada` ASC) VISIBLE,
  CONSTRAINT `kierowca_brygada_key`
    FOREIGN KEY (`id_brygada`)
    REFERENCES `mpk_bd2`.`brygada` (`id_brygada`),
  CONSTRAINT `kierowca_pracownik_key`
    FOREIGN KEY (`id_pracownik`)
    REFERENCES `mpk_bd2`.`pracownik` (`id_pracownik`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`pojazd`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`pojazd` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`pojazd` (
  `id_pojazd` INT NOT NULL AUTO_INCREMENT,
  `przeglad_techniczny` DATETIME(6) NULL DEFAULT NULL,
  `maks_liczba_pasazerow` INT NULL DEFAULT NULL,
  `nr_rejestracyjny` VARCHAR(7) NULL DEFAULT NULL,
  `nr_vin` CHAR(7) NULL DEFAULT NULL,
  `id_brygada` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_pojazd`),
  INDEX `pojazd_brygada_view_idx` (`id_brygada` ASC) VISIBLE,
  INDEX `nr_rejestracyjny_idx` (`nr_rejestracyjny` ASC) VISIBLE,
  CONSTRAINT `pojazd_brygada_key`
    FOREIGN KEY (`id_brygada`)
    REFERENCES `mpk_bd2`.`brygada` (`id_brygada`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`rozklad_jazdy_administratora`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`rozklad_jazdy_administratora` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`rozklad_jazdy_administratora` (
  `id_rozklad_jazdy_admin` INT NOT NULL AUTO_INCREMENT,
  `id_przystanek` INT NULL DEFAULT NULL,
  `nr_linii` INT NULL DEFAULT NULL,
  `id_administrator` INT NOT NULL,
  `data_odjazdu` DATETIME(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id_rozklad_jazdy_admin`),
  INDEX `rozklad_admin_key_idx` (`id_administrator` ASC) VISIBLE,
  CONSTRAINT `rozklad_admin_key`
    FOREIGN KEY (`id_administrator`)
    REFERENCES `mpk_bd2`.`administrator` (`id_administrator`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mpk_bd2`.`rozklad_jazdy_brygadzisty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mpk_bd2`.`rozklad_jazdy_brygadzisty` ;

CREATE TABLE IF NOT EXISTS `mpk_bd2`.`rozklad_jazdy_brygadzisty` (
  `id_rozklad_jazdy_brygadzisty` INT NOT NULL AUTO_INCREMENT,
  `id_fragment_kursu` INT NOT NULL,
  `id_brygada` INT NOT NULL,
  `id_kierowca` INT NOT NULL,
  `godzina_startu_kierowcy` DATETIME(6) NULL DEFAULT NULL,
  `id_pojazd` INT NOT NULL,
  `id_rozklad_admin` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_rozklad_jazdy_brygadzisty`),
  INDEX `rozklad_brygad_kurs_key_idx` (`id_fragment_kursu` ASC) VISIBLE,
  INDEX `rozklad_brygad_brygada_key_idx` (`id_brygada` ASC) VISIBLE,
  INDEX `rozklad_brygad_kierowca_key_idx` (`id_kierowca` ASC) VISIBLE,
  INDEX `rozklad_brygad_pojazd_key_idx` (`id_pojazd` ASC) VISIBLE,
  INDEX `rozklad_brygad_rozklad_admin_key_idx` (`id_rozklad_admin` ASC) VISIBLE,
  CONSTRAINT `rozklad_brygad_brygada_key`
    FOREIGN KEY (`id_brygada`)
    REFERENCES `mpk_bd2`.`brygada` (`id_brygada`),
  CONSTRAINT `rozklad_brygad_kierowca_key`
    FOREIGN KEY (`id_kierowca`)
    REFERENCES `mpk_bd2`.`kierowca` (`id_kierowca`),
  CONSTRAINT `rozklad_brygad_kurs_key`
    FOREIGN KEY (`id_fragment_kursu`)
    REFERENCES `mpk_bd2`.`fragment_kursu` (`id_kurs`),
  CONSTRAINT `rozklad_brygad_pojazd_key`
    FOREIGN KEY (`id_pojazd`)
    REFERENCES `mpk_bd2`.`pojazd` (`id_pojazd`),
  CONSTRAINT `rozklad_brygad_rozklad_admin_key`
    FOREIGN KEY (`id_rozklad_admin`)
    REFERENCES `mpk_bd2`.`rozklad_jazdy_administratora` (`id_rozklad_jazdy_admin`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
