# Challenge 08 - Continuous Delivery

[< Previous](./Challenge-07.md) - **[Home](../README.md)** - [Next >](./Challenge-09.md)

This challenge introduces *Continuous Delivery*.

## Part 1

- Move *Challenge 08* to *Doing*
- (Continue in the branch from *Challenge 07*)
- Create Service Connection
- Convert to multi-stage pipeline
- Update variables:

    ```yaml
    variables:
      vmImage: ubuntu-latest
      configuration: Release
      azureConnection: ...
      subscriptionId: ...
      resourceGroup: ...
      location: Sweden Central
      webApp: ...
    ```

- Extend *build* stage with Bicep build and template validation:

    ```yaml
    - task: AzureCLI@2
      displayName: Build Bicep Template
      inputs:
        azureSubscription: $(azureConnection)
        scriptType: bash
        scriptLocation: inlineScript
        inlineScript: |
          az bicep build --file $(Build.SourcesDirectory)/infrastructure/main.bicep
          az bicep build-params --file $(Build.SourcesDirectory)/infrastructure/main.bicepparam --outfile $(Build.SourcesDirectory)/infrastructure/main.parameters.json

    - task: AzureResourceManagerTemplateDeployment@3
      displayName: Validate Bicep Template
      inputs:
        deploymentScope: Resource Group
        azureResourceManagerConnection: $(azureConnection)
        subscriptionId: $(subscriptionId)
        action: Create Or Update Resource Group
        resourceGroupName: $(resourceGroup)
        location: $(location)
        templateLocation: Linked artifact
        csmFile: $(Build.SourcesDirectory)/infrastructure/main.json
        csmParametersFile: $(Build.SourcesDirectory)/infrastructure/main.parameters.json
        deploymentMode: Validation
    ```

**Note**: You may want to cf. [https://learn.microsoft.com/en-us/azure/devops/pipelines/build/variables](https://learn.microsoft.com/en-us/azure/devops/pipelines/build/variables).

## Part 2

- Add a *Production* environment to Azure DevOps.
- Add deployment stage to your pipeline with conditions:

  - Depends on build stage
  - Runs only if build succeeded and main branch: `and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))`

- Add deployment job targeting the *Production* environment
- Add steps:

  - Deploy ARM Template
  - Deploy web app:

    ```yaml
    - task: AzureWebApp@1
      displayName: Deploy Web App
      inputs:
        azureSubscription: $(azureConnection)
        appType: webAppLinux
        appName: $(webApp)
        package: '$(System.ArtifactsDirectory)/**/*.zip'
        runtimeStack: DOTNETCORE|7.0
    ```

- Create PR and merge
- Verify you web app has been published in your browser.

## References

[Deploy Azure resources by using Bicep and Azure Pipelines](https://learn.microsoft.com/en-us/training/paths/bicep-azure-pipelines/)