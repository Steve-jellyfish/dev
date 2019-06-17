/*
please put some comments here

*/


SELECT 
	fullVisitorId,
	visitId,
	TIMESTAMP_micros(visitStartTime*1000000) as visit_start_time,
	channelGrouping,
	totals.newVisits as totals_newVisits,
	trafficSource.medium as trafficSource_medium,
	trafficSource.source as trafficSource_source,
	trafficSource.isTrueDirect as trafficSource_isTrueDirect,
	trafficSource.keyword as trafficSource_keyword,
	device.browser as device_browser,
	device.operatingSystem as device_operatingSystem,
	device.isMobile as device_isMobile,
	device.deviceCategory as device_deviceCategory,
	geoNetwork.region as geoNetwork_region,
	geoNetwork.latitude as geoNetwork_latitude,
	geoNetwork.longitude as geoNetwork_longitude, 
	totals.sessionQualityDim as sessionQualityDim
from `marketing-224613:69782380.ga_sessions_20190610`

