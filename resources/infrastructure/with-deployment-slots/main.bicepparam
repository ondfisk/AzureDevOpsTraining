using './main.bicep'

param location = 'swedencentral'
param sqlServerName = ''
param databaseName = ''
param sqlAdminGroupName = '' // Web App Managed Identity must be added to this group after deployment
param sqlAdminGroupId = ''
param logAnalyticsWorkspaceName = ''
param applicationInsightsName = ''
param appServicePlanName = ''
param webAppName = ''
param deploymentSlotName = '' // Web App Deployment Slot Managed Identity must be added to this group after deployment
param stagingDatabaseName = ''
