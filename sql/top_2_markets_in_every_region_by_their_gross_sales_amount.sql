-- Retrieve the top 2 markets in every region by their gross sales amount in FY=2021.

WITH cte1 as (
SELECT 
      c.market,
      c.region,
      round(sum(gross_price_total)/1000000,2) as gross_sales_mln
FROM gross_sales s
JOIN dim_customer c
ON s.customer_code = c.customer_code
where fiscal_year=2021
GROUP BY market,region),

cte2 as (SELECT *,
       dense_rank() over(partition by region order by gross_sales_mln DESC) as drnk
FROM cte1)

SELECT * FROM cte2
WHERE drnk<=2; 







