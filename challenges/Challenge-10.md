# Challenge 10 - Continuous Security

[< Previous](./Challenge-09.md) - **[Home](../README.md)** - [Next >](./Challenge-11.md)

This challenge introduces authentication and authorization with *Entra ID*.

## Tasks

- Move *Challenge 10* to *Doing*
- Configure App Registration in Entra ID:

  - Name: `MyApp`
  - Supported account types: `Accounts in this organizational directory only (ondfisk only - Single tenant)`
  - Redirect URI (optional): `Web` `-->` `https://localhost/signin-oidc`
  - Implicit grant and hybrid flows: Check `ID tokens (used for implicit and hybrid flows)`
  - API Permissions:

    - `Microsoft Graph` -> `User.Read`

  - Find and record *Tenant Id*, *Primary Domain*, and *Client Id*.

- Create new branch
- Configure authentication for your web app:

  - Add `AzureAd` section to `appsettings.json`:

    ```json
    "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "Domain": "[tenant].onmicrosoft.com",
        "TenantId": "[tenantId]",
        "ClientId": "[clientId]",
        "CallbackPath": "/signin-oidc"
    },
    ```

    - Update all packages to latest using `dotnet list package --outdated`
    - Update `Properties/launchSettings.json` - remove `http` section.
    - Add references:

      - `Microsoft.AspNetCore.Authentication.JwtBearer`
      - `Microsoft.AspNetCore.Authentication.OpenIdConnect`
      - `Microsoft.Identity.Web`
      - `Microsoft.Identity.Web.UI`

    - Update `Program.cs`:

        ```csharp
        // Add services to the container.
        builder.Services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
            .AddMicrosoftIdentityWebApp(builder.Configuration.GetSection("AzureAd"));
        builder.Services.AddControllersWithViews()
            .AddMicrosoftIdentityUI();

        builder.Services.AddAuthorization(options =>
        {
            // By default, all incoming requests will be authorized according to the default policy
            options.FallbackPolicy = options.DefaultPolicy;
        });

        ...

        builder.Services.AddServerSideBlazor()
            .AddMicrosoftIdentityConsentHandler();

        ...

        app.UseAuthentication();
        app.UseAuthorization();
        app.MapControllers();
        ```

    - Replace `App.Razor`:

        ```xml
        <CascadingAuthenticationState>
            <Router AppAssembly="@typeof(App).Assembly">
                <Found Context="routeData">
                    <AuthorizeRouteView RouteData="@routeData" DefaultLayout="@typeof(MainLayout)" />
                    <FocusOnNavigate RouteData="@routeData" Selector="h1" />
                </Found>
                <NotFound>
                    <PageTitle>Not found</PageTitle>
                    <LayoutView Layout="@typeof(MainLayout)">
                        <p role="alert">Sorry, there's nothing at this address.</p>
                    </LayoutView>
                </NotFound>
            </Router>
        </CascadingAuthenticationState>
        ```

    - Add `Shared/LoginDisplay.razor`:

        ```xml
        <AuthorizeView>
            <Authorized>
                Hello, @context.User.Identity?.Name!
                <a href="MicrosoftIdentity/Account/SignOut">Log out</a>
            </Authorized>
            <NotAuthorized>
                <a href="MicrosoftIdentity/Account/SignIn">Log in</a>
            </NotAuthorized>
        </AuthorizeView>
        ```

    - Update `Shared/Main.Layout.razor` - add `<LoginDisplay />` before *About* link:

        ```xml
        <div class="top-row px-4 auth">
            <LoginDisplay />
            <a href="https://docs.microsoft.com/aspnet/" target="_blank">About</a>
        </div>
        ```

- Test authentication locally.
- Add your web apps public endpoint to redirect URIs:

    `https://[yourappname].azurewebsites.net/signin-oidc`

- Create PR and merge
- Verify your updates have been published in your browser and authentication works.
