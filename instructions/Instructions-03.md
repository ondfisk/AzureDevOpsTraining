# Instructions 03 - Pipelines

[< Previous](./Instructions-02.md) - **[Home](../README.md)** - [Next >](./Instructions-04.md)

## Before challenge

Demonstrate entire challenge

## After challenge

Demonstrate running pipeline

```yaml
trigger:
  - main

pool:
  vmImage: ubuntu-latest

variables:
  configuration: Release

steps:
  - task: DotNetCoreCLI@2
    displayName: .NET Restore
    inputs:
      command: restore

  - task: DotNetCoreCLI@2
    displayName: .NET Build
    inputs:
      command: build
      arguments: --no-restore --configuration $(configuration)

  - task: DotNetCoreCLI@2
    displayName: .NET Publish
    inputs:
      command: publish
      publishWebProjects: true
      zipAfterPublish: true
      arguments: --no-build --configuration $(configuration) --output $(Build.ArtifactStagingDirectory)

  - task: PublishPipelineArtifact@1
    displayName: Publish Artifacts
    inputs:
      targetPath: $(Build.ArtifactStagingDirectory)
      publishLocation: pipeline
      artifact: drop
```
