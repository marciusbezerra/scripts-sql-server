use Northwind

IF EXISTS (SELECT Name FROM SysObjects WHERE Name = 'MediaDiariaDeOrdens')
	DROP PROCEDURE MediaDiariaDeOrdens

GO

CREATE PROCEDURE MediaDiariaDeOrdens
@MediaDiariaDeOrdens float OUTPUT
AS
EXECUTE CriarCursorSales

OPEN Sales
	DECLARE @Cliente nvarchar(40), @ClienteID nchar(5)
	DECLARE @Ordem int, @Data datetime
	DECLARE @ClienteAtual varchar(40)
	DECLARE @ClienteIDAtual nchar(5)
	DECLARE @DataAnterior datetime, @Dias int, @TotalDias int
	DECLARE @Clientes int
	DECLARE @Ordens int
	DECLARE @DifMedia float

	FETCH NEXT FROM Sales INTO @Cliente, @ClienteID, @Ordem, @Data

	SET @ClienteAtual = @Cliente
	SET @ClienteIDAtual = @ClienteID
	SET @DataAnterior = @Data
	SET @TotalDias = 0
	SET @Ordens = 0
	SET @DifMedia = 0
	SET @Clientes = 0

	WHILE @@FETCH_STATUS = 0
	BEGIN
		FETCH NEXT FROM Sales INTO @Cliente, @ClienteID, @Ordem, @Data
		IF @Cliente = @ClienteAtual
		BEGIN
			SET @Dias = DATEDIFF(day, @DataAnterior, @Data)
			SET @TotalDias = @TotalDias + @Dias
			SET @Ordens = @Ordens + 1
			SET @DataAnterior = @Data
		END
		ELSE
		BEGIN
			IF @Ordens > 0 
				SET @DifMedia = @DifMedia + CONVERT(float, @TotalDias) / CONVERT(float, @Ordens)
			SET @ClienteAtual = @Cliente
			SET @ClienteIDAtual = @ClienteID
			SET @DataAnterior = @Data
			SET @TotalDias = 0
			SET @Ordens = 0
			SET @Clientes = @Clientes + 1
		END
	END
CLOSE Sales
DEALLOCATE Sales
SELECT @MediaDiariaDeOrdens = @DifMedia / @Clientes