-- Net sales % share global for a given year

SELECT 
	c.customer, 
	round(SUM(net_sales)/1000000,2) AS net_sales_mln
FROM net_sales n
JOIN dim_customer c
ON n.customer_code = c.customer_code
WHERE n.fiscal_year = 2021
GROUP BY c.customer
order by net_sales_mln desc;
