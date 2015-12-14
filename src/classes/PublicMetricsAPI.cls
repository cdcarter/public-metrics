@RestResource(urlMapping='/metrics')
global class PublicMetricsAPI {
  @HttpGet
  global static List<Metric_Result__c> getMetrics() {
    try {
      new PublicMetricsDoDML().doDML();
    } catch(Exception e) {
      
    }
    return new PublicMetricsController().metrics;
  }
}