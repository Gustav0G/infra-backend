-- MySQL Script generated by MySQL Workbench
-- Sun Jul 17 03:52:05 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema delivery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema delivery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `delivery` DEFAULT CHARACTER SET utf8 ;
USE `delivery` ;

-- -----------------------------------------------------
-- Table `delivery`.`tb_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  `sobrenome` VARCHAR(60) NOT NULL,
  `dataNasc` DATETIME NOT NULL,
  `documento` VARCHAR(14) NOT NULL,
  `email` VARCHAR(140) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `deviceToken` VARCHAR(255) NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `documento_UNIQUE` (`documento` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_permissoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_permissoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_usuariopermissão`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_usuariopermissão` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUsuarios_id` INT NOT NULL,
  `idPermissoes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_usuariopermissão_tb_usuarios_idx` (`idUsuarios_id` ASC) ,
  INDEX `fk_tb_usuariopermissão_tb_permissoes1_idx` (`idPermissoes_id` ASC) ,
  CONSTRAINT `fk_tb_usuariopermissão_tb_usuarios`
    FOREIGN KEY (`idUsuarios_id`)
    REFERENCES `delivery`.`tb_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_usuariopermissão_tb_permissoes1`
    FOREIGN KEY (`idPermissoes_id`)
    REFERENCES `delivery`.`tb_permissoes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_estabelecimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_estabelecimentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(11) NULL,
  `descricao` VARCHAR(150) NULL,
  `imagemUrl` VARCHAR(255) NULL,
  `latitude` VARCHAR(15) NOT NULL,
  `longitude` VARCHAR(15) NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `enderecoNumero` VARCHAR(6) NOT NULL,
  `enderecoOpcional` VARCHAR(15) NULL,
  `status` VARCHAR(1) NULL,
  `dtCreated` DATETIME NOT NULL,
  `dtUpdated` DATETIME NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) ,
  INDEX `fk_tb_estabelecimentos_tb_usuarios1_idx` (`idUsuario` ASC) ,
  CONSTRAINT `fk_tb_estabelecimentos_tb_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `delivery`.`tb_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(110) NULL,
  `dtCreated` DATETIME DEFAULT now(), 
  `dtUpdated` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(120) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `valor` DOUBLE NOT NULL,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  `dtUpdated` DATETIME NOT NULL,
  `idCategoria` INT NOT NULL,
  `idEstabelecimento` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_produtos_tb_categorias1_idx` (`idCategoria` ASC) ,
  INDEX `fk_tb_produtos_tb_estabelecimentos1_idx` (`idEstabelecimento` ASC) ,
  CONSTRAINT `fk_tb_produtos_tb_categorias1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `delivery`.`tb_categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_produtos_tb_estabelecimentos1`
    FOREIGN KEY (`idEstabelecimento`)
    REFERENCES `delivery`.`tb_estabelecimentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_vendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  `dtUpdate` DATETIME NULL,
  `idUsuario` INT NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_vendas_tb_usuarios1_idx` (`idUsuario` ASC) ,
  INDEX `fk_tb_vendas_tb_produtos1_idx` (`idProduto` ASC) ,
  CONSTRAINT `fk_tb_vendas_tb_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `delivery`.`tb_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_vendas_tb_produtos1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `delivery`.`tb_produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_push`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_push` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(120) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `dtCreated` DATETIME NULL,
  `tb_usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_push_tb_usuarios1_idx` (`tb_usuarios_id` ASC) ,
  CONSTRAINT `fk_tb_push_tb_usuarios1`
    FOREIGN KEY (`tb_usuarios_id`)
    REFERENCES `delivery`.`tb_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
