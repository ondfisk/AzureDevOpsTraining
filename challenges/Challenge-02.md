# Challenge 02 - Version control

[< Previous](./Challenge-01.md) - **[Home](../README.md)** - [Next >](./Challenge-03.md)

This challenge introduces *Azure Repos* and *Blazor* with *ASP.NET Core*.

## Tasks

- Move *Challenge 02* to *Doing*
- Initialize repository with `README.md` and *Visual Studio* `.gitignore`
- Clone to you local machine.
- Open in VS Code.
- Add the [`/.vscode`](/.vscode) files from this repository and commit changes.
- Restart VS Code to pickup extensions.
- In the *Terminal* type:

    ```pwsh
    # Create Blazor Server project:
    dotnet new blazorserver --output src/MyApp

    # Navigate to app:
    pushd src/MyApp

    # Restore, build, run
    dotnet restore
    dotnet build
    dotnet run
    ```

- Open the app in a browser and test it
- Go back to the *Terminal*
- Press `[Ctrl]` + `[c]` to close it.

    ```pwsh
    # Go back
    popd

    # Create XUnit Test project:
    dotnet new xunit --output test/MyApp.Tests

    # Connect web and test projects
    dotnet add test/MyApp.Tests reference src/MyApp

    # Create Visual Studio solution:
    dotnet new sln

    # Add projects to solution:
    dotnet sln add src/MyApp
    dotnet sln add test/MyApp.Tests

    # Run tests
    dotnet test
    ```

- Add, commit, and push changes.
- Inspect repo in browser.
- Move *Challenge 02* to *Done*
