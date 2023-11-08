# Challenge 13 - Staging

[< Previous](./Challenge-12.md) - **[Home](../README.md)**

This challenge adds a deployment slot and a staging database, allowing you to test your live application before deployment.

## Part 1

- Move *Challenge 13* to *Doing*
- Create new branch to work in.
- Using the [Azure Portal](https://portal.azure.com/) first:

    - Add deployment slot for staging
    - Add new SQL database for staging
    - Update the connection string for staging - make sure you tick `Slot Setting`

- Update `main.bicep` and `main.bicepparams` to match the changes you made in the portal:

    - Add deployment slot - `resource deploymentSlot 'Microsoft.Web/sites/slots@2022-09-01'` with `parent: webApp`
    - Add staging database
    - Add staging connection string - `resource slotConnectionStrings 'Microsoft.Web/sites/slots/config@2022-09-01'`
    - Add slot config names:

        ```bicep
        resource slotConfigNames 'Microsoft.Web/sites/config@2022-09-01' = {
          name: 'slotConfigNames'
          parent: webApp
          properties: {
            appSettingNames: []
            azureStorageConfigNames: []
            connectionStringNames: [
              'ConnectionString'
            ]
          }
        }
        ```

- Create PR and merge.
- Validate resources in the [Azure Portal](https://portal.azure.com/).
- Add staging slot identity to SQL Admin group.
- Add staging slot URI to redirect URIs in your Entra ID App Registration.

## Part 2

- Create new branch to work in.
- Make a change to `Pages/Index.razor`.
- Update pipeline:

    - Create `Stage` stage between `Build` and `Deploy`
    - `Stage` should only run on pull request - `eq(variables['Build.Reason'], 'PullRequest')`
    - `Stage` should deploy to `staging` deployment slot
    - Update `Deploy` stage to swap slots instead of deploy web app:

        ```yaml
        - task: AzureAppServiceManage@0
            displayName: Swap Deployment Slots
            inputs:
            azureSubscription: $(azureConnection)
            WebAppName: $(webApp)
            Action: Swap Slots
            ResourceGroupName: $(resourceGroup)
            SourceSlot: $(deploymentSlot)
            SwapWithProduction: true
        ```

- Create PR.
- Validate staging resources in the Azure Portal.
- Approve and merge.
- Validate production in a browser.
- Validate staging contains the old version.
