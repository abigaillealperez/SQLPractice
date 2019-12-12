--2019-12-11
--2.2 CREATE STORE PROCEDURES

CREATE TABLE Examples.SimpleTable
(
	SimpleTableId int NOT NULL IDENTITY(1,1)
				CONSTRAINT PKSimpleTable PRIMARY KEY,
	Value1 varchar(20) NOT NULL,
	VAlue2 varchar(20) NOT NULL
);

CREATE PROCEDURE Examples.SimpleTable_Insert
	--@SimpleTableId int, --not needed
	@Value1 varchar(20),
	@Value2 varchar(20)
AS
	INSERT INTO Examples.SimpleTable(Value1, Value2)
	VALUES (@Value1, @Value2);
GO

EXEC Examples.SimpleTable_Insert 'MY VALUE 1', 'MY VALUE 2'
--EXEC Examples.SimpleTable_Insert 0, 'MY VALUE 1', 'MY VALUE 2'
--por si no se tiene valor en el primer elemento que no usamos

SELECT * FROM Examples.SimpleTable

--CREATE STORED PROCEDURES FOR UPDATE AND DELETE

CREATE PROCEDURE Examples.SimpleTable_Update
	@SimpleTableId int,
	@Value1 varchar(20),
	@Value2 varchar(20)
AS

	UPDATE Examples.SimpleTable
	SET Value1 = @Value1,
		Value2 = @Value2
	WHERE SimpleTableId = @SimpleTableId
GO

EXEC Examples.SimpleTable_Update 1, 'NEW VALUE 1', 'NEW VALUE2';   --Parameters????

SELECT * FROM Examples.SimpleTable

CREATE PROCEDURE Examples.SimpleTable_Delete
	@simpleTableId int
AS
	DELETE FROM Examples.SimpleTable
	WHERE SimpleTableId = @SimpleTableId
GO

EXEC Examples.SimpleTable_Delete 1;
--HERE WE ONLY TYPE THE ROW TO ERRASE

SELECT * FROM Examples.SimpleTable

--STORE PROCEDURES BASED ON REQUIREMENTS
CREATE PROCEDURE Examples.SimpleTable_Select
AS
	SELECT SimpleTableId, Value1, Value2
	FROM Examples.SimpleTable
	ORDER BY Value1;

CREATE PROCEDURE Examples.SimpleTable_SelectValue1StartWithQorZ
AS
	SELECT SimpleTableId, Value1, Value2
	FROM Examples.SimpleTable
	WHERE Value1 LIKE 'Q%'
	ORDER BY Value1;

	SELECT SimpleTableId, Value1, Value2
	FROM Examples.SimpleTable	
	WHERE Value1 LIKE 'Z%'
	ORDER BY Value1 DESC;

GO

INSERT INTO Examples.SimpleTable
VALUES ('EL', 'SALON'),('APESTA', 'HORRIBLE'),('SAQUENME', 'DE AQUI PLI')

EXEC Examples.SimpleTable_SelectValue1StartWithQorZ