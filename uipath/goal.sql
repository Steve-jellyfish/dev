/*
add comments here
for 20190610 there are 74,487 rows
*/


SELECT
  fullVisitorId as full_visitor_id,
  visitid as visit_id,
  -- max(device.deviceCategory) as deviceCategory,
  max (CASE
      WHEN ((h.page.pagePath = 'www.uipath.com/en/g/thank-you-contact' AND h.isInteraction = TRUE)
        or (h.page.pagePath = 'www.uipath.com/fr/g/thank-you-contact' AND h.isInteraction = TRUE)
        or (h.page.pagePath = 'www.uipath.com/ja/g/thank-you-contact' AND h.isInteraction = TRUE)
        )  THEN 1
    ELSE 0 END
    ) AS goals_contact_request,
  --wrong
  -- destination is a regular expression. value= 3usd. Funnel has two URLs  
  max (CASE
      WHEN ((h.page.pagePath = 'www.uipath.com/es/g/thank-you-community' AND h.isInteraction = TRUE)
        or (h.page.pagePath = 'www.uipath.com/ja/g/thank-you-community' AND h.isInteraction = TRUE)
        or (h.page.pagePath = 'www.uipath.com/fr/g/thank-you-community' AND h.isInteraction = TRUE)
        )  THEN 1
    ELSE 0 END
    ) AS goals_community_download,
    --wrong 
    -- destination is regular expression, value= 1 usd, and funnel has 2 urls
  max (CASE
      WHEN ((h.page.pagePath = 'www.uipath.com/g/thank-you-studio' AND h.isInteraction = TRUE)
        or (h.page.pagePath = 'www.uipath.com/es/g/thank-you-community' AND h.isInteraction = TRUE)
        or (h.page.pagePath = 'www.uipath.com/ja/g/thank-you-community' AND h.isInteraction = TRUE)
        or (h.page.pagePath = 'www.uipath.com/fr/g/thank-you-community' AND h.isInteraction = TRUE)
        )  THEN 1
    ELSE 0 END
    ) AS goals_studio_download,
    --wrong
    --destination is regular epression, value= 2 usd, and funnel   
  MAX(CASE
      WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction IN ('New',  'Change') AND h.eventInfo.eventLabel = 'Qualified') THEN 1
    ELSE 0 END
    ) AS goals_sdfc_lead_qualified,
  MAX(CASE
      WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction IN ('New',  'Change') AND h.eventInfo.eventLabel = 'Working') THEN 1
    ELSE 0 END
    ) AS goals_sdfc_lead_working, 
  MAX(CASE
      WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction = 'New' AND h.eventInfo.eventLabel in ('Suspect', 'New', 'Qualified') ) THEN 1
    ELSE 0 END
    ) AS goals_sdfc_new_lead_created,
  MAX(CASE
      WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction = 'Change' AND h.eventInfo.eventLabel IN ('Closed Won Booked',  'Closed Won Pending')) THEN 1
    ELSE 0 END
    ) AS goals_sdfc_opportunity_commit_closed,      
  MAX(CASE
      WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction like '%New%') THEN 1
    ELSE 0 END
    ) AS goals_sdfc_opportunity_created, 
  MAX(CASE
      WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction = 'Change' AND h.eventInfo.eventLabel IN ('Discovery',  'Demo',  'POC',  'Proposal')) THEN 1
    ELSE 0 END
    ) AS goals_sdfc_opportunity_pipeline,      
  MAX(CASE
      WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction ='Change' AND h.eventInfo.eventLabel = 'Negotiation') THEN 1
    ELSE 0 END
    ) AS goals_sdfc_opportunity_upside     
FROM
  `marketing-224613.69782380.ga_sessions_20190610`,
  UNNEST(hits) AS h
-- WHERE _TABLE_SUFFIX between '20190605' and '20190611'
GROUP BY 1, 2

  

