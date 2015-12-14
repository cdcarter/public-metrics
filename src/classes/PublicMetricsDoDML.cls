public with sharing class PublicMetricsDoDML {
	public PublicMetricsDoDML() {
	}

	public PageReference doDML() {
		if (UserInfo.getUserType() == 'Standard') {
				List<Metric_Result__c> metrics = PublicMetrics.metrics;
				upsert metrics ShortName__c;
		}
		return Page.PublicMetricsDashboard;
	}
}