use Northwind

if exists (select name from sysobjects where name = 'NovaOrdemComDetalhes')
	drop procedure NovaOrdemComDetalhes

go

create procedure NovaOrdemComDetalhes

@ClienteID 		nchar(5),
@FuncionarioID 		int,
@DataOrdem 		datetime,
@TranportadoraID 	int,
@Detalhes 		varchar(1000)

as

declare @Erro              int
declare @OrderID           int
declare @ClienteCompanhia  nvarchar(40)
declare @ClienteEndereco   nvarchar(60)
declare @ClienteCidade     nvarchar(15)
declare @ClienteRegiao     nvarchar(15)
declare @ClienteCPostal    nvarchar(10)
declare @ClientePais       nvarchar(15)

select @ClienteCompanhia=CompanyName,
	@ClienteEndereco=Address,
	@ClienteCidade=City,
	@ClienteRegiao=Region,
	@ClienteCpostal=PostalCode,
	@ClientePais=Country
	from Customers where CustomerID = @ClienteID

if @@rowcount = 0
	return (-100)

select * from Employees where EmployeeID = @FuncionarioID
if @@rowcount = 0 
	return (-101)

select * from Shippers where ShipperID = @TranportadoraID
if @@rowcount = 0 
	return (-102)


BEGIN TRANSACTION

insert Orders (CustomerID, EmployeeID, OrderDate, ShipVia, ShipName, ShipAddress, ShipCity, ShipRegion,
		ShipPostalCode, ShipCountry)
	values (@ClienteID, @FuncionarioID, @DataOrdem, @TranportadoraID, @ClienteCompanhia,
		@ClienteEndereco, @ClienteCidade, @ClienteRegiao, @ClienteCPostal, @ClientePais)

set @Erro=@@Error

if (@Erro <> 0)
begin
	ROLLBACK TRANSACTION
	return (-@Erro)
end

set @OrderID=@@IDENTITY

declare @TotLinhas int
declare @CurLinha  int

set @CurLinha=0

set @TotLinhas=ceiling(len(@Detalhes)/18)

declare @Qtd         smallint
declare @Desconto    real 
declare @Preco       money
declare @CodProduto  int

while @CurLinha <= @TotLinhas
begin
	set @CodProduto=substring(@Detalhes, @CurLinha * 18 + 1, 6)
	set @Qtd=substring(@Detalhes, @CurLinha * 18 + 7, 6)
	set @Desconto=substring(@Detalhes, @CurLinha * 18 + 13, 6)

	set @CurLinha=@CurLinha + 1

	select @Preco = UnitPrice from Products where ProductID = @CodProduto

	insert [Order Details] (OrderID, ProductID, Quantity, UnitPrice, Discount)
		values (@OrderID, @CodProduto, @Qtd, @Preco, @Desconto)

	set @Erro=@@Error

	if (@Erro <> 0) goto OcorreuErro
end

COMMIT TRANSACTION

return (0)

OcorreuErro:

ROLLBACK TRANSACTION

return (@Erro)