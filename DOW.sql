CREATE PROCEDURE AdicionarProduto
@NomeDoProduto           nvarchar(40),
@CodigoDoFornecedor      int,
@CodigoDaCategoria       int,
@QuantidadePorUnidade    nvarchar(20),
@PrecoUnitario           money

AS

DECLARE @Erro            int

INSERT Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice)
         VALUES (@NomeDoProduto, @CodigoDoFornecedor, @CodigoDaCategoria, @QuantidadePorUnidade, @PrecoUnitario)

SET @Erro = @@ERROR

IF (@Erro = 0)
	RETURN (@@Identity)
ELSE
	RETURN (-@Erro)

GO


CREATE PROCEDURE AtualizarProduto
@CodigoDoProduto        int,
@NomeDoProduto          nvarchar(40),
@CodigoDoFornecedor     int,
@CodigoDaCategoria      int,
@QuantidadePorUnidade   nvarchar(20),
@PrecoUnitario          money

AS

DECLARE @Erro           int

UPDATE Products SET 
	ProductName = @NomeDoProduto,
	SupplierID = @CodigoDoFornecedor,
	CategoryID = @CodigoDaCategoria,
	QuantityPerUnit = @QuantidadePorUnidade,
	UnitPrice = @PrecoUnitario
WHERE ProductID = @CodigoDoProduto

SET @Erro = @@ERROR

IF (@Erro = 0)
	RETURN (0)
ELSE
	RETURN (@Erro)

GO

CREATE PROCEDURE DeletarProduto
@CodigoDoProduto int

AS

DELETE FROM Products WHERE ProductID = @CodigoDoProduto

GO

CREATE Procedure Procurafornecedor AS
SELECT SupplierID, CompanyName FROM Suppliers

GO

CREATE PROCEDURE ProcuraCategoria AS 
SELECT CategoryID, CategoryName FROM Categories