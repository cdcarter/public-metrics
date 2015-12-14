public with sharing class PublicMetricsDoDML {
	public PageReference doDML() {
		List<Metric_Result__c> result = PublicMetrics.metrics;
		return Page.PublicMetricsDashboard;
	}
}
