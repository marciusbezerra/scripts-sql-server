USE northwind

select CompanyName, Orders.OrderID, SUM([Order Details].UnitPrice * Quantity * (1 - Discount))
FROM Products, [Order Details], Customers, Orders
WHERE [Order Details].ProductID = Products.ProductID AND [Order Details].OrderID = Orders.OrderID AND
Orders.CustomerID = Customers.CustomerID
Group by companyname, Orders.OrderID
Order by companyname, Orders.OrderID 