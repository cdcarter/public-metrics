public with sharing class PublicMetrics {
	public static Metric_Result__c getCachedMetric(String shortName) {
		return PublicMetrics.getCachedMetrics(new List<String> {shortName})[0];
	}

	public static List<Metric_Result__c> getCachedMetrics() {
		return [SELECT ShortName__c,Result__c,Label__c,Unit__c FROM Metric_Result__c];
	}

	public static List<Metric_Result__c> getCachedMetrics(List<String> shortNames) {
		return [SELECT ShortName__c,Result__c,Label__c,Unit__c
						FROM Metric_Result__c
						WHERE ShortName__c IN :shortNames];
	}

	// this is inelegant and causes an unnecessary SOQL query. getMetrics(List<String>) will need refactoring
	public static List<Metric_Result__c> getMetrics() {
		if (shouldUseCachedData()) {
			List<Public_Metrics__mdt> definitions = PublicMetrics.getMetricDefinitions();
			List<String> shortNames = new List<String>();
			for(Public_Metrics__mdt pm : definitions) {
				shortNames.add(pm.ShortName__c);
			}
			return PublicMetrics.getMetrics(shortNames);
		} else {
			return PublicMetrics.getCachedMetrics();
		}
	}

	public static List<Metric_Result__c> getMetrics(List<String> shortNames) {
		if (shouldUseCachedData()) {
			List<Metric_Result__c> results = new List<Metric_Result__c>();
			List<Public_Metrics__mdt> definitions = PublicMetrics.getMetricDefinitions(shortNames);
			List<String> reportNames = new List<String>();
			for(Public_Metrics__mdt pm : definitions) {
				reportNames.add(pm.Report__c);
			}
			List<Report> reports = [SELECT Id,DeveloperName FROM Report WHERE DeveloperName IN :reportNames];
			Map<String,Id> reportMapping = new Map<String,Id>();
			for(Report rep : reports) {
				reportMapping.put(rep.DeveloperName,rep.Id);
			}

			for(Public_Metrics__mdt pm : definitions) {
				results.add(PublicMetrics.getMetric(pm,reportMapping.get(pm.Report__c)));
			}

			upsert results ShortName__c;

			return results;
		} else {
			return PublicMetrics.getCachedMetrics(shortNames);
		}
	}

	public static Metric_Result__c getMetric(Public_Metrics__mdt pm, Id reportId) {
		Metric_Result__c result = new Metric_Result__c(
			Unit__c = pm.Unit__c,
			ShortName__c = pm.ShortName__c,
			Type__c = pm.Type__c,
			Label__c = pm.MasterLabel,
			Last_Run__c = System.now()
		);

		Reports.ReportResults reportResults;
		try {
			reportResults = Reports.ReportManager.runReport(reportId, true);
		} catch(Exception e) {
			throw new MetricReportException('Could not execute report for metric.',e);
		}

		Reports.ReportFact fact = reportResults.getFactMap().get('T!T');
		List<Reports.SummaryValue> aggregates = fact.getAggregates();

		List<String> aggColNames = reportResults.getReportMetadata().getAggregates();
		for (Integer i = 0, cnt = aggColNames.size(); i < cnt; i++) {
				String aggColName = aggColNames.get(i);
				Reports.SummaryValue sumVal = aggregates[i];
				System.debug(String.format('Col Name: {0}',new List<String>{aggColName}));
				System.debug(String.format('Label: {0}',new List<String>{sumVal.getLabel()}));
				System.debug(String.format('Value: {0}',new List<String>{String.valueOf(sumVal.getValue())}));

				if(aggColName == pm.Type__c) {
					result.Result__c = String.valueOf(sumVal.getValue());
				}
		}

		return result;
	}

	public static Metric_Result__c getMetric(String shortName) {
		try {
			return PublicMetrics.getMetrics(new List<String>{shortName})[0];
		} catch(Exception e) {
			throw new MetricNotFoundException(String.format('Could not find metric named {0}.',new List<String>{shortName}),e);
		}
	}

	public static Public_Metrics__mdt getMetricDefinition(String shortName) {
		try {
			return PublicMetrics.getMetricDefinitions(new List<String>{shortName})[0];
		} catch(Exception e) {
			throw new MetricNotFoundException(String.format('Could not find metric named {0}.',new List<String>{shortName}),e);
		}
	}

	public static List<Public_Metrics__mdt> getMetricDefinitions() {
		return [SELECT Report__c,ShortName__c,Type__c,Unit__c,DeveloperName,MasterLabel
						FROM Public_Metrics__mdt];
	}

	public static List<Public_Metrics__mdt> getMetricDefinitions(List<String> shortNames) {
		return [SELECT Report__c,ShortName__c,Type__c,Unit__c,DeveloperName,MasterLabel
						FROM Public_Metrics__mdt
						WHERE ShortName__c IN :shortNames];
	}

	private static boolean shouldUseCachedData() {
		return (UserInfo.getUserType() == 'Standard' && !PublicMetrics_TEST.useCachedData);
	}

	public class MetricReportException extends Exception {}
	public class MetricNotFoundException extends Exception {}
	public class MetricValidationException extends Exception {}
}
