with hit as (
SELECT 
  fullVisitorId,
  visitId,
  h.hitNumber,
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

select 
  fullVisitorId as full_visitor_id,
  visitId as visit_id,
  sum(goals_successful_installation) as goals_successful_installation,
  sum(goals_successful_activation) as goals_successful_activation,
  sum(goals_sdfc_lead_qualified) as goals_sdfc_lead_qualified
from hit
group by 1, 2


with hit as (
SELECT 
  fullVisitorId,
  visitId,
  h.hitNumber,
  any_value(case when (h.page.pagePath = 'www.uipath.com/g/thank-you-studio' 
            and h.isInteraction = True 
            and totals.totalTransactionRevenue*1000000 >= 2
            ) then 1 else 0 end) as goals_studio_download
          and h.eventInfo.eventLabel = 'Qualified') then 1 else 0 end) as goals_sdfc_lead_qualified
from `marketing-224613.69782380.ga_sessions_*`, UNNEST(hits) as h
where _TABLE_SUFFIX between '20190610' and '20190616'
group by 1,2,3
)

select 
  fullVisitorId as full_visitor_id,
  visitId as visit_id,
  sum(goals_successful_installation) as goals_successful_installation,
  sum(goals_successful_activation) as goals_successful_activation,
  sum(goals_sdfc_lead_qualified) as goals_sdfc_lead_qualified
from hit
group by 1, 2



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
      ) AS goals_contact_request     
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
  

  
SELECT
  fullVisitorId,
  visitid,
  h.hitNumber,
  device.deviceCategory as deviceCategory,
  case when h.page.pagePath like 'www.uipath.com/company/contact-us%'
    then h.hitNumber else null end as contact_us,
  case when h.page.pagePath like 'www.uipath.com/g/thank-you-contact%'
    then h.hitNumber else null end as thank_you_contact   
FROM
  `marketing-224613.69782380.ga_sessions_*`,
  UNNEST(hits) AS h
WHERE _TABLE_SUFFIX between '20190605' and '20190605'
  and h.page.pagePath like 'www.uipath.com/g/thank-you-contact%'
  and h.isInteraction = True
order by 1, 2, 3
  


