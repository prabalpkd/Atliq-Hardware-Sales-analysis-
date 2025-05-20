-- Finding top products

SELECT 
    product, 
    round(SUM(net_sales)/1000000,2) AS net_sales_mln
FROM net_sales 
WHERE fiscal_year = 2021
GROUP BY product
order by net_sales_mln desc
LIMIT 5;
-- Now we can create a stored procedure fro this for future use