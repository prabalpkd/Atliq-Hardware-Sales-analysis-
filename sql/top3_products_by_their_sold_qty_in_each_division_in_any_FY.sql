-- Write a stored procedure to find top n product in each division by their quantity sold in a given financial year.

WITH cte1 as (
SELECT 
     p.division,
     p.product,
     SUM(s.sold_quantity) AS Total_qty
from fact_sales_monthly s
JOIN dim_product p
ON p.product_code = s.product_code
WHERE fiscal_year=2021
GROUP BY p.product, p.division),

cte2 as (SELECT *,
        dense_rank() over(partition by division order by total_qty desc) as drnk
from cte1)
SELECT * from cte2
where drnk<=3;
 