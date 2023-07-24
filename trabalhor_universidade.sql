-- comando para criar o banco ------------------------------------------------------------------------------------
create database universidadebd
	default charset = utf8
    default collate = utf8_general_ci;

-- comando para ativar o banco -----------------------------------------------------------------------------------
use universidadebd;

-- criando tabela login -------------------------------------------------------------------------------------------
create table login(
	id_login int(11) not null primary key auto_increment,
    usuario varchar(11) not null,
    senha varchar(10) not null,
    nivel int(3) not null)engine InnoDB;

-- criando tabela registro do login --------------------------------------------------------------------------------
create table registro(
	id_registro int(11) not null primary key auto_increment,
    dataRegi varchar(8),
    horario varchar(8))engine InnoDB;
    alter table registro add column id_login int(11);
    alter table registro add constraint fk_logi foreign key (id_login) references login (id_login);

-- tabela de pessoas--------------------------------------------------------------------------------------------------
create table pessoa(
	id_pessoa int(11) not null primary key auto_increment,
    nome varchar(50),
    rg varchar(10),
    cpf varchar(11) not null,
    numero int(11),
    id_logrador int(11))engine InnoDB;
alter table pessoa add constraint fk_logrador foreign key (id_logrador) references logrador (id_logrador);

-- tabela de aluno ------------------------------------------------------------------------------------------------------
create table aluno(
aluno_id int(11) not null primary key auto_increment,
id_curso int(11),
id_pessoa int(11))engine InnoDB;
alter table aluno add constraint fk_cursos foreign key (id_curso) references cursos (id_cursos);
alter table aluno add constraint fk_pessoas foreign key (id_pessoa) references pessoa (id_pessoa);
ALTER TABLE ALUNO DROP column ID_MATRICULA;
-- tabela de professores---------------------------------------------------------------------------------------------------
create table professor(
id_professor int not null primary key auto_increment,
cargaHoraria float,
id_pessoa int(11),
salario float)engine InnoDB;
alter table professor add constraint fk_idpessoas foreign key (id_pessoa) references pessoa (id_pessoa);


-- tabela de cursos-----------------------------------------------------------------------------------------------------------
create table cursos(
id_cursos int not null primary key auto_increment,
nome_cursos varchar(50),
cargahorario int,
valor_curso float)engine InnoDB;
-- TABELA INTEMEDIARIA --------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT exists CURSOS_DISCIPLINA(
	ID_CURSODISCIPLINA INT NOT null primary KEY auto_increment,
    IDCURSOS INT(11),
    IDDISCIPLINA INT(11),
    foreign key (IDCURSOS) references CURSOS(ID_CURSOS),
    foreign key (IDDISCIPLINA) references DISCIPLINA (ID_DISCIPLINA))engine InnoDB;

-- tabela de disciplina--------------------------------------------------------------------------------------------------------
create table disciplina(
	id_disciplina int(11) not null primary key auto_increment,
    descricao varchar(50) not null,
    carga_horaria varchar(9))engine InnoDB;
ALTER TABLE DISCIPLINA DROP foreign key  FK_CURSO;
ALTER table DISCIPLINA DROP column ID_CURSO;

-- tabela de matriculas--------------------------------------------------------------------------------------------------------
create table matricula(
id_madricula int(11) not null primary key auto_increment,
id_professor int(11),
id_aluno int(11),
horario_inicio varchar(8),
horario_termino varchar(8))engine InnoDB;
alter table matricula add constraint fk_professores foreign key (id_professor) references professor (id_professor);
alter table matricula add constraint fk_alunos foreign key (id_aluno) references aluno (aluno_id);

-- tabela de logrador------------------------------------------------------------------------------------------------------------
create table logrador(
id_logrador int not null primary key auto_increment,
endereca varchar(60),
logrador varchar(8),
id_estado int(11),
id_cidade int(11),
id_bairro int)engine InnoDB;
alter table logrador add constraint fk_estado foreign key (id_estado) references estado (id_estado);
alter table logrador add constraint fk_cidade foreign key (id_cidade) references cidade (id_cidade);
alter table logrador add constraint fk_bairro foreign key (id_bairro) references bairro (id_bairro);

-- conpletodo da tabela de logrador-----------------------------------------------------------------------------------------------
-- tabela de bairro---------------------------------------------------------------------------------------------------------------
create table bairro(
id_bairro int not null primary key auto_increment,
bairro varchar(30))engine InnoDB;
alter table bairro drop column id_cidade;

-- tabela de cidade --------------------------------------------------------------------------------------------------------------
create table cidade (
id_cidade int primary key not null auto_increment,
cidade_nome varchar(60))engine InnoDB;

-- tabela de estado----------------------------------------------------------------------------------------------------------------
create table estado(
id_estado int primary key not null auto_increment,
estado varchar(2))engine InnoDB;



-- tabela de telefone ---------------------------------------------------------------------------------------------------------------
create table telefone(
	id_telefone int(11) not null primary key auto_increment,
    telefone varchar(11))engine InnoDB;
    alter table telefone add column descrição varchar(50);
	alter table telefone add column idpessoa int(11);
    alter table telefone add constraint fk_pessoa foreign key (idpessoa) references pessoa (id_pessoa);
	describe TELEFONE;
-- agora estaremos alimentando as tabela do banco ------------------------------------------------------------------------------------
INSERT INTO estado VALUES(0,'SP'),(0,'BA'),(0,'AL');

