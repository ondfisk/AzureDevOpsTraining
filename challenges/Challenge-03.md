# Challenge 03 - Pipelines

[< Previous](./Challenge-02.md) - **[Home](../README.md)** - [Next >](./Challenge-04.md)

This challenge introduces *Azure Pipelines*.

## Tasks

- Move *Challenge 03* to *Doing*
- Create a new starter pipeline
- Run on `ubuntu-latest`
- Use the *assistant* to add steps for:

    - .NET Core Restore
    - .NET Core Build
    - .NET Core Test
    - .NET Core Publish (`publishWebProjects: true`, `zipAfterPublish: true`, `arguments: --output $(Build.ArtifactStagingDirectory)`)
    - Publish Pipeline Artifacts

- Run the pipeline and verify that it published a zipped version of your web app.
- Move *Challenge 03* to *Done*