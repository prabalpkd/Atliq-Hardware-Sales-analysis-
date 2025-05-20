-- We need to build a report on croma india for the FY 2021 and it should contain the following coluns
-- Month
-- Product
-- Varients
-- Sold_quantity
-- Gross price per items
-- Total Gross price


Select * from fact_sales_monthly
where 
    customer_code="90002002" and
    year(date_add(date, interval 4 month))= 2021 /* Coverting CY to FY*/
order by date desc;

-- adding month to date column --
SELECT date_add("2020-12-01", interval 4 month);

-- Writing the same query using user defind function
Select * from fact_sales_monthly
where 
    customer_code= 90002002 and
    get_fiscal_year(date) = 2021 /* Coverting CY to FY*/ 
order by date asc;

-- JOINING THE ABOVE TABLE WITH THE OTHERS RO GET THE DESIRED OUTPUT:
Select f.date, f.product_code, 
       p.product, p.variant, f.sold_quantity, g.gross_price,
       ROUND(sold_quantity*gross_price,2) AS Total_gross_price
from fact_sales_monthly f
JOIN dim_product p
ON f.product_code= p.product_code
JOIN fact_gross_price g
ON g.product_code = f.product_code AND g.fiscal_year= get_fiscal_year(f.date)
where 
    customer_code= 90002002 and
    get_fiscal_year(date) = 2021 /* Coverting CY to FY*/ 
order by date asc;
