public with sharing class PublicMetricsController {
	public List<Metric_Result__c> metrics { get; private set;}
	public PublicMetricsController() {
		this.metrics = PublicMetrics.getCachedMetrics();
	}
}