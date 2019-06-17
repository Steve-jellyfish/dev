
/*
add comments here
*/

with session as (
SELECT 
	fullVisitorId,
	visitId,
	h.hitNumber,
	any_value(date_trunc(date(TIMESTAMP_micros(visitStartTime*1000000)), day)) as date0,
	any_value(case when (h.page.pagePath = 'www.uipath.com/g/thank-you-install' 
						and h.isInteraction = True) then 1 else 0 end) as goals_successful_installation,
	any_value(case when (h.page.pagePath = 'www.uipath.com/g/thank-you-activating' 
						and h.isInteraction = True) then 1 else 0 end) as goals_successful_activation,	
	any_value(case when (h.eventInfo.eventCategory = 'Lead' 
					and h.eventInfo.eventAction in ('New', 'Change')
					and h.eventInfo.eventLabel = 'Qualified') then 1 else 0 end) as goals_sdfc_lead_qualified
from `marketing-224613.69782380.ga_sessions_*`, UNNEST(hits) as h
where _TABLE_SUFFIX between '20190610' and '20190616'
group by 1,2,3
)

SELECT
	date0,
	sum(goals_successful_installation) as goals_successful_installation,
	sum(goals_successful_activation) as goals_successful_activation,
	sum(goals_sdfc_lead_qualified) as goals_sdfc_lead_qualified
from session
group by 1
order by 1


