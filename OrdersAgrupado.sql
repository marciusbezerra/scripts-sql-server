use northwind

select companyname as [Nome da companhia], orders.orderid as [N.F.], productname as [Produto], round([order details].unitprice, 2) as [Preço unitário],
quantity as Quantidade, convert(int, discount * 100) as [Desconto (%)], 
round(convert(money, quantity * (1 - discount) * [order details].unitprice),2) as [Sub-total]
from products, [order details], customers, orders

where [order details].productid = products.productid and
[order details].orderid = orders.orderid and
orders.customerid = customers.customerid
order by customers.customerid, orders.orderid

compute sum(round(convert(money, quantity * (1 - discount) * [order details].unitprice), 2))
by customers.customerid, orders.orderid

compute sum(round(convert(money, quantity * (1 - discount) * [order details].unitprice), 2))
by customers.customerid