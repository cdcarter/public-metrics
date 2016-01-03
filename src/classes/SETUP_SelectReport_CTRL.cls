public with sharing class SETUP_SelectReport_CTRL {
	public List<Report> reports {get;private set;}
	public SETUP_SelectReport_CTRL() {
		reports = [SELECT Id,Name,DeveloperName FROM Report WHERE Format ='Tabular' ORDER BY LastViewedDate DESC];
	}
}
