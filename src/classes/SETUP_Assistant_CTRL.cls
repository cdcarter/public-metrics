public with sharing class SETUP_Assistant_CTRL {
		transient public Report Report {get; private set;}
		public MetricDefinition metricDef {get; private set;}
		transient public List<AggregateResult> aggregateColumns {get; private set;}

    public SETUP_Assistant_CTRL() {
				String reportId = ApexPages.currentPage().getParameters().get('reportId');
				String metricId = ApexPages.currentPage().getParameters().get('metricId');
				if(reportId != null) {
					initializeForReport(reportId);
				} else if(metricId != null) {
					initializeForMetric(metricId);
				}
    }

		public void initializeForMetric(String metricId) {
			Public_Metrics__mdt mdt = [SELECT Id,Report__c,Type__c,Unit__c,ShortName__c,MasterLabel,DeveloperName FROM Public_Metrics__mdt WHERE Id =: metricId LIMIT 1];
			this.metricDef = new MetricDefinition(mdt);
			this.Report = [SELECT Id,Name,DeveloperName,Description FROM Report WHERE Id =:this.metricDef.reportId];

			initializeReportValues();
		}

		public void initializeForReport(String reportId) {
			this.Report = [SELECT Id,Name,DeveloperName,Description FROM Report WHERE Id =:reportId];
			this.metricDef = new MetricDefinition(this.Report);
			initializeReportValues();
		}

		public String getSiteUrl(){
			Site site = [SELECT GuestUserId FROM Site WHERE Name = 'Public_Metrics'];
			String path = '/sites/servlet.SiteDebugMode';
			PageReference pr = new PageReference(path);
			pr.getParameters().put('guid', site.GuestUserId);
			pr.getParameters().put('sitedebugmode', 'x');
			String url = pr.getContent().toString().substringAfter('URL=').substringBefore(path);
			return url;
		}

		public void initializeReportValues() {
			Reports.ReportResults reportResults = Reports.ReportManager.runReport(Report.Id, true);
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
			public String masterLabel {get; set;}
			public String developerName {get; set;}
			public MetricDefinition(Report sourceReport) {
				this.reportId = sourceReport.Id;
				this.report = sourceReport.DeveloperName;
				this.reportFullName = sourceReport.Name;
			}
			public MetricDefinition(Public_Metrics__mdt mdt) {
				this.report = mdt.Report__c;
				this.type = mdt.Type__c;
				this.shortName = mdt.ShortName__c;
				this.unit = mdt.Unit__c;
				this.masterLabel = mdt.MasterLabel;
				this.developerName = mdt.DeveloperName;
				Report tmp = [SELECT Id,Name FROM Report WHERE DeveloperName=:this.report LIMIT 1];
				this.reportId = tmp.Id;
				this.reportFullName = tmp.Name;
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
