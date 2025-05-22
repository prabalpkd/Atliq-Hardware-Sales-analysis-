-- Net sales % share global for a given year

WITH cte1 as (
SELECT 
	c.customer, 
	round(SUM(net_sales)/1000000,2) AS net_sales_mln
FROM net_sales n
JOIN dim_customer c
ON n.customer_code = c.customer_code
WHERE n.fiscal_year = 2021
GROUP BY c.customer)

SELECT *,
net_sales_mln*100/sum(net_sales_mln) over() as net_sales_pct_share
from cte1
order by net_sales_mln desc;
