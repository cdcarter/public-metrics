public with sharing class PublicMetricsController {
	public List<Metric_Result__c> metrics {
		get {
			this.metrics = [SELECT ShortName__c,Result__c,Label__c,Unit__c FROM Metric_Result__c];
			return this.metrics;
		}
		private set;
	}

	public PublicMetricsController() {
	}
}