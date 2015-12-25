global with sharing class PublicMetrics_Calculate_Action {
	@InvocableMethod(label='Calculate Public Metric' description='Forces a calculation of a Public Metric and returns Metric Results')
	global static List<Metric_Result__c> getResults(List<String> shortNames) {
		return PublicMetrics.getMetrics(shortNames);
	}
}
