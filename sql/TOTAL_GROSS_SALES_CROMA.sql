-- Generate a yearly report for Croma India where there are two columns
-- 1. Fiscal Year
-- 2. Total Gross Sales amount In that year from Croma

SELECT
    get_fiscal_year(s.date) as fiscal_year,
    SUM(sold_quantity*gross_price) AS TOTAL_GROSS_SALES_CROMA
    
FROM fact_sales_monthly s
JOIN fact_gross_price g 
ON g.product_code = s.product_code AND
   g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code = 90002002
GROUP BY get_fiscal_year(date);

