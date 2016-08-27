USE Northwind
IF EXISTS (SELECT Name FROM SysObjects WHERE Name = 'CriarCursorSales')
	DROP PROCEDURE CriarCursorSales

GO

CREATE PROCEDURE CriarCursorSales
AS
DECLARE Sales CURSOR FOR
SELECT Customers.CompanyName, Customers.CustomerID, Orders.OrderID, Orders.OrderDate
FROM Customers, Orders
WHERE Orders.CustomerID=Customers.CustomerID
ORDER BY Customers.CustomerID, Orders.OrderID