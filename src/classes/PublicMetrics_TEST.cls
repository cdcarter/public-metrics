@isTest
public class PublicMetrics_TEST {
	public static boolean useCachedData = true;
	@isTest(seeAllData=true) static void test_pull_metrics() {
		Test.startTest();
		List<Metric_Result__c> results = PublicMetrics.getMetrics();
		Test.stopTest();
	}
}
