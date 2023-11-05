# Challenge 05 - Continuous Quality

[< Previous](./Challenge-04.md) - **[Home](../README.md)** - [Next >](./Challenge-06.md)

This challenge introduces *Continuous Quality*.

## Tasks

**Note**: See [Test Razor components in ASP.NET Core Blazor](https://learn.microsoft.com/en-us/aspnet/core/blazor/test) for instructions.

- Move *Challenge 05* to *Doing*
- Create a new branch to work in.
- Create new `xunit` project - `MyWebApp.Tests` under `/tests`.
- Add test project to solution (`dotnet sln add -h`)
- Go to your test project and add a reference to the web project (`dotnet add reference -h`)
- Add `bunit` to test project (`dotnet add package -h`)
- Update the `GlobalUsings.cs` file to include `Bunit`, `Xunit`, and `MyWebApp.Pages`.
- Replace `UnitTest1.cs` with `CounterTests.cs` to test project:

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
- Extend pipeline with `dotnet test`
- Make the test fail
- Publish code and create pull request
- Inspect result of build, PR, and tests
- Fix test
- Approve and merge PR
