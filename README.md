# CRUD SQL server
 
Nesse repositório você encontrará um CRUD (Create, Read, Update and delete) e outros comandos SQL para Microsoft SQL Server feitos com informaçõees de pilotos de fórmula 1 com algumas alterações. 
O arquivo contem a base de dados para que sejam realizadas as consultas. 

*In this repository you will find a CRUD (Create, Read, Update and Delete) and other SQL commands for Microsoft SQL Server made with information from formula 1 drivers with some changes.The file contains the database for queries.*

## Dicas de uso 
Para conseguir realizar as QUErys é necessário que comece pelo passo 1 e 4 onde você irá criar e inserir valores em uma tabela. 
A legenda PT-EN se encontra no final da página para que haja melhor compreenção de nomes de colunas.

## Usage tips
In order to be able to carry out the QUErys it is necessary to start with step 1 and 4 where you will create and insert values in a table.
The PT-EN caption is at the bottom of the page for better understanding of column names.

## Passo a passo com imagens dos resultados esperados
(Step by step with images of expected results)

**1. Criar duas tabelas uma com 7 colunas e outra com apenas uma.**

*Create two tables, one with 7 columns and other with only one.*


```SQL
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
```

```SQL
CREATE TABLE PILOTOS2
  (
    PILOTOID INT identity (1,1) FOREIGN KEY REFERENCES PILOTOS(PILOTOID),
    EQUIPE VARCHAR (30)
  );
  ```
  
 **2. O tipo da coluna 'SALARIO' deverá ser alterada para DECIMAL**
 
 *The type of column 'SALARIO' must be changed to DECIMAL*
  
 ```SQL
 ALTER TABLE PILOTOS
 ALTER COLUMN SALARIO DECIMAL(10,2)
 ```
 
 **3. Será alterado o nome de uma coluna afim de economizar espaço. 'NASCIMENTO' para 'NASC'.**
 
 *A column name will be changed in order to save space. 'NASCIMENTO' to 'NASC'.*
 
```SQL 
 EXEC sp_RENAME 'PILOTOS.NASCIMENTO','NASC','COLUMN'
 ```
 
 **4. Serão inseridos os seguintes dados dados**
 
 *The following data will be entered*
    

```SQL
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
```
 
 ```SQL
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
 ```
 
**Um SELECT deverá ser feito para conferir os valores inseridos na tabela**

*A SELECT must be done to check the values inserted in the table*

```SQL
SELECT *FROM PILOTOS	
select* from PILOTOS2
```
<img src="img/SELECT.png" align="center" width="700">
<img src="img/SELECT 2.png" align="center" width="700">

 
**5. A linha com ID 11 deverá ser exclui da tabela PILOTOS**

*The line with ID 11 must be excluded from the PILOTOS table*

```sql
Delete 
from PILOTOS
WHERE pilotoid = 11
```


**6. Uma visualização unindo todas as informações de PILOTOS e PILOTOS2 foi criada**

*A view uniting all information from PILOTOS and PILOTOS2 was created*

```slq
select *
from PILOTOS P1
JOIN PILOTOS2 P2
ON P1.PILOTOID=P2.PILOTOID
```

<img src="img/JOIN.png" align="center" width="700">

**7. É percebido que não se tem um valor único de salário, logo, será calculado o valor total de salário de cada piloto na coluna 'Salário total'**

*The total salary value of each pilot will be calculated in the 'Salário total' column*
```sql
SELECT NOME, SALARIO + BONUS AS 'Salário total'
FROM PILOTOS 
```
<img src="img/SALARIO_TOTAL.png" align="center" width="700">

**8. A média de salários será calculada na coluna Média salarial**

*The average salary will be calculated in the Média salarial column*
```sql
SELECT AVG(salario+bonus) AS 'Média Salarial Total'
from PILOTOS
```
<img src="img/AVG_SALÁRIO.png" align="center" width="700">

**9. É notado que não se sabe a idade do piloto, apenas sua data de nascimento, logo, será calculada sua data de nascimento.**

*As the age of the pilot is not known, only his date of birth, the date of birth will be calculated.*
```sql
SELECT DATEPART(YEAR,EOMONTH (GETDATE ())) -DATEPART(YEAR,nasc) AS Idade
FROM PILOTOS 
```
<img src="img/IDADE.png" align="center" width="700">

**10. Para melhor visualização serão concatenados nome e sobrenome.**

*For better visualization, NOME and SOBRENOME will be concatenated.*

```sql
SELECT CONCAT(nome, ' ', sobrenome) as 'Nome completo'
from PILOTOS
```

<img src="img/NOME_COMPLETO.png" align="center" width="700">

**11. Apresentação de nome e sobrenome com idade.**

*Presentation of name and surname with age.*

```sql
SELECT CONCAT(nome, ' ', sobrenome) as 'Nome completo', DATEPART(YEAR,EOMONTH (GETDATE ())) -DATEPART(YEAR,nasc) AS Idade
FROM PILOTOS 
```

<img src="img/NOME_IDADE.png" align="center" width="700">

**12. Serão contados quantos pilotos pertencem a mesma nacionalidade.**

*Pilots belonging to the same nationality will be counted.*

```sql
SELECT count(nacionalidade),nacionalidade
FROM PILOTOS
GROUP BY nacionalidade 
HAVING COUNT(nacionalidade) > 1
```

<img src="img/NACIONALIDADE_REPETIDA.png" align="center" width="700">


## Subtitle PT-EN

PILOTOS = PILOT (F1 DRIVER)
NOME = NAME
SOBRENOME = LAST NAME
NACIONALIDADE = NATIONALITY
NASCIMENTO = BIRTH
SALARIO = SALARY
BONUS = BONUS 
EQUIPE = TEAM
NASC = SHORT FOR NASCIMENTO
SALÁRIO TOTAL = TOTAL SALARY 
MÉDIA SALARIAL = AVERAGE WAGE
IDADE = AGE













