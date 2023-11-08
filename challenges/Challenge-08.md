# Challenge 08 - Continuous Integration

[< Previous](./Challenge-07.md) - **[Home](../README.md)** - [Next >](./Challenge-09.md)

This challenge introduces *Continuous Integration* using *Pull Requests*.

**Note**: You may want to check this out [Why Pull Requests Are a Bad Idea](https://www.youtube.com/watch?v=UQrlEXU6RM8).

## Tasks

- Move *Challenge 08* to *Doing*.
- Update your pipeline and ensure *deploy* step only run on:

    ```yaml
    condition: eq(variables['Build.SourceBranch'], 'refs/heads/main')
    ```

- Configure branch protection with your chosen setup for:

  - Branch policies:

    - Require a minimum number of reviewers
    - Check for linked work items
    - Check for comment resolution
    - Limit merge types (enable *Squash Merge* only)

  - Build validation

    - Add *Infrastructure* pipeline with path filter: `/infrastructure/*; /pipelines/infrastructure.yml`.
    - Add *Application* pipeline with path filter: `/src/*; /test/*; /pipelines/application.yml`.

- Try to push changes directly to `main`.
- Create a new branch and change *something* in the app.
- Create Pull Request - attach *Challenge 08*.
- Verify pipeline runs as expected.
- Get it approved and merged.
- Verify that *Challenge 08* was automatically moved to *Done*.
- Verify pipeline runs as expected.
