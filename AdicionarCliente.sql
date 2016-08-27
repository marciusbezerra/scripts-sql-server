USE NORTHWIND
IF EXISTS (SELECT name FROM sysobjects 
        WHERE name = 'AdicionarCliente')
    DROP PROCEDURE AdicionarCliente
GO

CREATE PROCEDURE AdicionarCliente
      @custID nchar(5), @custName nvarchar(40), 
      @custContact nvarchar(30), @custTitle nvarchar(30), 
      @custAddress nvarchar(60), @custcity nvarchar(15), 
      @custRegion nvarchar(15), @custPostalCode nvarchar(10),
      @custCountry nvarchar(15), 
      @custPhone nvarchar(24), @custFax nvarchar(24) 
AS
DECLARE @ErrorCode int
INSERT Customers (CustomerID, CompanyName, ContactName, 
                  ContactTitle, Address, City, Region, 
                  PostalCode, Country, Phone, Fax) 
VALUES (@custID, @custName, @custContact, 
        @custTitle, @custAddress,
        @custCity, @custRegion, @custPostalCode, @custCountry, 
        @custPhone, @custFax)
SET @ErrorCode=@@ERROR
--Tratamento de do SQL Server 
if @ErrorCode = 2627
begin
	raiserror ("O código do cliente já existe", 18, 127)
	return (2627)
end
-----------------------------------

IF (@ErrorCode = 0)
   RETURN (0)
ELSE
   RETURN (@ErrorCode)
