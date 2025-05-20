-- create a store procedure to determine the market badge based on the following logic
-- If total sold quantity> 5 millions then "GOLD" else "SILVER"
-- INPUTS WILL BE "Market" and "Fiscal Year"
-- OUTPUT Should be "Market badge"
-- Ex India  2021  GOLD

select 
    c.market,
    sum(sold_quantity) as total_qty
from fact_sales_monthly s
join dim_customer c
on s.customer_code = c.customer_code
where get_fiscal_year(s.date) = 2021 and c.market= "India"
group by c.market