/* for validation 
see GA report here:
https://analytics.google.com/analytics/web/template?uid=OE9KjgznQ5Kybf2gMiyksw

WITH
  hit AS (
  SELECT
    fullVisitorId,
    visitid,
    max(device.deviceCategory) as deviceCategory,
      max (CASE
        WHEN ((h.page.pagePath = 'www.uipath.com/g/thank-you-contact' AND h.isInteraction = TRUE)
          or (h.page.pagePath = 'www.uipath.com/company/contact-us' AND h.isInteraction = TRUE)
          ) AND total.transactionRevenue > 3 THEN 1
      ELSE 0 END
      ) AS goals_contact_request,
    --wrong
    -- destination is a regular expression. value= 3usd. Funnel has two URLs  
    max (CASE
        WHEN (h.page.pagePath ='www.uipath.com/g/thank-you-community' AND h.isInteraction = TRUE) THEN 1
      ELSE 0 END
      ) AS goals_community_download,
      --wrong 
      -- destination is regular expression, value= 1 usd, and funnel has 2 urls
    max (CASE
        WHEN (h.page.pagePath ='www.uipath.com/g/thank-you-studio' AND h.isInteraction = TRUE) THEN 1
      ELSE 0 END
      ) AS goals_studio_download,
      --wrong
      --destination is regular epression, value= 2 usd, and funnel   
    MAX(CASE
        WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction IN ('New',  'Change') AND h.eventInfo.eventLabel = 'Qualified') THEN 1
      ELSE 0 END
      ) AS goals_sdfc_lead_qualified,
    MAX(CASE
        WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction IN ('New',  'Change') AND h.eventInfo.eventLabel = 'Working') THEN 1
      ELSE 0 END
      ) AS goals_sdfc_lead_working, 
    MAX(CASE
        WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction = 'New' AND h.eventInfo.eventLabel in ('Suspect', 'New', 'Qualified') ) THEN 1
      ELSE 0 END
      ) AS goals_sdfc_new_lead_created,
    MAX(CASE
        WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction = 'Change' AND h.eventInfo.eventLabel IN ('Closed Won Booked',  'Closed Won Pending')) THEN 1
      ELSE 0 END
      ) AS goals_sdfc_opportunity_commit_closed,      
    MAX(CASE
        WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction like '%New%') THEN 1
      ELSE 0 END
      ) AS goals_sdfc_opportunity_created, 
    MAX(CASE
        WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction = 'Change' AND h.eventInfo.eventLabel IN ('Discovery',  'Demo',  'POC',  'Proposal')) THEN 1
      ELSE 0 END
      ) AS goals_sdfc_opportunity_pipeline,      
    MAX(CASE
        WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction ='Change' AND h.eventInfo.eventLabel = 'Negotiation') THEN 1
      ELSE 0 END
      ) AS goals_sdfc_opportunity_upside     
  FROM
    `marketing-224613.69782380.ga_sessions_*`,
    UNNEST(hits) AS h
  WHERE _TABLE_SUFFIX between '20190605' and '20190611'
  GROUP BY 1, 2
    )
SELECT
  --fullVisitorId AS full_visitor_id,
  --visitid,
  deviceCategory,
  SUM(goals_contact_request) AS goals_contact_request,
  SUM(goals_community_download) AS goals_community_download,
  SUM(goals_studio_download) AS goals_studio_download,
  SUM(goals_sdfc_lead_qualified) AS goals_sdfc_lead_qualified,
  SUM(goals_sdfc_lead_working) AS goals_sdfc_lead_working,
  SUM(goals_sdfc_new_lead_created) AS goals_sdfc_new_lead_created,
  SUM(goals_sdfc_opportunity_commit_closed) AS goals_sdfc_opportunity_commit_closed,
  SUM(goals_sdfc_opportunity_created) AS goals_sdfc_opportunity_created,
  SUM(goals_sdfc_opportunity_pipeline) AS goals_sdfc_opportunity_pipeline,
  SUM(goals_sdfc_opportunity_upside) AS goals_sdfc_opportunity_upside
FROM
  hit
GROUP BY
  1


with hit as (
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
from hit
group by 1
order by 1

*/

