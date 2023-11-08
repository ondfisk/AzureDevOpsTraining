# Challenge 06 - Create Web App

[< Previous](./Challenge-05.md) - **[Home](../README.md)** - [Next >](./Challenge-07.md)

This challenge adds a web app to your code base.

## Tasks

- Move *Challenge 06* to *Doing*
- Open VS Code.
- Pull your changes.
- In the Terminal type:

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

- Commit and push code.
- Move *Challenge 06* to *Done*.
