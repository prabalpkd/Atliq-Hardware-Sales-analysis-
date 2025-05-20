-- FINDING THE TOP MARKET FOR FY2021
SELECT 
    market, 
    round(SUM(net_sales)/1000000,2) AS net_sales_mln
FROM net_sales
WHERE fiscal_year = 2021
GROUP BY market
order by net_sales_mln desc
LIMIT 5;
-- Here we have found our first findings of Top 5 arkets for FY2021 Now you can strod this as alter
-- Stored procedure
