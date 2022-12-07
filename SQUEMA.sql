--1. Criar uma tabela com 7 colunas

CREATE TABLE PILOTOS
  (
    PILOTOID INT IDENTITY (1,1) PRIMARY KEY,
    NOME VARCHAR(25),
    SOBRENOME VARCHAR(20),
    NACIONALIDADE VARCHAR(20),
    NASCIMENTO DATE,
    SALARIO INT,
    BONUS INT,
  );
  
  --Sera criada também a tabela PILOTOS2 para uso posterior
  
  CREATE TABLE PILOTOS2
  (
    PILOTOID INT identity (1,1) FOREIGN KEY REFERENCES PILOTOS(PILOTOID),
    EQUIPE VARCHAR (30)
  )
  
    
  --2 Inserir valores na tabela, mas antes o tipo da coluna 'salário' deverá ser alterada para DECIMAL.
 ALTER TABLE PILOTOS
 ALTER COLUMN SALARIO DECIMAL(10,2)
 
 --2.1 Será alterado o nome de uma coluna afim de economizar espaço. 'nascimento para 'nasc'.
 EXEC sp_RENAME 'PILOTOS.NASCIMENTO','NASC','COLUMN'
 
 --3 Serão inseridos os dados  
    
Insert into PILOTOS (NOME,SOBRENOME,NACIONALIDADE,NASC,SALARIO,BONUS) 
values ('Kevin', 'Magnussen','Dinamarquês','1992/10/05',6000,1200),
('Pierre', 'Gasly','Francês','1996/02/07',5000,2200),
('Charles', 'Leclerc','Monegasco','1997/10/16',12000,4000),
('Carlos', 'Sainz','Espanhol','1994/09/01',10000,750),
('Lewis', 'Hamilton','Inglês','1985/01/07',40000,9000),
('Max', 'Verstappen','Neerlandês','1997/09/30',25000,6570),
('Sebastian', 'Vettel','Alemão','1987/07/03',15000,990),
('Fernando', 'Alonso','Espanhol','1981/07/29',20000,6700),
('Daniel', 'Ricciardo ','Astraliano','1989/07/01',15000,250),
('Lando', 'Norris ','Astraliano','1999/11/13',20000,97),
('josé', 'silva','portugues','1111/04/05',9000,NULL);

    
Insert into PILOTOS2 (EQUIPE) VALUES ('Haas'),    
('AlphaTauri'),
('Ferrari'),
 ('Ferrari'),  
('Mercedez'),
('Redbull'),
('AstonMartin'), 
 ('Alpine'), 
 ('McLaren'), 
 ('McLaren');
    
--Um SELECT para conferir os valores inseridos na tabela
SELECT *FROM PILOTOS	
select* from PILOTOS2

--4 A linha com ID 11 deverá ser exclui da tabela PILOTOS

Delete 
from PILOTOS
WHERE pilotoid = 11

-- 5 Uma visualização unindo todas as informações de PILOTOS e PILOTOS2 foi criada 
select *
from PILOTOS P1
JOIN PILOTOS2 P2
ON P1.PILOTOID=P2.PILOTOID

-- 6 É percebido que não se tem um valor único de salário, logo, será calculado o valor total de salário de cada piloto na coluna 'Salário total'

SELECT NOME, SALARIO + BONUS AS 'Salário total'
FROM PILOTOS 

-- 7 A média de salários será calculada na coluna Média salarial

SELECT AVG(salario+bonus) AS 'Média Salarial Total'
from PILOTOS

-- 8 É notado que não se sabe a idade do piloto, apenas sua data de nascimento, logo, será calculada sua data de nascimento

SELECT DATEPART(YEAR,EOMONTH (GETDATE ())) -DATEPART(YEAR,nasc) AS Idade
FROM PILOTOS 

-- 9 Para melhor visualização serão concatenados nome e sobrenome 

SELECT CONCAT(nome, ' ', sobrenome) as 'Nome completo'
from PILOTOS

-- 10 Apresentação de nome e sobrenome com idade

SELECT CONCAT(nome, ' ', sobrenome) as 'Nome completo', DATEPART(YEAR,EOMONTH (GETDATE ())) -DATEPART(YEAR,nasc) AS Idade
FROM PILOTOS 

-- 11 Serão contados quantos pilotos pertencem a mesma nacionalidade 

SELECT count(nacionalidade),nacionalidade
FROM PILOTOS
GROUP BY nacionalidade 
HAVING COUNT(nacionalidade) > 1 