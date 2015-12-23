public with sharing class PublicMetricsController {
	public List<Metric_Result__c> metrics { get; private set;}
	public PublicMetricsController() {
		this.metrics = PublicMetrics.getCachedMetrics();
	}
	public PageReference doDML() {
		List<Metric_Result__c> result = PublicMetrics.metrics;
		return Page.PublicMetricsDashboard;
	}
}
