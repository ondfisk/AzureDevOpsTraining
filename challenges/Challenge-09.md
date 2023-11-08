# Challenge 09 - Continuous Quality

[< Previous](./Challenge-08.md) - **[Home](../README.md)** - [Next >](./Challenge-10.md)

This challenge introduces *Continuous Quality*.

**Note**: See [Test Razor components in ASP.NET Core Blazor](https://learn.microsoft.com/en-us/aspnet/core/blazor/test) for instructions.

## Tasks

- Move *Challenge 09* to *Doing*
- Create a new branch to work in.
- Add `bunit` to test project:

    ```pwsh
    dotnet add test/MyApp.Tests package bunit
    ```

- Update the `GlobalUsings.cs`:

    ```csharp
    global using Bunit;
    global using Xunit;
    global using MyApp.Pages;
    ```

- Rename `UnitTest1.cs` to `CounterTests.cs` and replace content:

    ```csharp
    public class CounterTests
    {
        [Fact]
        public void CounterShouldIncrementWhenClicked()
        {
            // Arrange
            using var ctx = new TestContext();
            var cut = ctx.RenderComponent<Counter>();
            var paraElm = cut.Find("p");

            // Act
            cut.Find("button").Click();

            // Assert
            var paraElmText = paraElm.TextContent;
            paraElmText.MarkupMatches("Current count: 1");
        }
    }
    ```

- Run locally with `dotnet test`
- Make the test fail - check with `dotnet test`
- Publish code and create pull request
- Inspect result of build, PR, and tests
- Fix test and push change
- Approve and merge PR
