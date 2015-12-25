public with sharing class PublicMetricsController {
	public List<Metric_Result__c> getMetrics() {
		return PublicMetrics.getCachedMetrics();
	}

	public PageReference doDML() {
		List<Metric_Result__c> result = PublicMetrics.getMetrics();
		return Page.PublicMetricsDashboard;
	}
}
