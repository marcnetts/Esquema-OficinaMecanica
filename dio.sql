#CREATE SCHEMA IF NOT EXISTS tbl_oficinamecanica DEFAULT CHARACTER SET utf8 ;
#USE tbl_oficinamecanica ;

CREATE TABLE IF NOT EXISTS cliente (
  id_cliente INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(90) NOT NULL,
  endereco VARCHAR(90) NOT NULL,
  PRIMARY KEY (id_cliente))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS especialidade (
  id_especialidade INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(11) NOT NULL,
  PRIMARY KEY (id_especialidade))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS mecanico (
  id_mecanico INT(11) NOT NULL AUTO_INCREMENT,
  codigo VARCHAR(9) NOT NULL,
  nome VARCHAR(90) NOT NULL,
  id_especialidade INT(11) NOT NULL,
  endereco VARCHAR(90) NOT NULL,
  PRIMARY KEY (id_mecanico, id_especialidade),
  INDEX fk_mecanico_especialidade1_idx (id_especialidade ASC),
  CONSTRAINT fk_mecanico_especialidade1
    FOREIGN KEY (id_especialidade)
    REFERENCES especialidade (id_especialidade)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS veiculo (
  id_veiculo INT(11) NOT NULL AUTO_INCREMENT,
  id_cliente INT(11) NOT NULL,
  chapa VARCHAR(7) NOT NULL,
  cor VARCHAR(10) NOT NULL,
  modelo VARCHAR(10) NOT NULL,
  ano INT(11) NOT NULL,
  PRIMARY KEY (id_veiculo),
  UNIQUE INDEX chapa_UNIQUE (chapa ASC),
  INDEX fk_veiculo_cliente_idx (id_cliente ASC),
  CONSTRAINT fk_veiculo_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES cliente (id_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS ordemservico (
  id_ordemservico INT(11) NOT NULL AUTO_INCREMENT,
  id_veiculo INT(11) NOT NULL,
  codigo VARCHAR(10) NOT NULL,
  tipo_servico VARCHAR(10) NOT NULL,
  data_pedido DATE NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  autorizado TINYINT(4) NOT NULL,
  pago TINYINT(4) NOT NULL,
  data_termino DATE NULL DEFAULT NULL,
  PRIMARY KEY (id_ordemservico, id_veiculo),
  INDEX fk_ordemservico_veiculo1_idx (id_veiculo ASC),
  CONSTRAINT fk_ordemservico_veiculo1
    FOREIGN KEY (id_veiculo)
    REFERENCES veiculo (id_veiculo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS peca (
  id_peca INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_peca))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS tipo_servico (
  id_servico INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_servico))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS peca_has_ordemservico (
  peca_id_peca INT(11) NOT NULL,
  id_ordemservico INT(11) NOT NULL,
  PRIMARY KEY (peca_id_peca, id_ordemservico),
  INDEX fk_peca_has_ordemservico_ordemservico1_idx (id_ordemservico ASC),
  INDEX fk_peca_has_ordemservico_peca1_idx (peca_id_peca ASC),
  CONSTRAINT fk_peca_has_ordemservico_peca1
    FOREIGN KEY (peca_id_peca)
    REFERENCES peca (id_peca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_peca_has_ordemservico_ordemservico1
    FOREIGN KEY (id_ordemservico)
    REFERENCES ordemservico (id_ordemservico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS ordemservico_has_tipo_servico (
  id_ordemservico INT(11) NOT NULL,
  id_servico INT(11) NOT NULL,
  PRIMARY KEY (id_ordemservico, id_servico),
  INDEX fk_ordemservico_has_tipo_servico_tipo_servico1_idx (id_servico ASC),
  INDEX fk_ordemservico_has_tipo_servico_ordemservico1_idx (id_ordemservico ASC),
  CONSTRAINT fk_ordemservico_has_tipo_servico_ordemservico1
    FOREIGN KEY (id_ordemservico)
    REFERENCES ordemservico (id_ordemservico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ordemservico_has_tipo_servico_tipo_servico1
    FOREIGN KEY (id_servico)
    REFERENCES tipo_servico (id_servico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS ordemservico_has_mecanico (
  id_ordemservico INT(11) NOT NULL,
  id_mecanico INT(11) NOT NULL,
  PRIMARY KEY (id_ordemservico, id_mecanico),
  INDEX fk_ordemservico_has_mecanico_mecanico1_idx (id_mecanico ASC),
  INDEX fk_ordemservico_has_mecanico_ordemservico1_idx (id_ordemservico ASC),
  CONSTRAINT fk_ordemservico_has_mecanico_ordemservico1
    FOREIGN KEY (id_ordemservico)
    REFERENCES ordemservico (id_ordemservico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ordemservico_has_mecanico_mecanico1
    FOREIGN KEY (id_mecanico)
    REFERENCES mecanico (id_mecanico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

# INSERTS
INSERT INTO cliente (nome, endereco) VALUES
 ('João', 'Rua X'),
 ('Alberto', 'Rua T'),
 ('Maria', 'Av B')
;
INSERT INTO veiculo (id_cliente, chapa, cor, modelo, ano) VALUES
 (1, 'OSI123', 'Azul', 'Fusca', 1987),
 (3, 'POI123', 'Preto', 'HB20', 2020),
 (3, 'VAX321', 'Azul', 'HB30', 2021),
 (2, 'ART123', 'Branco', 'Uno', 2012),
 (1, 'EWQ321', 'Preto', 'HB30', 2017)
;
INSERT INTO especialidade (nome) VALUES
 ('Lataria'),
 ('Janelas'),
 ('Pneus')
;
INSERT INTO mecanico (codigo, nome, id_especialidade, endereco) VALUES
 ('1000', 'Lucas', 1, 'Rua XY'),
 ('100A', 'Jack', 2, 'Rua E'),
 ('100B', 'Armando', 3, 'Av I')
;
INSERT INTO ordemservico (id_veiculo, codigo, tipo_servico, data_pedido, valor, autorizado, pago, data_termino) VALUES
 (1, 'R001A', 'Revisão', '2022-10-01', 200, 1, 1, '2022-10-03'),
 (2, 'R002A', 'Revisão', '2022-10-04', 300, 0, 0, NULL),
 (3, 'C001B', 'Conserto', '2022-10-05', 200, 1, 0, '2022-10-06')
;
INSERT INTO tipo_servico (nome, valor) VALUES
 ('Troca de janela', 80),
 ('Conserto de lataria', 110),
 ('Troca de fluido', 60)
;
INSERT INTO ordemservico_has_mecanico (id_ordemservico, id_mecanico) VALUES
 (1, 3),
 (2, 1),
 (2, 2),
 (3, 2)
;
INSERT INTO ordemservico_has_tipo_servico (id_ordemservico, id_servico) VALUES
 (2, 1),
 (2, 2),
 (3, 2)
;
# SELECTS
#Todos veiculos
SELECT * FROM veiculo;
#Veiculos azuis
SELECT * FROM veiculo WHERE cor = 'Azul';
#Ordem de serviços anteriores com data em dias atrás
SELECT id_ordemservico, id_veiculo, tipo_servico, DATEDIFF(data_pedido, NOW()) dias_atras FROM ordemservico;
#Donos de carros em ordem alfabética
SELECT * FROM cliente ORDER BY nome;
#Cores de veículos não-únicas
SELECT cor, COUNT(*) contagem FROM veiculo GROUP BY cor HAVING contagem > 1;
# Ordem de pedido com dados do cliente
SELECT cliente.nome cliente, veiculo.chapa, veiculo.modelo, ordemservico.codigo codio_ordemservico, ordemservico.tipo_servico FROM ordemservico INNER JOIN veiculo ON veiculo.id_veiculo = ordemservico.id_veiculo INNER JOIN cliente ON cliente.id_cliente = veiculo.id_cliente;
