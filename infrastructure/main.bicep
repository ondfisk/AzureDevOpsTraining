param location string = resourceGroup().location
param appServicePlanName string
param webAppName string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  kind: 'linux'
  location: location
  sku: {
    name: 'P1v3'
    capacity: 1
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    reserved: true
    hyperV: false
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|7.0'
      alwaysOn: true
      http20Enabled: true
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      ftpsState: 'Disabled'
    }
    httpsOnly: true
    publicNetworkAccess: 'Enabled'
  }
}
