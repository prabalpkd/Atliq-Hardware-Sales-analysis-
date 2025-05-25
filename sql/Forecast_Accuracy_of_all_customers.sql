-- Forecast Accuracy of all customers for a given fiscal year
-- The report should have following columns
-- Customer Code, Name, Market
-- Total sold Quantity
-- Total Forecaste Quantity
-- Net Error
-- Absolute Error
-- Forecaste Accuracy % 

WITH forecast_acc_table AS 
(SELECT 
	  s.customer_code,
      sum((forecast_quantity- sold_quantity)) as Net_Error,
      sum((forecast_quantity- sold_quantity))*100/sum(forecast_quantity) as Net_Error_pct,
      sum(ABS((forecast_quantity- sold_quantity))) as Abs_Error,
      sum(ABS((forecast_quantity- sold_quantity)))*100/sum(forecast_quantity) as Abs_Error_pct
FROM gdb0041.fact_act_est s
WHERE s.fiscal_year = 2021
GROUP BY s.customer_code)
SELECT *,
       (100- Abs_Error_pct) AS forecast_accuacy
FROM forecast_acc_table
ORDER BY forecast_accuacy;
-- Here we can see soe negative values in the forecast_accuracy field 
-- bcz the abs_Error_pct is ore than 100
-- Sp we can conclude that if abs_Error_pct is > 100 then the forecast_accuracy is zero
-- so modify the query based on that condition

WITH forecast_acc_table AS 
(SELECT 
	  s.customer_code,
      sum(s.sold_quantity) AS total_sold_quantity,
      sum(s.forecast_quantity) AS total_forecast_quantity,
      sum((forecast_quantity- sold_quantity)) as Net_Error,
      sum((forecast_quantity- sold_quantity))*100/sum(forecast_quantity) as Net_Error_pct,
      sum(ABS((forecast_quantity- sold_quantity))) as Abs_Error,
      sum(ABS((forecast_quantity- sold_quantity)))*100/sum(forecast_quantity) as Abs_Error_pct
FROM gdb0041.fact_act_est s
WHERE s.fiscal_year = 2021
GROUP BY s.customer_code)
SELECT e.*,
       c.customer,
       c.market,
       if(Abs_Error_pct>100, 0, 100- Abs_Error_pct) AS forecast_accuacy
FROM forecast_acc_table e
JOIN dim_customer c
USING (customer_code)
ORDER BY forecast_accuacy desc;

-- Now we can create a stored Procedure so that we can use it for future use.

