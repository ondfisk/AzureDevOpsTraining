# Challenge 07 - Continuous Deployment

[< Previous](./Challenge-06.md) - **[Home](../README.md)** - [Next >](./Challenge-08.md)

This challenge introduces *Continuous Deployment*.

## Tasks

- Move *Challenge 07* to *Doing*.
- Create a new pipeline called `/pipelines/application.yml`.
- Make sure it only runs on changes to `src/**`, `test/**`, and `pipelines/application.yml`.
- Add build steps to your pipeline (you can use the *assistant* in the browser for help):

  - .NET Core Restore
  - .NET Core Build
  - .NET Core Test
  - .NET Core Publish (`publishWebProjects: true`, `zipAfterPublish: true`, `arguments: --output $(BuildArtifactStagingDirectory)`)
  - Publish Pipeline Artifacts (`targetPath: $(Build.ArtifactStagingDirectory)`, `artifact: drop`, `publishLocation: pipeline`)
  - Azure Web App (`appType: webAppLinux`, `appName: $(webApp)`, `package: '$(Build.ArtifactStagingDirectory)/***.zip'`, `runtimeStack: DOTNETCORE|7.0`)

- Run the pipeline and check that your app has been deployed to Azure.
- Check the pipeline run and find your zipped web app under *Related*.
- Compare your new steps with [`/resources/pipelines/application.yml`](/resources/pipelines/application.yml) and update accordingly.
- Move *Challenge 07* to *Done*.
