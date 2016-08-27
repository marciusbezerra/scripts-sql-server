USE Northwind

IF EXISTS (SELECT Name FROM SysObjects WHERE Name = 'MediaEmDias')
	DROP PROCEDURE MediaEmDias

GO

CREATE PROCEDURE MediaEmDias
AS
SET NOCOUNT ON
EXECUTE CriarCursorSales

CREATE TABLE #tmpTable
	(
	fld_CustID	nchar(5),
	fld_CustName	nvarchar(40),
	fld_AvgDiff	float
	)

OPEN Sales
	DECLARE @Customer nvarchar(40), @CustomerID nchar(5), @Order int, @Date datetime
	DECLARE @CurrentCustomer varchar(40), @CurrentCustomerID nchar(5)
	DECLARE @PreviousDate datetime, @Days int, @totalDays int

	DECLARE @Orders int
	DECLARE @AvgDiff float

	FETCH NEXT FROM Sales INTO @Customer, @CustomerID, @Order, @Date
	SET @CurrentCustomer = @Customer
	SET @CurrentCustomerID = @CustomerID
	SET @PreviousDate = @Date
	SET @TotalDays = 0
	SET @Orders = 0

	WHILE @@FETCH_STATUS = 0
	BEGIN
		FETCH NEXT FROM Sales INTO @Customer, @CustomerID, @Order, @Date
		IF @Customer = @CurrentCustomer
		BEGIN
			SET @Days = DATEDIFF(day,@PreviousDate,@Date)
			SET @TotalDays = @TotalDays + @Days
			SET @Orders = @Orders + 1
			SET @PreviousDate = @Date
		END
		ELSE
		BEGIN
			IF @Orders <> 0 
				SET @AvgDiff = CONVERT(float, @TotalDays) / CONVERT(float, @Orders)
			ELSE
				SET @AvgDiff = 0
			INSERT #tmpTable VALUES (@CurrentCustomerID, @CurrentCustomer, @AvgDiff)
			SET @CurrentCustomer = @Customer
			SET @CurrentCustomerID = @CustomerID
			SET @TotalDays = 0
			SET @Orders = 0
			SET @PreviousDate = @Date
		END
	END
CLOSE Sales
SELECT * FROM #tmpTable
DEALLOCATE Sales