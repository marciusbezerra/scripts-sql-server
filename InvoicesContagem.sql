
use northwind

select customers.companyname, orders.orderid
from customers, orders
where customers.customerid = orders.customerid
order by customers.customerid
compute count(orders.orderid) by customers.customerid