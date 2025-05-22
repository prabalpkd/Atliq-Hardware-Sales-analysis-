-- Net sales % by region

WITH cte1 as (
SELECT 
	c.customer,
    c.region,
	round(SUM(net_sales)/1000000,2) AS net_sales_mln
FROM net_sales n
JOIN dim_customer c
	ON n.customer_code = c.customer_code
WHERE n.fiscal_year = 2021
GROUP BY c.customer, c.region)

SELECT *,
      net_sales_mln*100/sum(net_sales_mln) over(partition by region) AS Net_sales_pct_by_region
FROM cte1
order by region, net_sales_mln desc;