INSERT INTO logrador VALUES(0,'RUA DAS ORQUIDEAS','09810390',1,3,1);
INSERT INTO login VALUES (0,'DANTAS','34232',1),(0,'KIYOKO','245609',4);
INSERT INTO REGISTRO VALUES (0,'29/04/22','23:04',3),(0,'23/04/22','14:30',4);
INSERT INTO ESTADO VALUES (0,'SP'),(0,'BA'),(0,'PA');
INSERT INTO CIDADE VALUES(0,'SBCAMPO'),(0,'S.ANDRE');
INSERT INTO BAIRRO VALUES(0,'CENTRO'),(0,'ORQUIDEAS'),(0,'DEMARCHI');
INSERT INTO DISCIPLINA VALUES(0,'ELETRONICA','70'),(0,'CABEAMENTO','40'),(0,'COMPONETE','70');
INSERT INTO DISCIPLINA VALUES(0,'ROUTER','70'),(0,'TCP/IP','40'),(0,'SERVIDORES','70');
INSERT INTO CURSOS VALUES(0,'TENICO EM COMPUTADOR',300,3000.00),(0,'TECNICO EM REDE',400,4000.00);
INSERT INTO LOGRADOR VALUES(0,'R DAS ORQUIDEAS','09810390',1,1,2),(0,'R. DAS MARGARIDAS','09860000',1,1,1);
INSERT INTO CURSO_DISCIPLINA (`ID_CURSODISCIPLINA`, `IDCURSOS`, `IDDISCIPLINA`) VALUES (NULL, '4', '5'), (NULL, '4', '7');
INSERT INTO TELEFONE (`id_telefone`, `telefone`, `idpessoa`, `descrição`) VALUES (NULL, '983578874', '1', 'RECADO');
INSERT INTO PESSOA (`id_pessoa`, `nome`, `rg`, `cpf`, `numero`, `id_logrador`) VALUES (NULL, 'CARLA JAPA', '231278870', '09876543201', '202', '2');
INSERT INTO PROFESSOR (`id_professor`, `cargaHoraria`, `salario`, `id_pessoa`) VALUES (NULL, '22:00', '2000.00', '2');
INSERT INTO ALUNO (`aluno_id`, `id_curso`, `id_pessoa`) VALUES (NULL, '3', '2');
INSERT INTO MATRICULA (`id_matricula`, `id_professor`, `id_aluno`, `horario_inicio`, `horario_termino`) VALUES (NULL, '5', '2', '19:00', '23:00');
-- CONSULTA SIMPLES -----------------------------------------------------------------------------------------------------------------
SELECT * FROM LOGIN;
SELECT * FROM REGISTRO;
SELECT * FROM ESTADO;
SELECT * FROM CIDADE;
SELECT * FROM BAIRRO;
SELECT * FROM DISCIPLINA;
SELECT * FROM CURSOS;
SELECT * FROM LOGRADOR;
SELECT * FROM CURSOS_DISCIPLINA;
SELECT * FROM PESSOA;
select * FROM PROFESSOR;
select * FROM ALUNO;
SELECT * FROM MATRICULA;
-- CONSULTA AVANÇADA DOS ALUNOS MATRICULADOS -----------------------------------------------------------------------------------------
SELECT MATRICULA.ID_MATRICULA AS RA, PESSOA.NOME,PESSOA.RG,PESSOA.CPF,CURSOS.NOME_CURSOS AS CURSO,CURSOS.CARGAHORARIO
	FROM MATRICULA INNER join ALUNO
    ON MATRICULA.ID_ALUNO = ALUNO.ALUNO_ID
    INNER JOIN PESSOA 
    ON ALUNO.ID_PESSOA = PESSOA.ID_PESSOA
    INNER JOIN CURSOS
    ON CURSOS.ID_CURSOS = ALUNO.ID_CURSO
    WHERE PESSOA.ID_PESSOA = '1';
-- CRIAÇAO DE VIEW -------------------------------------------------------------------------------------------------------------------
CREATE VIEW V_ALUNO AS 
	SELECT .ID_MATRICULA AS RA, PESSOA.NOME,PESSOA.RG,PESSOA.CPF,CURSOS.NOME_CURSOS AS CURSO,CURSOS.CARGAHORARIO
	FROM MATRICULA  INNER join ALUNO
    ON MATRICULA.ID_ALUNO = ALUNO.ALUNO_ID
    INNER JOIN PESSOA 
    ON ALUNO.ID_PESSOA = PESSOA.ID_PESSOA
    INNER JOIN CURSOS
    ON CURSOS.ID_CURSOS = ALUNO.ID_CURSO
    WHERE PESSOA.ID_PESSOA = '1';
-- CONSULTA AVANÇADA -----------------------------------------------------------------------------------------------------------------
SELECT LOGIN.ID_LOGIN AS ID, LOGIN.USUARIO,LOGIN.SENHA, LOGIN.NIVEL AS NIVEL_DE_PREMICAO
,REGISTRO.DATAREGI AS DATA_LOGADA, REGISTRO.HORARIO AS HORA_LOGADA 
	FROM LOGIN inner JOIN REGISTRO 
    ON LOGIN.ID_LOGIN = REGISTRO.ID_LOGIN;

-- CONSULTA AVANÇADA COM CRIAÇÃO DE VIEW ----------------------------------------------------------------------------------------------
CREATE VIEW V_PESQUISAlOGIN AS 
	SELECT LOGIN.ID_LOGIN AS ID,LOGIN.USUARIO,LOGIN.SENHA,LOGIN.NIVEL AS NIVEL_DE_PREMICAO
	,REGISTRO.DATAREGI AS DATA_LOGADA,REGISTRO.HORARIO AS HORA_LOGADA 
		FROM LOGIN inner JOIN REGISTRO 
		ON LOGIN.ID_LOGIN = REGISTRO.ID_LOGIN;

-- EXECUTANDO A VIEW -------------------------------------------------------------------------------------------------------------------
SELECT * FROM V_PESQUISALOGIN;
SELECT * FROM V_ALUNO;