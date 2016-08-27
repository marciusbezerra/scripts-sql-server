
use northwind

if exists (select name from sysobjects where name = 'TodasAsFaturas')
	drop procedure TodasAsFaturas

go

create procedure TodasAsFaturas
as
select companyname, orders.orderid, productname, round([order details].unitprice, 2) as unitprice,
quantity, convert(int, discount * 100) as discount,
round(convert(money, quantity * (1 - discount) * [order details].unitprice), 2) as extendedprice

from products, [order details], customers, orders

where [order details].productid = products.productid and
[order details].orderid = orders.orderid and
orders.customerid = customers.customerid

order by customers.customerid, orders.orderid

compute sum(round(convert(money, quantity * (1 - discount) * [order details].unitprice), 2))
by customers.customerid, orders.orderid

compute sum(round(convert(money, quantity * (1 - discount) * [order details].unitprice), 2)) 
by customers.customerid

execute TodasAsFaturas