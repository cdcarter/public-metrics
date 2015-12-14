public with sharing class PublicMetrics {
	public static List<Public_Metrics__mdt> metric_records {get {
		if (PublicMetrics.metric_records == null) {
			PublicMetrics.metric_records = [SELECT Report_Id__c,ShortName__c,Type__c,Unit__c,DeveloperName,MasterLabel FROM Public_Metrics__mdt];
			return PublicMetrics.metric_records;
		} else {
			return PublicMetrics.metric_records;
		}
	} private set;}

	public static List<Metric_Result__c> metrics { get {
		if (PublicMetrics.metrics == null) {
			PublicMetrics.metrics = new List<Metric_Result__c>();
			for(Public_Metrics__mdt pm : PublicMetrics.metric_records) {
				// potentially here you could choose which method to call based
				// on the summary name in the mdt record
				if(pm.Type__c == 'rowcount')
					PublicMetrics.metrics.add(PublicMetrics.getRecordCountResult(pm));
			}
			return PublicMetrics.metrics;
		} else {
			return PublicMetrics.metrics;
		}
	} private set;}

	public static Metric_Result__c getRecordCountResult(Public_Metrics__mdt pm) {
		Metric_Result__c result = new Metric_Result__c(
			Unit__c = pm.Unit__c,
			ShortName__c = pm.ShortName__c,
			Type__c = pm.Type__c,
			Label__c = pm.MasterLabel,
			Last_Run__c = System.now()
		);

		Reports.ReportResults reportResults = Reports.ReportManager.runReport(pm.Report_Id__c, true);
		Reports.ReportFact fact = reportResults.getFactMap().get('T!T');
		List<Reports.SummaryValue> aggregates = fact.getAggregates();

		List<String> aggColNames = reportResults.getReportMetadata().getAggregates();
		for (Integer i = 0, cnt = aggColNames.size(); i < cnt; i++) {
    		String aggColName = aggColNames.get(i);
				Reports.SummaryValue sumVal = aggregates[i];
				System.debug(String.format('Col Name: {0}',new List<String>{aggColName}));
				System.debug(String.format('Label: {0}',new List<String>{sumVal.getLabel()}));
				System.debug(String.format('Value: {0}',new List<String>{String.valueOf(sumVal.getValue())}));

				if(aggColName == 'RowCount') {
					result.Result__c = String.valueOf(sumVal.getValue());
				}
		}

		return result;
	}
}