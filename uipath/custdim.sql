
/*
total user count: 61214
for 20190610 there are 40,655 rows 
*/

select 
	s.fullVisitorId as full_visitor_id
	,s.visitId as visit_id
	-- ,max(h.hitNumber) as hit_number
	,any_value(case when cust.index = 1 then cust.value else NULL end) as demandbase_sid
	,any_value(case when cust.index = 2 then cust.value else NULL end) as company_name
	,any_value(case when cust.index = 3 then cust.value else NULL end) as industry
	,any_value(case when cust.index = 4 then cust.value else NULL end) as sub_industry
	,any_value(case when cust.index = 5 then cust.value else NULL end) as employee_range
	,any_value(case when cust.index = 6 then cust.value else NULL end) as revenue_rage
	,any_value(case when cust.index = 7 then cust.value else NULL end) as audience
	,any_value(case when cust.index = 8 then cust.value else NULL end) as audience_segment
	,any_value(case when cust.index = 9 then cust.value else NULL end) as web_site
	#10-19
	,any_value(case when cust.index = 10 then cust.value else NULL end) as city
	,any_value(case when cust.index = 11 then cust.value else NULL end) as cstate
	,any_value(case when cust.index = 12 then cust.value else NULL end) as country_name
	,any_value(case when cust.index = 13 then cust.value else NULL end) as watch_list_account_type
	,any_value(case when cust.index = 14 then cust.value else NULL end) as watch_list_account_status
	,any_value(case when cust.index = 15 then cust.value else NULL end) as watch_list_campaign_code
	,any_value(case when cust.index = 16 then cust.value else NULL end) as watch_list_account_owner
	,any_value(case when cust.index = 17 then cust.value else NULL end) as fortune_1000
	,any_value(case when cust.index = 18 then cust.value else NULL end) as forbes_2000
	,any_value(case when cust.index = 19 then cust.value else NULL end) as traffic
	#20-29
	,any_value(case when cust.index = 20 then cust.value else NULL end) as client_id
	,any_value(case when cust.index = 26 then cust.value else NULL end) as sfdc_lead_industry
	,any_value(case when cust.index = 27 then cust.value else NULL end) as sfdc_lead_hubspot_score
	,any_value(case when cust.index = 28 then cust.value else NULL end) as sfdc_lead_first_lead_conversion
	,any_value(case when cust.index = 29 then cust.value else NULL end) as sfdc_lead_region_text
	#30-39
	,any_value(case when cust.index = 30 then cust.value else NULL end) as sfdc_lead_lead_type
	,any_value(case when cust.index = 31 then cust.value else NULL end) as sfdc_lead_account_type
	,any_value(case when cust.index = 32 then cust.value else NULL end) as sfdc_lead_lead_vertical
	,any_value(case when cust.index = 33 then cust.value else NULL end) as sfdc_lead_event_name
	,any_value(case when cust.index = 34 then cust.value else NULL end) as sfdc_lead_gdpr
	,any_value(case when cust.index = 35 then cust.value else NULL end) as sfdc_lead_original_source
	,any_value(case when cust.index = 36 then cust.value else NULL end) as sfdc_opportunity_opportunity_name
	,any_value(case when cust.index = 37 then cust.value else NULL end) as sfdc_opportunity_opportunity_id
	,any_value(case when cust.index = 38 then cust.value else NULL end) as sfdc_opportunity_lead_source
	,any_value(case when cust.index = 39 then cust.value else NULL end) as sfdc_opportunity_total_amount
	# 40-49
	,any_value(case when cust.index = 40 then cust.value else NULL end) as sfdc_opportunity_potential_opportunity_value
	,any_value(case when cust.index = 41 then cust.value else NULL end) as sfdc_opportunity_converted_from_lead
	,any_value(case when cust.index = 43 then cust.value else NULL end) as sfdc_opportunity_account_owner
	,any_value(case when cust.index = 44 then cust.value else NULL end) as sfdc_opportunity_account_geo
	,any_value(case when cust.index = 45 then cust.value else NULL end) as sfdc_opportunity_vertical
	,any_value(case when cust.index = 46 then cust.value else NULL end) as sfdc_opportunity_country
	,any_value(case when cust.index = 47 then cust.value else NULL end) as sfdc_opportunity_partner_name
	,any_value(case when cust.index = 48 then cust.value else NULL end) as lead_track_id
	#50-59
	,any_value(case when cust.index = 50 then cust.value else NULL end) as hs_company_name
	,any_value(case when cust.index = 51 then cust.value else NULL end) as hs_country
	,any_value(case when cust.index = 52 then cust.value else NULL end) as hs_audience
	,any_value(case when cust.index = 53 then cust.value else NULL end) as hs_information_level
	,any_value(case when cust.index = 54 then cust.value else NULL end) as hs_region_name
from `marketing-224613.69782380.ga_sessions_20190610` as s,
	UNNEST(hits) as h,
	UNNEST(h.customDimensions) as cust
group by 1, 2


-- select 
-- 	s.fullVisitorId
-- 	,s.visitId as visit_id
-- 	,h.hitNumber
-- 	,array_agg(case when c.index = 39 then c.value else NULL end ignore nulls order by h.hitNumber) as sfdc_opportunity_total_amount
-- 	-- ,any_value(case when cust.index = 40 then cust.value else NULL end) as sfdc_opportunity_potential_opportunity_value
-- from `marketing-224613.69782380.ga_sessions_20190610` as s,
-- 	UNNEST(hits) as h,
-- 	UNNEST(h.customDimensions) as c
-- group by 1, 2, 3
-- having sfdc_opportunity_total_amount is not null
-- order by 1, 2, 3

-- select 
-- 	s.fullVisitorId
-- 	,s.visitId as visit_id
-- 	,h.hitNumber
-- 	,array_agg(case when c.index = 39 then c.value else NULL end ignore nulls order by h.hitNumber) as sfdc_opportunity_total_amount
-- 	-- ,any_value(case when cust.index = 40 then cust.value else NULL end) as sfdc_opportunity_potential_opportunity_value
-- from `marketing-224613.69782380.ga_sessions_20190610` as s,
-- 	UNNEST(hits) as h,
-- 	UNNEST(h.customDimensions) as c
-- group by 1, 2, 3
-- having sfdc_opportunity_total_amount is not null
-- order by 1, 2, 3



