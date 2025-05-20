/*Analystics on tables*/

Select * from movies
Select * from financials

Select title, budget,revenue, unit, currency,
CASE
    WHEN unit ="Thousands" THEN round((revenue-budget)/1000,2)
    WHEN unit ="Billions" THEN round((revenue-budget)*1000,2)
    else revenue-budget
END  as profit_mln
from movies as m 
left join financials as f
on m.movie_id=f.movie_id
order by profit_mln DESC
