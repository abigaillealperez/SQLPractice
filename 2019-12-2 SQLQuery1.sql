SELECT * FROM Sales.Orders 

SELECT *
FROM Sales.CustomerTransactions
WHERE PaymentMethodID = 4;

SELECT CustomerID, OrderID, OrderDate, ExpectedDeliveryDate
FROM Sales.Orders
WHERE CustomerPurchaseOrderNumber = '16374'

SELECT SalespersonPersonId, OrderDate
FROM Sales.Orders
ORDER BY SalespersonPersonID ASC, OrderDate DESC;

--DROP INDEX SalespersonPersonId_OrderDate ON Sales.Orders
CREATE INDEX SalespersonPersonID_OrderDate1 ON Sales.Orders
(SalespersonPersonID ASC, OrderDate DESC);

SELECT OrderId, OrderDate, ExpectedDeliveryDate, People.FullName
FROM Sales.Orders
	JOIN Application.People
		ON People.PersonID = Orders.ContactPersonID
WHERE PreferredName = 'Aakriti';

SELECT Orders.ContactPersonId, People.PreferredName
FROM Sales.Orders
	JOIN Application.People
		ON People.PersonID = Orders.ContactPersonID
WHERE PreferredName = 'Aakriti';

CREATE NONCLUSTERED INDEX ContractPersonID_Include_OrderDate_ExpectedDeliveryDate 
ON Sales.Orders (ContactPersonID)
INCLUDE (OrderDate, ExpectedDeliveryDate)
ON USERDATA;
GO