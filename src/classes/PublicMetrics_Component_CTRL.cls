public class PublicMetrics_Component_CTRL {
  public string shortName {get;set;}
  public string getValue() {
    return PublicMetrics.getCachedMetric(this.shortName).Result__c;
  }
}
