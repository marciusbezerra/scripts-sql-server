if exists (select name from sysobjects where name = 'NovaOrdem')
	drop trigger NovaOrdem

go

create trigger NovaOrdem on [Orders]
for insert
as
declare @NovaOrdemID char(5)
select @NovaOrdemID = OrderID from Inserted
update Orders SET CriadoEm=getdate(), CriadoPor=user
where Orders.OrderID = @NovaOrdemID