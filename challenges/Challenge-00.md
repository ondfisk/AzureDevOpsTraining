# Challenge 00 - Setup

**[Home](../README.md)** - [Next >](./Challenge-01.md)

This challenge ensures you have got the right permissions on Azure and on Azure DevOps, and have the required software installed on your developer machine.

## Requirements

1. Local administrator privileges.
1. Permissions to create a new Azure Subscription *or* *Owner* on an existing Azure Subscription.
1. Permissions to create a new Azure DevOps Project *or* *Project Administrator* on an exiting Azure DevOps Project.
1. Permissions to create Entra ID App Registrations *or* *Owner* on two existing Entra ID App Registrations.

## Tasks

- Create an [Azure](https://azure.microsoft.com/) subscription that you can use for this hack. If you already have a subscription you can use it or you can get a free trial [here](https://azure.microsoft.com/free/).
- Log into the [Azure Portal](https://portal.azure.com/) and confirm that you have an active subscription that you can deploy cloud services to.
- Log into [Azure DevOps](https://dev.azure.com/) using the **SAME** account as you use to log into your Azure Subscription and create a new project called `AzureDevOpsTraining`. The project should be `Private` and (under *Advanced*) use *Git* version control and *Basic* [Work item process](https://learn.microsoft.com/en-us/azure/devops/boards/work-items/guidance/choose-process).
- Download and install:

  - [Git SCM](https://git-scm.com/download)
  - [Visual Studio Code](https://code.visualstudio.com)
  - [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
  - [.NET SDK](https://www.dot.net/)
  - [SQL Server Express LocalDB](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-express-localdb)

  Optional:

  - [Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal)
  - [PowerShell](https://learn.microsoft.com/en-us/powershell)
  - [Azure Data Studio](https://azure.microsoft.com/en-us/products/data-studio/)
  - [Windows Subsystem for Linux (WSL2)](https://learn.microsoft.com/en-us/windows/wsl/) with *Ubuntu*
  - [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)

  **Note**: You can use the [command line](https://learn.microsoft.com/en-us/windows/package-manager/winget/) to install most of it with:

   ```pwsh
   winget install Git.Git
   winget install Microsoft.VisualStudioCode
   winget install Microsoft.AzureCLI
   winget install Microsoft.DotNet.SDK.7
   winget install Microsoft.WindowsTerminal
   winget install Microsoft.PowerShell
   winget install Microsoft.AzureDataStudio
   wsl --install
   winget install Docker.DockerDesktop
   ```

- Connect to your Azure Subscription using the Terminal:

  ```powershell
  # Login
  az login

  # List accounts
  az account list

  # Switch to the subscription you want to use
  az account set --subscription [subscriptionId]
  ```
