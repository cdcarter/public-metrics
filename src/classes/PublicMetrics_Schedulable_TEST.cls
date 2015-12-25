@isTest
private class PublicMetrics_Schedulable_TEST {
   public static String CRON_EXP = '0 0 0 15 3 ? 2022';

   // This method uses seeAllData and UnCached Results to let the
   // scheduled class actually create Metric Results.
   // Expecting an empty db.
   // seeAllData required to get Report IDs
	 @isTest(seeAllData=true) static void test_schedulableClass() {
		 List<Metric_Result__c> ml = [SELECT Id FROM Metric_Result__c ];
		 System.assertEquals(ml.size(),0);

		 Test.startTest();
		 String jobId = System.schedule('ScheduleApexClassTest',CRON_EXP,
		 																new PublicMetrics_Schedulable());
		 Test.stopTest();

		 ml = [SELECT Id FROM Metric_Result__c];
		 List<Public_Metrics__mdt> pm = [SELECT Id FROM Public_Metrics__mdt];
		 System.assertEquals(pm.size(),ml.size());
	 }
}
