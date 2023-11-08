# Challenge 13 - Deploying Cloud Data

[< Previous](./Challenge-12.md) - **[Home](../README.md)** - [Next >](./Challenge-14.md)

This challenge deploys your data-driven application to Azure SQL.

## Tasks

- Move *Challenge 13* to *Doing*
- Create new branch to work in.
- Give web app a system-assigned managed identity (update Bicep template).
- Create an Entra ID group: *My Web App SQL Admins*.
- Add yourself, the AzDo Service Connection, and the web app to the group.
- Add a SQL Server and SQL Database to your Bicep template:

    ```bicep
    resource sqlServer 'Microsoft.Sql/servers@2023-02-01-preview' = {
      name: sqlServerName
      location: location
      identity: {
        type: 'SystemAssigned'
      }
      properties: {
        administrators: {
          administratorType: 'ActiveDirectory'
          azureADOnlyAuthentication: true
          login: sqlAdminGroupName
          principalType: 'Group'
          sid: sqlAdminGroupId
        }
      }

      resource azureServices 'firewallRules' = {
        name: 'AllowAllWindowsAzureIps'
        properties: {
          startIpAddress: '0.0.0.0'
          endIpAddress: '0.0.0.0'
        }
      }
    }
    ```

- Add connection string to web app:

    ```bicep
    resource connectionStrings 'Microsoft.Web/sites/config@2022-09-01' = {
      name: 'connectionstrings'
      parent: webApp
      properties: {
        ConnectionString: {
          value: 'Server=tcp:${sqlServer.properties.fullyQualifiedDomainName},1433;Initial Catalog=${databaseName};Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;Authentication="Active Directory Default";'
          type: 'SQLAzure'
        }
      }
    }
    ```

- Update pipeline to build migrations

    ```yaml
    - task: Bash@3
      displayName: Install EF Tool
      inputs:
        targetType: inline
        script: |
          dotnet tool install --global dotnet-ef

    - task: Bash@3
      displayName: Build EF migrations bundle
      inputs:
        targetType: inline
        script: |
          dotnet ef migrations bundle --project src/MyApp/ --configuration $(configuration) --no-build --self-contained --output $(Build.ArtifactStagingDirectory)/efbundle

    - task: AzureCLI@2
      displayName: Apply EF migrations bundle
      inputs:
        azureSubscription: $(azureConnection)
        scriptType: bash
        scriptLocation: inlineScript
        inlineScript: |
          CONNECTION_STRING=$(az webapp config connection-string list --name $(webApp) --resource-group $(resourceGroup) --query [].value --output tsv)
          chmod +x $(Build.ArtifactStagingDirectory)/drop/efbundle
          $(Build.ArtifactStagingDirectory)/drop/efbundle --connection "$CONNECTION_STRING"
    ```

- Create PR and merge.
- Interact with the updated web app.
- Verify that the *Movies* page is working.
