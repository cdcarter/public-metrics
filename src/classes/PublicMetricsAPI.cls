@RestResource(urlMapping='/metrics')
global class PublicMetricsAPI {
  @HttpGet
  global static List<Metric_Result__c> getMetrics() {
    try {
      List<Metric_Result__c> result = PublicMetrics.metrics;
    } catch(Exception e) {
    }
    return PublicMetrics.getCachedMetrics();
  }
}