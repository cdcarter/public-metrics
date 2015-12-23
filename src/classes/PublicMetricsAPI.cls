@RestResource(urlMapping='/metrics')
global class PublicMetricsAPI {
  @HttpGet
  global static List<Metric_Result__c> getMetrics() {
    return PublicMetrics.metrics;
  }
}
