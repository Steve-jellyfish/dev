
/*
total user count: 61214
returned user in dimemsion 1 & 2: 28892
*/

SELECT 
	fullVisitorId as full_visitor_id,
	visitId as visit_id,
	max(visitNumber) as visit_number,
	any_value(case when cust.index = 1 then cust.value else NULL end) as demandbase_sid,
	any_value(case when cust.index = 2 then cust.value else NULL end) as company_name
from `marketing-224613.69782380.ga_sessions_20190610`, UNNEST(customDimensions) as cust
-- where cust.index in (1,2)
group by 1, 2
order by 1, 2

