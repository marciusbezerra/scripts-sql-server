
use northwind

if exists (select name from sysobjects where name = 'OrdensPorData')
	drop procedure OrdensPorData

go

create procedure OrdensPorData
@DataInicial datetime, @DataFinal datetime
as
select * from orders where orderdate between @DataInicial and @DataFinal