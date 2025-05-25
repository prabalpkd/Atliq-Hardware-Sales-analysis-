-- Creating a Helper table for Supply Chain Analytics.

CREATE TABLE fact_act_est(
SELECT 
    s.date AS date,
    s.fiscal_year AS fiscal_year,
    s.product_code AS product_code,
    s.customer_code AS customer_code,
    s.sold_quantity AS sold_quantity,
    f.forecast_quantity AS forecast_quantity
from fact_sales_monthly s
LEFT JOIN fact_forecast_monthly f
USING (date,product_code,customer_code)
 
UNION 
 
SELECT 
    f.date AS date,
    f.fiscal_year AS fiscal_year,
    f.product_code AS product_code,
    f.customer_code AS customer_code,
    s.sold_quantity AS sold_quantity,
    f.forecast_quantity AS forecast_quantity
from fact_sales_monthly s
RIGHT JOIN fact_forecast_monthly f
USING (date,product_code,customer_code));
