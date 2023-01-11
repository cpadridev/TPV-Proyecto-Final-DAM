-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tpv
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tpv` ;

-- -----------------------------------------------------
-- Schema tpv
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tpv` DEFAULT CHARACTER SET latin1 ;
USE `tpv` ;

-- -----------------------------------------------------
-- Table `tpv`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`category` (
  `id_category` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_category`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`customer` (
  `id_customer` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surnames` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL,
  `city` VARCHAR(45) NULL,
  `zip_code` VARCHAR(10) NULL,
  PRIMARY KEY (`id_customer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`offer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`offer` (
  `id_offer` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `period` DATE NOT NULL,
  `file` LONGBLOB NULL DEFAULT NULL,
  `discount` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id_offer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`customer_offers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`customer_offers` (
  `id_customer_offers` INT(11) NOT NULL AUTO_INCREMENT,
  `id_customer` INT(11) NOT NULL,
  `id_offer` INT(11) NOT NULL,
  PRIMARY KEY (`id_customer_offers`, `id_customer`, `id_offer`),
  INDEX `fk_customer_offers_customer_idx` (`id_customer` ASC),
  INDEX `fk_customer_offers_offer1_idx` (`id_offer` ASC),
  CONSTRAINT `fk_customer_offers_customer`
    FOREIGN KEY (`id_customer`)
    REFERENCES `tpv`.`customer` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_offers_offer1`
    FOREIGN KEY (`id_offer`)
    REFERENCES `tpv`.`offer` (`id_offer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`location` (
  `id_location` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_location`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`permission` (
  `id_permission` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_permission`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`product` (
  `id_product` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `image` LONGBLOB NULL DEFAULT NULL,
  `price` DOUBLE NOT NULL,
  `iva` INT(11) NULL,
  `quantity` INT(11) NOT NULL,
  `id_category` INT(11) NOT NULL,
  `id_location` INT(11) NOT NULL,
  `id_offer` INT(11) NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_product_offer1_idx` (`id_offer` ASC),
  INDEX `fk_product_category1_idx` (`id_category` ASC),
  INDEX `fk_product_location1_idx` (`id_location` ASC),
  CONSTRAINT `fk_product_offer1`
    FOREIGN KEY (`id_offer`)
    REFERENCES `tpv`.`offer` (`id_offer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`id_category`)
    REFERENCES `tpv`.`category` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_location1`
    FOREIGN KEY (`id_location`)
    REFERENCES `tpv`.`location` (`id_location`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`role` (
  `id_role` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`role_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`role_permissions` (
  `id_role_permissions` INT(11) NOT NULL AUTO_INCREMENT,
  `id_role` INT(11) NOT NULL,
  `id_permission` INT(11) NOT NULL,
  PRIMARY KEY (`id_role_permissions`, `id_role`, `id_permission`),
  INDEX `fk_role_permissions_role1_idx` (`id_role` ASC),
  INDEX `fk_role_permissions_permission1_idx` (`id_permission` ASC),
  CONSTRAINT `fk_role_permissions_role1`
    FOREIGN KEY (`id_role`)
    REFERENCES `tpv`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_permissions_permission1`
    FOREIGN KEY (`id_permission`)
    REFERENCES `tpv`.`permission` (`id_permission`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`user` (
  `id_user` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surnames` VARCHAR(90) NULL DEFAULT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NULL,
  `address` VARCHAR(255) NULL,
  `phone` VARCHAR(20) NULL,
  `city` VARCHAR(45) NULL,
  `zip_code` VARCHAR(10) NULL,
  `id_role` INT(11) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `login_UNIQUE` (`username` ASC),
  INDEX `fk_user_role1_idx` (`id_role` ASC),
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`id_role`)
    REFERENCES `tpv`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`sale` (
  `id_sale` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `payment` VARCHAR(45) NOT NULL,
  `total` DOUBLE NOT NULL,
  `ticket` LONGBLOB NOT NULL,
  `id_customer` INT(11) NOT NULL,
  `id_user` INT(11) NOT NULL,
  PRIMARY KEY (`id_sale`),
  INDEX `fk_sale_customer1_idx` (`id_customer` ASC),
  INDEX `fk_sale_user1_idx` (`id_user` ASC),
  CONSTRAINT `fk_sale_customer1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `tpv`.`customer` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `tpv`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`sale_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`sale_details` (
  `id_sale_details` INT(11) NOT NULL AUTO_INCREMENT,
  `id_sale` INT(11) NOT NULL,
  `id_product` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`id_sale_details`, `id_sale`, `id_product`),
  INDEX `fk_sale_details_sale1_idx` (`id_sale` ASC),
  INDEX `fk_sale_details_product1_idx` (`id_product` ASC),
  CONSTRAINT `fk_sale_details_sale1`
    FOREIGN KEY (`id_sale`)
    REFERENCES `tpv`.`sale` (`id_sale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_details_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `tpv`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
