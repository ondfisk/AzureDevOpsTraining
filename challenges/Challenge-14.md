# Challenge 14 - Staging

[< Previous](./Challenge-13.md) - **[Home](../README.md)** - [Next >](./Challenge-15.md)

This challenge adds a deployment slot, allowing you to test your live application before deployment.

## Part 1

- Move *Challenge 14* to *Doing*
- Create new branch to work in.
- Using the [Azure Portal](https://portal.azure.com/) first:

  - Add deployment slot for staging

- Update `main.bicep` and `main.bicepparams` to match the changes you made in the portal:

  - Add deployment slot - `resource deploymentSlot 'Microsoft.Web/sites/slots@2022-09-01'` with `parent: webApp`

- Create PR and merge.
- Validate resources in the [Azure Portal](https://portal.azure.com/).

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
