-- Monthly total sales of Croma India and it should have two columns as
-- Month
-- Total gross sales amount in that month

SELECT 
   s.date,
   ROUND(SUM(gross_price*sold_quantity),2) AS gross_total_price
FROM fact_sales_monthly s
JOIN fact_gross_price g
ON g.product_code = s.product_code AND
   g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code= "90002002"
GROUP BY s.date;
