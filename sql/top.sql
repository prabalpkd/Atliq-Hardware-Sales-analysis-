-- Top markets, products and customers for a given financial year

WITH cte1 AS (Select s.date,s.fiscal_year, s.product_code, 
       p.product, s.customer_code, s.sold_quantity, g.gross_price,
       ROUND(sold_quantity*gross_price,2) AS Total_gross_price,
       pre.pre_invoice_discount_pct
       /*(Total_gross_price-Total_gross_price*pre_invoice_discount_pct) AS net_invoice_sale*/
       /*This line will not work as the total_gross_price is itself a derived column*/
       /*Here we can use the CTE*/
from fact_sales_monthly s
JOIN dim_product p
   ON s.product_code= p.product_code
JOIN fact_gross_price g
   ON g.product_code = s.product_code AND 
   g.fiscal_year= s.fiscal_year
JOIN fact_pre_invoice_deductions pre
   ON s.customer_code = pre.customer_code AND 
   pre.fiscal_year= s.fiscal_year
WHERE 
    s.fiscal_year = 2021  
order by date asc
LIMIT 100000)

SELECT *, 
       (Total_gross_price-Total_gross_price*pre_invoice_discount_pct) AS net_invoice_sale
from cte1;



/*Now as we have created the view as "sales_preinv_discount"* we can apply that tp simplify our query*/
SELECT *,
       (Total_gross_price-Total_gross_price*pre_invoice_discount_pct) AS net_invoice_sale
from sales_preinv_discount
WHERE fiscal_year = 2021;

/*Now to find the net sales we need to find the subtract the post invoince discount fro the
net_invoice sales to do so first join the fact_post_invoice table with this table and
perfor the needed operations */
/*(Total_gross_price-Total_gross_price*pre_invoice_discount_pct) = (1-pre_invoice_discount_pct)*Total_gross_price*/

SELECT *,
       (1-pre_invoice_discount_pct)*Total_gross_price AS net_invoice_sale,
       (po.discounts_pct+po.other_deductions_pct) AS post_invoice_discount_pct
from sales_preinv_discount s
JOIN fact_post_invoice_deductions po
ON s.date = po.date AND
   s.customer_code = po.customer_code AND
   s.product_code= po.product_code;
/* we can use this query to create another view as sales_postinv_discount to make simplification*/
/*AS we have created the view now we can use it for further operations*/
 
SELECT *,
      (1-post_invoice_discount_pct)*net_invoice_sale AS net_sales
FROM sales_postinv_discount;
/*Now we can make this table as a view*/




 