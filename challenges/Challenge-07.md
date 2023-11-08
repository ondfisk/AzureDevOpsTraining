# Challenge 07 - Infrastructure as Code

[< Previous](./Challenge-06.md) - **[Home](../README.md)** - [Next >](./Challenge-08.md)

This challenge introduces *Infrastructure as Code* with *Bicep*.

## Tasks

- Move *Challenge 07* to *Doing*
- Delete existing Azure resources (web app, app service plan, resource group)
- Create a new branch to work in.
- Create an `/infrastructure` folder with these two [`main.bicep`](/resources/infrastructure/main.bicep) and [`main.bicepparam`](/resources/infrastructure/main.bicepparam) files.
- Update `main.bicepparam`.
- Create a new resource group using the command line:

    ```pwsh
    az group create --name "AzureDevOpsTraining" --location "swedencentral"
    ```

- Deploy your template using the command line:

    ```pwsh
    az deployment group create --resource-group "AzureDevOpsTraining" --template-file ./infrastructure/main.bicep --parameters ./infrastructure/main.bicepparam
    ```

- Delete Azure resources.
- Commit and complete PR.
