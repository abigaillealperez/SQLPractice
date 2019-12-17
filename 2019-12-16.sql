--2019-12-16
--2.3 DESIG USERS DESIGNED FUNCTIONS
--SACALAR-VALUED USER-DEFINED FUNTIONS


CREATE FUNCTION Sales.Customers_ReturnOrderCount --
(
	@CustomerID int,
	@OrderDate date = NULL --Both are the PARAMETERS
)
RETURNS INT --/RETURN TYPE
WITH RETURNS NULL ON NULL INPUT, --IF ALL PARAMETERS NULL, RETURN NULL INMEDIATELY
	SCHEMABINDING --MAKE CERTAIN TAHAT THE TABLES/COLUMNS REFERENCED CANNOT CHANGE
AS
	BEGIN --from declare to return= FUNTION BODY
		DECLARE @OutputValue int

		SELECT @OutputValue = COUNT(*)
		FROM Sales.Orders
		WHERE @CustomerID = @CustomerID
		AND (OrderDate = @OrderDate
			OR @OrderDate IS NULL);

		RETURN @OutputValue --/RETURN VALUE
	END;
GO

SELECT Sales.Customers_ReturnOrderCount(905, '2013-01-01'); --ROJO ES LA ordedate y 905 el customersID
GO

SELECT Sales.Customers_ReturnOrderCount(905, DEFAULT);
GO

SELECT CustomerID, Sales.Customers_ReturnOrderCount(CustomerID, DEFAULT) AS TotalOrders
FROM Sales.Customers;
GO

CREATE FUNCTION Sales.Orders_ReturnFormattedCPO
(
	@CustomerPurchaseOrderNumber nvarchar(20)
)
RETURNS ANVARCHAR(20)
WITH RETURNS NULL ON NULL INPUT,
	SCHEMABINDING
AS
BEGIN
	RETURN (N'CPO' + RIGHT(N'00000000' + @CustomerPurchaseOrderNumber,8));
END;
GO

SELECT Sales.Orders_ReturnFormattedCPO('12345') as CustomerPurchaseOrderNumber;
GO

SELECT OrderId
FROM Sales.Orders
WHERE Sales.Orders_returnFormattedCPO(CustomerPurchaseOrderNumber) = 'CPO00019998';
GO

---
CREATE FUNCTION Sales.Customers_ReturnOrderCountSetSimple
(
	@CustomerID int,
	@OrderDate date = NULL
)
RETURNS TABLE
AS
RETURN (SELECT COUNT(*) AS SalesCount,
				CASE WHEN MAX(BackOrderOrderId) IS NOT NULL
							THEN 1 ELSE 0 END AS HasBaclorderFalg
		FROM Sales.Orders
		WHERE CustomerID = @CustomerID
		AND (OrderDate = @OrderDate
			OR @OrderDate IS NULL));
GO


