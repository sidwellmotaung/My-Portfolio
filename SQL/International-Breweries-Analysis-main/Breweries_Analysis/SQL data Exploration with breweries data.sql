--SECTION A--
--PROFIT ANALYSIS--

/*1. Within the space of the last three years, what was the profit worth of the breweries,
inclusive of the anglophone and the francophone territories?*/

SELECT SUM(profit) AS Sum_Profit
from Breweries


/*2. Compare the total profit between these two territories in order for the territory manager,
Mr. Stone made a strategic decision that will aid profit maximization in 2020.*/

SELECT
  COUNTRIES,
  SUM(profit) AS total_profit
FROM Breweries
GROUP BY COUNTRIES
ORDER BY total_profit DESC

--3. Country that generated the highest profit in 2019--

SELECT TOP 1
  COUNTRIES,
  SUM(profit) AS total_profit
FROM Breweries
WHERE YEARS = 2019
GROUP BY Countries
ORDER BY total_profit DESC


--4. Help him find the year with the highest profit.--

SELECT TOP 2 years, SUM(profit) AS Sum_profit
FROM breweries
GROUP BY YEARS
ORDER BY SUM_PROFIT DESC

--5. Which month in the three years was the least profit generated?--

SELECT years, SUM(profit) AS Sum_profit
FROM breweries
GROUP BY YEARS
ORDER BY SUM_PROFIT ASC

--6. What was the minimum profit in the month of December 2018?--

SELECT
  MIN(profit) AS min_profit
FROM Breweries
WHERE YEAR(YEARS) = 2018 AND MONTH(MONTHS) = 12

--7. Compare the profit in percentage for each of the month in 2019--

WITH cte AS (
  SELECT
    MONTH(MONTHS) AS month,
    SUM(profit) AS total_profit
  FROM Breweries
  WHERE YEAR(YEARS) = 2019
  GROUP BY MONTH(MONTHS)
)
SELECT
  month,
  (total_profit / (SELECT SUM(total_profit) FROM cte)) * 100 AS profit_percentage
FROM CTE;

--8. Which particular brand generated the highest profit in Senegal?--

  SELECT
    brandS,
    SUM(profit) AS total_profit
  FROM Breweries
  WHERE COUNTRIES = 'Senegal'
  GROUP BY BRANDS
  ORDER BY total_profit DESC;



--Session B--
--BRAND ANALYSIS--

/*1. Within the last two years, the brand manager wants to know the top three brands
consumed in the francophone countries*/


SELECT TOP 3
  BRANDS,
  SUM(profit) AS total_profit
FROM Breweries
GROUP BY BRANDS
ORDER BY total_profit DESC


--2. Find out the top two choice of consumer brands in Ghana--


  SELECT
    TOP 2 brands,
    SUM(profit) AS total_profit
  FROM Breweries
  WHERE COUNTRIES = 'Ghana'
  GROUP BY BRANDS
  ORDER BY total_profit DESC

--4. Favorites malt brand in Anglophone region between 2018 and 2019--

  SELECT TOP 2
    BRANDS,
    SUM(profit) AS total_profit
  FROM Breweries
  WHERE COUNTRIES IN ('Nigeria', 'Ghana') -- list of anglophone countries
    AND YEARS >= '2018'
    AND YEARS < '2019'
  GROUP BY BRANDS
  ORDER BY total_profit DESC

  
--5. Which brand sold the highest in 2019 in Nigeria?--


  SELECT
    BRANDS,
    SUM(profit) AS total_profit
  FROM Breweries
  WHERE COUNTRIES = 'Nigeria'
    AND YEARS >= '2019'
  GROUP BY BRANDS
  ORDER BY total_profit DESC


  --6. Favorite brand in South_South region in Nigeria--

  SELECT TOP 2
    BRANDS,
    SUM(profit) AS total_profit
  FROM Breweries
  WHERE COUNTRIES = 'Nigeria'
    AND REGION = 'SouthSouth'
  GROUP BY BRANDS

  
--7. Beer consumption in Nigeria--

SELECT
  SUM(quantity) AS total_quantity
FROM Breweries
WHERE COUNTRIES = 'Nigeria'
  AND BRANDS NOT LIKE  '%malt%';


  
--8. Level of consumption of Budweiser in the regions in Nigeria--
--Total brands consumption in Nigeria --
  SELECT
  region,
  SUM(CASE WHEN BRANDS = 'Budweiser' THEN quantity ELSE 0 END) AS budweiser_quantity,
  SUM(quantity) AS total_quantity
FROM Breweries
WHERE COUNTRIES = 'Nigeria'
GROUP BY region;

-- 9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)--
SELECT
  REGION,
  SUM(CASE WHEN brandS = 'Budweiser' THEN quantity ELSE 0 END) AS budweiser_quantity,
  SUM(quantity) AS total_quantity
FROM Breweries
WHERE COUNTRIES = 'Nigeria'
  AND YEAR(YEARS) = 2019
GROUP BY REGION;





 



