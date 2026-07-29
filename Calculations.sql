SELECT COUNT(*) FROM Orders
SELECT COUNT(*) FROM OrderDetails
SELECT COUNT(*) FROM Pizzas
SELECT COUNT(*) FROM PizzaTypes

SELECT * FROM Orders
SELECT * FROM OrderDetails
SELECT * FROM Pizzas
SELECT * FROM PizzaTypes

-- JOINS

SELECT * FROM Orders O
LEFT JOIN OrderDetails OD
ON O.OrderID=od.OrderID

SELECT COUNT(*) AS [Pizzas Sold] FROM Orders O
LEFT JOIN OrderDetails OD
ON O.OrderID=od.OrderID
WHERE O.Date = '2015-01-01' 

SELECT * FROM Orders O
LEFT JOIN OrderDetails OD
ON O.OrderID=od.OrderID
WHERE OD.PizzaType LIKE '%hawaiian_m%'

SELECT * FROM Pizzas P
LEFT JOIN PizzaTypes PT
ON PT.PizzaTypeID=P.PizzaTypeID

SELECT * FROM Orders O
LEFT JOIN OrderDetails OD
ON OD.OrderID = O.OrderID
LEFT JOIN Pizzas P
ON P.PizzaID = OD.PizzaID
LEFT JOIN PizzaTypes PT
ON PT.PizzaTypeID = P.PizzaTypeID

-- CREATE VIEW PizzaSales AS
SELECT O.OrderID,OD.OrderDetailsID,P.PizzaID,PT.PizzaTypeID,
O.Date,O.Time,
PT.PizzaType,P.Size,
PT.Name,PT.Ingredients,PT.Category,P.Price,OD.Quantity,
OD.Quantity*P.Price AS LineTotal  FROM Orders O
LEFT JOIN OrderDetails OD
ON OD.OrderID = O.OrderID
LEFT JOIN Pizzas P
ON P.PizzaID = OD.PizzaID
LEFT JOIN PizzaTypes PT
ON PT.PizzaTypeID = P.PizzaTypeID

SELECT * FROM PizzaSales

-- INSIGHTS

SELECT SUM(LineTotal) AS [Total Revenue] FROM PizzaSales

SELECT COUNT(*) AS [Total Orders] FROM Orders	

SELECT SUM(Quantity) AS [Total Pizzas Sold] FROM OrderDetails

SELECT SUM(LineTotal) / COUNT(DISTINCT OrderID) AS AverageOrderValue FROM PizzaSales

SELECT SUM(Quantity) * 1.0 / COUNT(DISTINCT OrderID) AS AveragePizzasPerOrder FROM PizzaSales

-- Page 1

SELECT DATENAME(MONTH, Date) AS MonthName,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales 
GROUP BY MONTH(Date),DATENAME(MONTH, Date) ORDER BY MONTH(Date)

SELECT Category,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales GROUP BY Category

SELECT Size,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales GROUP BY Size

-- Page 2

SELECT DATENAME(MONTH, Date) AS MonthName,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales 
GROUP BY MONTH(Date),DATENAME(MONTH, Date) ORDER BY MONTH(Date)

SELECT DATENAME(MONTH, Date) AS MonthName,COUNT(DISTINCT OrderID) AS TotalOrders FROM PizzaSales
GROUP BY MONTH(Date),DATENAME(MONTH, Date)
ORDER BY MONTH(Date)

SELECT DATENAME(WEEKDAY, Date) AS DayName,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales
GROUP BY DATEPART(WEEKDAY, Date),DATENAME(WEEKDAY, Date)
ORDER BY DATEPART(WEEKDAY, Date)

SELECT DATEPART(HOUR, Time) AS OrderHour,COUNT(DISTINCT OrderID) AS TotalOrders FROM PizzaSales
GROUP BY DATEPART(HOUR, Time) ORDER BY OrderHour

SELECT Size,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales GROUP BY Size

-- Page 3

SELECT TOP 10 NAME,SUM(LineTotal) AS TotalRevenue FROM PizzaSales GROUP BY Name ORDER BY TotalRevenue DESC

SELECT TOP 10 NAME,SUM(LineTotal) AS TotalRevenue FROM PizzaSales GROUP BY Name ORDER BY TotalRevenue ASC

SELECT TOP 10 NAME,SUM(Quantity) AS TotalQuantitySold FROM PizzaSales GROUP BY Name ORDER BY TotalQuantitySold DESC

SELECT TOP 10 NAME,SUM(Quantity) AS TotalQuantitySold FROM PizzaSales GROUP BY Name ORDER BY TotalQuantitySold ASC

-- Page 4

SELECT DATEPART(HOUR, Time) AS OrderHour,COUNT(DISTINCT OrderID) AS TotalOrders FROM PizzaSales
GROUP BY DATEPART(HOUR, Time) ORDER BY OrderHour

SELECT DATENAME(WEEKDAY, Date) AS DayName,COUNT(DISTINCT OrderID) AS TotalOrders FROM PizzaSales
GROUP BY DATEPART(WEEKDAY, Date),DATENAME(WEEKDAY, Date)
ORDER BY DATEPART(WEEKDAY, Date)

SELECT DATENAME(MONTH, Date) AS MonthName,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales 
GROUP BY MONTH(Date),DATENAME(MONTH, Date) ORDER BY MONTH(Date)

SELECT DATENAME(MONTH, Date) AS MonthName,COUNT(DISTINCT OrderID) AS TotalOrders FROM PizzaSales
GROUP BY MONTH(Date),DATENAME(MONTH, Date) ORDER BY MONTH(Date)

-- Extra Insights

SELECT
    CASE
        WHEN DATENAME(WEEKDAY, Date) IN ('Saturday','Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS DayType,SUM(LineTotal) AS Revenue, COUNT(DISTINCT OrderID) AS Orders
FROM PizzaSales
GROUP BY
    CASE
        WHEN DATENAME(WEEKDAY, Date) IN ('Saturday','Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END

SELECT Category,SUM(Quantity) AS TotalQuantitySold FROM PizzaSales
GROUP BY Category ORDER BY TotalQuantitySold DESC

SELECT Size,SUM(Quantity) AS TotalQuantitySold FROM PizzaSales
GROUP BY Size ORDER BY TotalQuantitySold DESC

SELECT Category,SUM(LineTotal) AS Revenue,
ROUND(SUM(LineTotal) * 100.0 /(SELECT SUM(LineTotal) FROM PizzaSales),2) AS RevenuePercentage
FROM PizzaSales GROUP BY Category ORDER BY Revenue DESC

SELECT Size,SUM(LineTotal) AS Revenue,
ROUND(SUM(LineTotal) * 100.0 /(SELECT SUM(LineTotal) FROM PizzaSales),2) AS RevenuePercentage
FROM PizzaSales GROUP BY Size ORDER BY Revenue DESC

SELECT Name,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales GROUP BY Name

SELECT Name,AVG(LineTotal) AS AverageRevenue FROM PizzaSales 
GROUP BY Name ORDER BY AverageRevenue DESC

SELECT DAY(Date) AS DAY,SUM(LineTotal) AS [Total Revenue] FROM PizzaSales GROUP BY DAY(Date) ORDER BY DAY(Date)

SELECT TOP 1 Name,Size,Price FROM PizzaSales ORDER BY Price DESC

SELECT TOP 1 Name,Size,Price FROM PizzaSales ORDER BY Price ASC