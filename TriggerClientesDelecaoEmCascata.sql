if exists (select name from sysobjects where name = 'ClientesDelecaoEmCascata')
	drop trigger ClientesDelecaoEmCascata

go

create trigger ClientesDelecaoEmCascata on Customers
for delete
as
declare @ClienteID nchar(5)
select @ClienteID = CustomerID from Deleted

delete from Orders where CustomerID = @ClienteID