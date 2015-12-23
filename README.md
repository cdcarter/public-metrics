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
* URL Parameter filtering for public dashboard (think DDP)
* allow just one metric to be requested by shortname in API
* allow just one metric to be selected by shortname via PublicMetrics class
* see if the API json can be prettier
* vf page for each metric result that shows report link (in this org) and current result and link to that metric in your api and maybe a quick configured wordpress plugin to add that value
* visualforce component to display metrics in email templates (hopefully with some string formatting)
* xslt transformy goodness in the buildscripts to inject site user and domain info
* how to automate the sites setup
* how could this or a similar technique be used to display lists of objects (e.g. a member directory)
