if exists (select name from sysobjects where name = 'EditarOrdem')
	drop trigger EditarOrdem

go

create trigger EditarOrdem on [orders]
for update
as
declare @OrderID char(5)
select @OrderID = OrderID from Inserted
update Orders set EditadoEm=getdate(), EditadoPor=user
where Orders.OrderID = @OrderID
