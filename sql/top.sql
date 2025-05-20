-- Top markets, products and customers for a given financial year

Select s.date, s.product_code, 
       p.product, s.customer_code, s.sold_quantity, g.gross_price,
       ROUND(sold_quantity*gross_price,2) AS Total_gross_price,
       pre.pre_invoice_discount_pct
from fact_sales_monthly s
JOIN dim_product p
ON s.product_code= p.product_code
JOIN fact_gross_price g
ON g.product_code = s.product_code AND g.fiscal_year= get_fiscal_year(s.date)
JOIN fact_pre_invoice_deductions pre
ON s.customer_code = pre.customer_code AND pre.fiscal_year= get_fiscal_year(s.date)

where 
    get_fiscal_year(s.date) = 2021 /* Coverting CY to FY*/ 
order by date asc
LIMIT 100000; 