if exists (select name from sysobjects where name = 'OrdemDelecaoEmCascata')
	drop trigger OrdemDelecaoEmCascata

go

create trigger OrdemDelecaoEmCascata on [Orders]
for delete
as
declare @OrderID int
select @OrderID = OrderID from deleted
delete from [Order Details] where OrderID = @OrderID