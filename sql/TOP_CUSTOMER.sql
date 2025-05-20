-- Finding the top customers
SELECT 
    c.customer, 
    round(SUM(net_sales)/1000000,2) AS net_sales_mln
FROM net_sales n
JOIN dim_customer c
ON n.customer_code = c.customer_code
WHERE fiscal_year = 2021
GROUP BY c.customer
order by net_sales_mln desc
LIMIT 5;
-- Here we have found out our top customers.
-- Now save it as a stored procedure for future use.