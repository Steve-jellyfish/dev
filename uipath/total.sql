/*
please put some comments here
for 20190610 there are 74,487 rows
*/


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
from `marketing-224613.69782380.ga_sessions_20190610`,
	unnest (hits) as h
group by 1, 2
