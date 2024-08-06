CREATE DATABASE mobile_sales

USE mobile_sales

-- 1. Total Revenue:
SELECT SUM(TotalRevenue) AS TotalRevenue 
FROM mobile_sales;

-- 2. Total Units Sold:
SELECT SUM(UnitsSold) AS TotalUnitsSold 
FROM mobile_sales;

-- 3. Average Price per Mobile Model:
SELECT MobileModel, AVG(Price) AS AveragePrice
FROM mobile_sales
GROUP BY MobileModel;

-- 4. Top 10 Best-Selling Mobile Models:
SELECT MobileModel, SUM(UnitsSold) AS TotalUnitsSold
FROM mobile_sales
GROUP BY MobileModel
ORDER BY TotalUnitsSold DESC
LIMIT 10;

-- 5. Revenue by Brand:
SELECT Brand, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY Brand;

-- 6. Units Sold by Brand:
SELECT Brand, SUM(UnitsSold) AS UnitsSold
FROM mobile_sales
GROUP BY Brand;

-- 7. Sales by Payment Method:
SELECT PaymentMethod, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY PaymentMethod;

-- 8. Average Units Sold per Transaction:
SELECT AVG(UnitsSold) AS AverageUnitsSold
FROM mobile_sales;

-- 9. Revenue by Location:
SELECT Location, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY Location;

-- 10. Average Price by Location:
SELECT Location, AVG(Price) AS AveragePrice
FROM mobile_sales
GROUP BY Location;

-- 11. Revenue by Customer Age Group:
SELECT CASE 
           WHEN CustomerAge < 20 THEN 'Under 20'
           WHEN CustomerAge BETWEEN 20 AND 29 THEN '20-29'
           WHEN CustomerAge BETWEEN 30 AND 39 THEN '30-39'
           WHEN CustomerAge BETWEEN 40 AND 49 THEN '40-49'
           WHEN CustomerAge >= 50 THEN '50 and above'
       END AS AgeGroup, 
       SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY AgeGroup;

-- 12. Revenue by Customer Gender:
SELECT CustomerGender, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY CustomerGender;

-- 13. Most Popular Payment Method:
SELECT PaymentMethod, COUNT(*) AS NumberOfTransactions
FROM mobile_sales
GROUP BY PaymentMethod
ORDER BY NumberOfTransactions DESC
LIMIT 1;

-- 14. Monthly Revenue Trend:
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY Month;

-- 15. Revenue and Units Sold by Brand and Location:
SELECT Brand, Location, SUM(TotalRevenue) AS Revenue, SUM(UnitsSold) AS UnitsSold
FROM mobile_sales
GROUP BY Brand, Location;

-- 16. Top 5 Locations by Revenue:
SELECT Location, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY Location
ORDER BY Revenue DESC
LIMIT 5;

-- 17. Average Revenue per Transaction by Payment Method:
SELECT PaymentMethod, AVG(TotalRevenue) AS AvgRevenue
FROM mobile_sales
GROUP BY PaymentMethod;

-- 18. Customer Age Distribution for Best-Selling Model:
SELECT CustomerAge, SUM(UnitsSold) AS TotalUnitsSold
FROM mobile_sales
WHERE MobileModel = (SELECT MobileModel
                     FROM mobile_sales
                     GROUP BY MobileModel
                     ORDER BY SUM(UnitsSold) DESC
                     LIMIT 1)
GROUP BY CustomerAge;

-- 19. Revenue Contribution by Each Mobile Model:
SELECT MobileModel, (SUM(TotalRevenue) / (SELECT SUM(TotalRevenue) FROM mobile_sales)) * 100 AS RevenuePercentage
FROM mobile_sales
GROUP BY MobileModel;

-- 20. Revenue by Customer Age and Gender:
SELECT CustomerAge, CustomerGender, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY CustomerAge, CustomerGender;

-- 21. Top 5 Mobile Models by Revenue and Units Sold:
SELECT MobileModel, SUM(TotalRevenue) AS TotalRevenue, SUM(UnitsSold) AS TotalUnitsSold
FROM mobile_sales
GROUP BY MobileModel
ORDER BY TotalRevenue DESC
LIMIT 5;

-- 22. Revenue by Mobile Model and Payment Method:
SELECT MobileModel, PaymentMethod, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY MobileModel, PaymentMethod;

-- 23. Revenue Trend Over Time (Yearly):
SELECT YEAR(Date) AS Year, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY Year
ORDER BY Year;

-- 24. Seasonal Sales Trends:
SELECT MONTH(Date) AS Month, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY Month
ORDER BY Month;

-- 25. Revenue and Units Sold by Age Group and Brand:
SELECT CASE 
           WHEN CustomerAge < 20 THEN 'Under 20'
           WHEN CustomerAge BETWEEN 20 AND 29 THEN '20-29'
           WHEN CustomerAge BETWEEN 30 AND 39 THEN '30-39'
           WHEN CustomerAge BETWEEN 40 AND 49 THEN '40-49'
           WHEN CustomerAge >= 50 THEN '50 and above'
       END AS AgeGroup, 
       Brand, 
       SUM(TotalRevenue) AS Revenue, 
       SUM(UnitsSold) AS UnitsSold
FROM mobile_sales
GROUP BY AgeGroup, Brand;

-- 26. Revenue Distribution Across Different Payment Methods and Locations:
SELECT PaymentMethod, Location, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY PaymentMethod, Location;

-- 27. Revenue Forecasting Using Moving Average:
SELECT Date, 
       AVG(SUM(TotalRevenue)) OVER (ORDER BY Date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverage
FROM mobile_sales
GROUP BY Date;

-- 28. High Revenue Transactions by Customer Age and Payment Method:
SELECT CustomerAge, PaymentMethod, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
WHERE TotalRevenue > (SELECT AVG(TotalRevenue) FROM mobile_sales)
GROUP BY CustomerAge, PaymentMethod;

-- 29. Revenue Contribution of Each Location Over Time:
SELECT Location, YEAR(Date) AS Year, SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY Location, Year
ORDER BY Location, Year;

-- 30. Trend Analysis of Units Sold by Mobile Model Over Time:
SELECT MobileModel, YEAR(Date) AS Year, SUM(UnitsSold) AS UnitsSold
FROM mobile_sales
GROUP BY MobileModel, Year
ORDER BY MobileModel, Year;

-- 31. Revenue by Brand and Age Group:
SELECT Brand, 
       CASE 
           WHEN CustomerAge < 20 THEN 'Under 20'
           WHEN CustomerAge BETWEEN 20 AND 29 THEN '20-29'
           WHEN CustomerAge BETWEEN 30 AND 39 THEN '30-39'
           WHEN CustomerAge BETWEEN 40 AND 49 THEN '40-49'
           WHEN CustomerAge >= 50 THEN '50 and above'
       END AS AgeGroup, 
       SUM(TotalRevenue) AS Revenue
FROM mobile_sales
GROUP BY Brand, AgeGroup;

-- 32. Customer Age and Gender Distribution for Each Payment Method:
SELECT PaymentMethod, CustomerAge, CustomerGender, SUM(UnitsSold) AS UnitsSold
FROM mobile_sales
GROUP BY PaymentMethod, CustomerAge, CustomerGender;
