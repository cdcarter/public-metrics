@isTest public class PublicMetrics_Front_TEST {
    @istest public static void test_api() {
        PublicMetrics_TEST.useCachedData = true;
        Metric_Result__c mr = new Metric_Result__c(ShortName__c= 'test-test',Result__c='10',Type__c='rowcount',Label__c='test metric');
        insert mr;
        RestRequest req = new RestRequest();
        req.requestURI = '/metrics/';
        RestContext.request = req;
        Test.startTest();
        List<Metric_Result__c> results = PublicMetricsAPI.getMetrics();
        Test.stopTest();
        boolean passed = false;
        for(Metric_Result__c result : results) {
            if(result.ShortName__c == 'test-test') {
                passed = true;
            }
        }
        system.assert(passed);
        PublicMetrics_TEST.useCachedData = false;
    }
    @isTest public static void test_controller() {
        Metric_Result__c mr = new Metric_Result__c(ShortName__c= 'test-test',Result__c='10',Type__c='rowcount',Label__c='test metric');
        insert mr;
        Test.startTest();
        PublicMetricsController cont = new PublicMetricsController();
        List<Metric_Result__c> results = cont.getMetrics();
        Test.stopTest();
        boolean passed = false;
        for(Metric_Result__c result : results) {
            if(result.ShortName__c == 'test-test') {
                passed = true;
            }
        }
        system.assert(passed);

    }
}
