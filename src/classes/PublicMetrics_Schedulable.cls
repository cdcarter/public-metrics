global class PublicMetrics_Schedulable implements Schedulable {
	global void execute(SchedulableContext sc) {
		List<Metric_Result__c> result = PublicMetrics.metrics;
	}
}
