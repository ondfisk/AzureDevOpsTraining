# Challenge 04 - Infrastructure as Code

[< Previous](./Challenge-03.md) - **[Home](../README.md)** - [Next >](./Challenge-05.md)

This challenge introduces *Infrastructure as Code* with *Bicep*.

## Tasks

- Move *Challenge 04* to *Doing*.
- Run:

  ```pwsh
  az account list-locations
  ```

  Compare output with:

  ```pwsh
  az account list-locations --query [].displayName --output tsv
  ```

- Pick a location for your resources.
- Pick a name for your resource group, e.g. `App` or `AzureDevOpsTraining`.
- Pick a name for your web app (must be globally unique), e.g. `web-5b53b1b60756`.
- Create an `/infrastructure` folder with these two [`main.bicep`](/resources/infrastructure/main.bicep) and [`main.bicepparam`](/resources/infrastructure/main.bicepparam) files.
- Update `main.bicepparam`.
- Create a new resource group using the command line:

  ```pwsh
  az group create --name ... --location ...
  ```

- Deploy your template using the command line:

  ```pwsh
  az deployment group create --resource-group ... --template-file ./infrastructure/main.bicep --parameters ./infrastructure/main.bicepparam
  ```

- Check your subscription - what has been created?
- Delete Azure resources:

  ```pwsh
  az group delete --name ... --no-wait --yes
  ```

- Commit and push code.
- Move *Challenge 04* to *Done*.
