# Challenge 05 - Azure Pipelines

[< Previous](./Challenge-04.md) - **[Home](../README.md)** - [Next >](./Challenge-06.md)

This challenge introduces *Service connections* and *Azure Pipelines*.

**Note**: You may want to cf. [https://learn.microsoft.com/en-us/azure/devops/pipelines/build/variables](https://learn.microsoft.com/en-us/azure/devops/pipelines/build/variables).

## Tasks

- Move *Challenge 05* to *Doing*.
- Go to *Project settings* `-->` *Pipelines* `-->` *Service connections*.
- Add a new *Azure Resource Manager* service connection:

  - If you may create *App Registrations*: Pick *Workload Identity federation (automatic)*.
  - If not: Pick *Service principal (manual)* and fill in the blanks.
  - Do *not* check *Grant access permission to all pipelines*.

- Go to *Pipelines* `-->` *Pipelines*.
- Create a new *Starter pipeline*.
- Name the pipeline `/pipelines/infrastructure.yml`
- Update trigger section:

  ```yaml
  trigger:
    branches:
      include:
        - main
    paths:
      include:
        - infrastructure/**
        - pipelines/infrastructure.yml
  ```

- Add a variables section at the top with your values:

  ```yaml
  variables:
    azureConnection: ...
    subscriptionId: ...
    resourceGroup: ...
    location: ...
  ```

- Add a step convert your *Bicep* template to *ARM*:

  ```yaml
  - task: AzureCLI@2
    displayName: Build Bicep Template
    inputs:
        azureSubscription: $(azureConnection)
        scriptType: bash
        scriptLocation: inlineScript
        inlineScript: |
          mkdir $(Build.ArtifactStagingDirectory)/infrastructure
          az bicep build --file $(Build.SourcesDirectory)/infrastructure/main.bicep --outfile $(Build.ArtifactStagingDirectory)/infrastructure/main.json
          az bicep build-params --file $(Build.SourcesDirectory)/infrastructure/main.bicepparam --outfile $(Build.ArtifactStagingDirectory)/infrastructure/main.parameters.json
  ```

- *Save a run*
- Ensure pipeline is green
- Add step to *validate* your *ARM* template:

  ```yaml
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
      csmFile: $(Build.ArtifactStagingDirectory)/infrastructure/main.json
      csmParametersFile: $(Build.ArtifactStagingDirectory)/infrastructure/main.parameters.json
      deploymentMode: Validation
  ```

- *Save*
- Ensure pipeline is green
- Check result in the [*Azure Portal*](https://portal.azure.com/) - what has happened?
- Add step to *deploy* your *ARM* template:

  ```yaml
  - task: AzureResourceManagerTemplateDeployment@3
    displayName: Deploy Azure Resources
    inputs:
      ...
      deploymentMode: Incremental
  ```

- *Save*
- Ensure pipeline is green
- Check result in the [*Azure Portal*](https://portal.azure.com/) - what has happened?
- Compare your new steps with [`/resources/pipelines/infrastructure.yml`](/resources/pipelines/infrastructure.yml) and update accordingly.
- Move *Challenge 05* to *Done*.
