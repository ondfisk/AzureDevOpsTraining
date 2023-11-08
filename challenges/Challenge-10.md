# Challenge 10 - Continuous Monitoring

[< Previous](./Challenge-09.md) - **[Home](../README.md)** - [Next >](./Challenge-11.md)

This challenge introduces *Continuous Monitoring* with Application Insights.

## Tasks

- Move *Challenge 10* to *Doing*
- Create new branch
- Add Application Insights with Log Analytics Workspace to your Bicep template
- Update app settings:

  ```bicep
  resource appSettings 'Microsoft.Web/sites/config@2022-09-01' = {
    name: 'appsettings'
    parent: webApp
    properties: {
      APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsights.properties.ConnectionString
      ApplicationInsightsAgent_EXTENSION_VERSION: '~3'
      XDT_MicrosoftApplicationInsights_Mode: 'Recommended'
    }
  }
  ```

- Create PR and merge.
- Interact with the updated web app.
- Verify telemetry being pushed to Application Insights using the [Azure Portal](https://portal.azure.com/).
