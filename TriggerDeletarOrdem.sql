if exists (select name from sysobjects where name = 'DeletarOrdem')
	drop trigger DeletarOrdem

go

create trigger DeletarOrdem on [Orders]
for delete
as
declare @delOrderID int
declare @delClienteID char(5)
declare @delDataOrdem datetime

select @delOrderID = OrderID from Deleted
select @delClienteID = CustomerID from Deleted
select @delDataOrdem = OrderDate from Deleted

insert Delecoes (DeletadoEm, DeletadoPor, delOrdemID, delClienteID, delDataOrdem)
	 values (getdate(), user, @delOrderID, @delClienteID, @delDataOrdem)