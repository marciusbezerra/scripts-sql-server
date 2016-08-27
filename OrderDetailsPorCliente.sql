
use northwind

select companyname, SUM([Order Details].UnitPrice * Quantity * (1 - Discount))
FROM products, [order details], customers, orders
where [order details].productid = products.productid and
[order details].orderid = orders.orderid and
orders.customerid = customers.customerid
group by companyname
order by companyname