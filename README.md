# CRUD SQL server
 
Nesse repositório você encontrará um CRUD (Create, Read, Update and delete) e outros comandos SQL para Microsoft SQL Server.

O arquivo contem a base de dados para que sejam realizadas as consultas. 
The archive have the database to realize the querys.

## Passo a passo com imagens (Step by step with images)

1. Criar duas tabelas uma com 7 colunas e outra com apenas uma. (Create two tables, one with 7 columns and other with only one).

```
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

```
CREATE TABLE PILOTOS2
  (
    PILOTOID INT identity (1,1) FOREIGN KEY REFERENCES PILOTOS(PILOTOID),
    EQUIPE VARCHAR (30)
  );
  ```
  
  imagens :
  ![texto](url "título")
