USE PUBS

IF EXISTS (SELECT Name FROM SysObjects WHERE Name = 'LivrosRoyalties')
	DROP PROCEDURE LivrosRoyalties

GO

CREATE PROCEDURE LivrosRoyalties
AS
SET NOCOUNT ON
EXECUTE CriarCursorTitulos

CREATE TABLE #tmpTable
	(
	fld_Title varchar(80),
	fld_TotRoys money
	)
OPEN Sales
	DECLARE @TitleID char(6), @Title varchar(80), @TitlePrice float, @TitleSales int
	DECLARE @Low int, @Hi int, @Royalty int
	DECLARE @CurrentTitle varchar(80)
	DECLARE @PreviousLow int
	DECLARE @BookRoyalties float

	SET @PreviousLow = 0
	SET @BookRoyalties = 0

	FETCH NEXT FROM Sales INTO @TitleID, @Title, @TitleSales, @TitlePrice, @Low, @Hi, @Royalty
	SET @CurrentTitle = @Title
	WHILE @@FETCH_STATUS = 0
	BEGIN
		If @Title <> @CurrentTitle
		BEGIN
			INSERT #tmpTable VALUES (@CurrentTitle, @BookRoyalties)
			SET @CurrentTitle = @Title
			SET @PreviousLow = 0
			SET @BookRoyalties = 0
		END
		If @TitleSales < @hi
		BEGIN
			IF @Low <= @TitleSales
				SET @BookRoyalties = @BookRoyalties + @TitlePrice * (@TitleSales - @PreviousLow) * @Royalty / 100.0
		END
		ELSE
		BEGIN
			SET @BookRoyalties = @BookRoyalties + @TitlePrice * (@hi - @PreviousLow) * @Royalty / 100.0
			SET @PreviousLow = @hi
		END
		FETCH NEXT FROM Sales INTO @TitleID, @Title, @TitleSales, @TitlePrice, @Low, @hi, @Royalty
	END
	INSERT #tmpTable VALUES (@CurrentTitle, @BookRoyalties)
CLOSE Sales
SELECT * FROM #tmpTable
DEALLOCATE Sales