@isTest
private class PublicMetrics_TEST {
	@isTest static void test_pull_metrics() {
		Test.startTest();
		List<Metric_Result__c> results = PublicMetrics.metrics;
		Test.stopTest();
	}
}
