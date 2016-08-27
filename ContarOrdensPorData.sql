if exists (select * from sysobjects where name = 'CountarOrdensPorData')
	drop procedure CountarOrdensPorData

go

create procedure CountarOrdensPorData
@DataInicial datetime, @DataFinal datetime,
@Contagem int OUTPUT
as
SELECT @Contagem = count(OrderID) FROM Orders where OrderDate between @DataInicial and @DataFinal