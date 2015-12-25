@RestResource(urlMapping='/metrics/*')
global class PublicMetricsAPI {
  @HttpGet
  global static List<Metric_Result__c> getMetrics() {
    RestRequest req = RestContext.request;
    String metricName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    if(!String.isBlank(metricName)) {
      return new List<Metric_Result__c> { PublicMetrics.getMetric(metricName)};
    }
    return PublicMetrics.getMetrics();
  }
}
