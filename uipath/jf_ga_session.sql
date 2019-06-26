
with cust as (
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
		,any_value(case when cust.index = 20 then cust.value else NULL end) as client_id
		,any_value(case when cust.index = 26 then cust.value else NULL end) as sfdc_lead_industry
		,any_value(case when cust.index = 27 then cust.value else NULL end) as sfdc_lead_hubspot_score
		,any_value(case when cust.index = 28 then cust.value else NULL end) as sfdc_lead_first_lead_conversion
		,any_value(case when cust.index = 29 then cust.value else NULL end) as sfdc_lead_region_text
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
		,any_value(case when cust.index = 40 then cust.value else NULL end) as sfdc_opportunity_potential_opportunity_value
		,any_value(case when cust.index = 41 then cust.value else NULL end) as sfdc_opportunity_converted_from_lead
		,any_value(case when cust.index = 43 then cust.value else NULL end) as sfdc_opportunity_account_owner
		,any_value(case when cust.index = 44 then cust.value else NULL end) as sfdc_opportunity_account_geo
		,any_value(case when cust.index = 45 then cust.value else NULL end) as sfdc_opportunity_vertical
		,any_value(case when cust.index = 46 then cust.value else NULL end) as sfdc_opportunity_country
		,any_value(case when cust.index = 47 then cust.value else NULL end) as sfdc_opportunity_partner_name
		,any_value(case when cust.index = 48 then cust.value else NULL end) as lead_track_id
		,any_value(case when cust.index = 50 then cust.value else NULL end) as hs_company_name
		,any_value(case when cust.index = 51 then cust.value else NULL end) as hs_country
		,any_value(case when cust.index = 52 then cust.value else NULL end) as hs_audience
		,any_value(case when cust.index = 53 then cust.value else NULL end) as hs_information_level
		,any_value(case when cust.index = 54 then cust.value else NULL end) as hs_region_name
	from `marketing-224613.69782380.ga_sessions_20190610` as s,
		UNNEST(hits) as h,
		UNNEST(h.customDimensions) as cust
	group by 1, 2
),

total as (
	Select 
		fullVisitorId as full_visitor_id,
		visitid as visit_id,
		any_value(TIMESTAMP_micros(visitStartTime*1000000)) as session_start_time
		,any_value(case when totals.bounces is NULL then False else True end) as bounce --converting this integer to a boolean
		,any_value(totals.hits) as number_of_hits
		,any_value(case when totals.newVisits is NULL then False else True end) as new_Visits
		,any_value(totals.pageviews) as page_views
		,any_value(totals.screenviews) as screen_views
		,any_value(totals.sessionQualityDim) as sessions_quality_dim
		,any_value(totals.timeOnScreen) as time_on_screen
		,any_value(totals.timeOnSite) as time_on_site
		,any_value(totals.totalTransactionRevenue) as total_transaction_revenue
		,any_value(totals.transactions) as transactions
		,any_value(totals.UniqueScreenViews) as unique_screen_views
		,any_value(h.isInteraction) as visits_with_interactions
		,any_value(trafficSource.source) as traffic_source_source
		,any_value(socialEngagementType) as social_engagement_type
		,any_value(channelGrouping) as channel_grouping
		,any_value(device.deviceCategory) as device_category
		,any_value(device.browser) as device_browser
		,any_value(device.browserVersion) as device_browser_version 
		,any_value(device.operatingSystem) as device_operating_system
		,any_value(geoNetwork.continent) as geo_continent
		,any_value(geoNetwork.country) as geo_country
		,any_value(geoNetwork.region) as geo_region
		,any_value(geoNetwork.metro) geo_metro
		,any_value(geoNetwork.city) as geo_city
		,MAX(CASE
			WHEN ((h.page.pagePath = 'www.uipath.com/en/g/thank-you-contact' AND h.isInteraction = TRUE)
				or (h.page.pagePath = 'www.uipath.com/fr/g/thank-you-contact' AND h.isInteraction = TRUE)
				or (h.page.pagePath = 'www.uipath.com/ja/g/thank-you-contact' AND h.isInteraction = TRUE)
				)  THEN 1
			ELSE 0 END
			) AS goals_contact_request
		,MAX(CASE
			  WHEN ((h.page.pagePath = 'www.uipath.com/es/g/thank-you-community' AND h.isInteraction = TRUE)
			    or (h.page.pagePath = 'www.uipath.com/ja/g/thank-you-community' AND h.isInteraction = TRUE)
			    or (h.page.pagePath = 'www.uipath.com/fr/g/thank-you-community' AND h.isInteraction = TRUE)
			    )  THEN 1
			ELSE 0 END
			) AS goals_community_download
		,MAX(CASE
			WHEN ((h.page.pagePath = 'www.uipath.com/g/thank-you-studio' AND h.isInteraction = TRUE)
			    or (h.page.pagePath = 'www.uipath.com/es/g/thank-you-community' AND h.isInteraction = TRUE)
			    or (h.page.pagePath = 'www.uipath.com/ja/g/thank-you-community' AND h.isInteraction = TRUE)
			    or (h.page.pagePath = 'www.uipath.com/fr/g/thank-you-community' AND h.isInteraction = TRUE)
			    )  THEN 1
			ELSE 0 END
		) AS goals_studio_download 
		,MAX(CASE
			WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction IN ('New',  'Change') AND h.eventInfo.eventLabel = 'Qualified') THEN 1
			ELSE 0 END
			) AS goals_sdfc_lead_qualified
		,MAX(CASE
			WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction IN ('New',  'Change') AND h.eventInfo.eventLabel = 'Working') THEN 1
			ELSE 0 END
			) AS goals_sdfc_lead_working
		,MAX(CASE
			WHEN (h.eventInfo.eventCategory = 'Lead' AND h.eventInfo.eventAction = 'New' AND h.eventInfo.eventLabel in ('Suspect', 'New', 'Qualified') ) THEN 1
			ELSE 0 END
			) AS goals_sdfc_new_lead_created
		,MAX(CASE
			WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction = 'Change' AND h.eventInfo.eventLabel IN ('Closed Won Booked',  'Closed Won Pending')) THEN 1
			ELSE 0 END
			) AS goals_sdfc_opportunity_commit_closed     
		,MAX(CASE
			WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction like '%New%') THEN 1
			ELSE 0 END
			) AS goals_sdfc_opportunity_created
		,MAX(CASE
			WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction = 'Change' AND h.eventInfo.eventLabel IN ('Discovery',  'Demo',  'POC',  'Proposal')) THEN 1
			ELSE 0 END
			) AS goals_sdfc_opportunity_pipeline    
		,MAX(CASE
			WHEN (h.eventInfo.eventCategory = 'Opportunity' AND h.eventInfo.eventAction ='Change' AND h.eventInfo.eventLabel = 'Negotiation') THEN 1
			ELSE 0 END
			) AS goals_sdfc_opportunity_upside   
	from `marketing-224613.69782380.ga_sessions_20190610`,
		unnest (hits) as h
	group by 1, 2
)

select 
	

from total
left join cust
	on total.full_visitor_id = cust.full_visitor_id
	and total.visit_id = cust.visit_id



