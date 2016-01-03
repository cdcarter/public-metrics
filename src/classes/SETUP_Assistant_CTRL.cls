public with sharing class SETUP_Assistant_CTRL {
		private final Report sourceReport;
		public MetricDefinition metricDef {get; private set;}
		transient public List<AggregateResult> aggregateColumns {get; private set;}

    public SETUP_Assistant_CTRL(ApexPages.StandardController stdController) {
        this.sourceReport = (Report)stdController.getRecord();
				this.metricDef = new MetricDefinition(this.sourceReport);
				Reports.ReportResults reportResults = Reports.ReportManager.runReport(sourceReport.Id, true);
				Reports.ReportFact fact = reportResults.getFactMap().get('T!T');
				List<Reports.SummaryValue> aggregates = fact.getAggregates();
				List<Reports.AggregateColumn> cols = reportResults.getReportExtendedMetadata().getAggregateColumnInfo().values();
				this.aggregateColumns = new List<AggregateResult>();
				for (Integer i = 0, cnt = cols.size(); i < cnt; i++) {
						this.aggregateColumns.add(new AggregateResult(cols[i],aggregates[i]));
				}
    }

		public PageReference save() {
			// turn MetricDefinition into a Public_Metrics__mdt
			// get that mdt and Metric_Result__c
			// redirect to a view metric page
			return null;
		}

		public class MetricDefinition {
			public ID reportId {get; private set;}
			public String report {get; private set;}
			public String reportFullName {get; private set;}
			public String type {get; set;}
			public String shortName {get; set;}
			public String unit {get; set;}
			public MetricDefinition(Report sourceReport) {
				this.reportId = sourceReport.Id;
				this.report = sourceReport.DeveloperName;
				this.reportFullName = sourceReport.Name;
			}
		}

		public class AggregateResult {
			public String name {get; private set;}
			public String label {get; private set;}
			public String value {get; private set;}
			public AggregateResult(Reports.AggregateColumn col, Reports.SummaryValue sumVal) {
				this.name=col.getName();
				this.label=col.getLabel();
				this.value = sumVal.getLabel();
			}
		}
}
