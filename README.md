# Public Metrics

Public Metrics creates public facing APIs and dashboards for key metrics tracked in Salesforce with a declarative and easy to set up process.

See some [getting started materials](https://dl.dropboxusercontent.com/spa/q8pc7mthv83x9i1/public-metrics-basics/index.html).

TODO:
* support more than just rowcount
* testing
* See if PublicMetrics.metrics can determine if the caller is live or cached?
* See if PublicMetrics can render the dashboard page after the action w/ changing the URL bar.
* invocable method to recalculate Metrics
* "see more" links on Metric_Result__c and Public_Metrics__mdt to inform the pretty dash
* Class name style guide.
* use report developer name instead of ID so that you can deploy the metadata and not change IDs
* URL Parameter filtering for public dashboard (think DDP)
* allow just one metric to be requested by shortname in API
* see if the API json can be prettier
* how could this or a similar technique be used to display lists of objects (e.g. a member directory)
* how to automate the sites setup
