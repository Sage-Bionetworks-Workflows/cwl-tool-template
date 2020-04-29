# dockstore-tool-template
A template project for setting up a containerized CWL Tool.

# Description

This template sets up an opinionated way to organize Docker, CWL, and tests for a CWL tool to be published on Dockstore.

## Dockerfile

A Dockerfile should exist in the top level directory of this repository.

## CWL

A directory [cwl](cwl) should contain tool definitions in the CWL language.

## Tests

Tests for the CWL tool should be added to the [tests](tests) directory.

## Continuous Deployment and Versioning

This template uses GitHub actions to perform automated versioning, version bumping, building of tagged Docker images, and pushing images to DockerHub.

### Credentials

This uses GitHub secrets to store credentials for the GitHub action to push to the `sagebionetworks` DockerHub account using a service account. It also uses a service GitHub account for commiting new version automatically. All repositories that are generated from this template will need to have this service account added to it.

### DockerHub

Ideally, the name of the DockerHub repository should be the same as the GitHub repository. The workflow uses this name by default as the name of the DockerHub branch to push to.

### Versioning

This requires two files: `SOFTWARE_VERSION` (which maps to the version of the main software tool being wrapped by the CWL tool) and `VERSION` which maps to the software version plus a build version (looks like `X.Y.Z--B` where `B` is a monotonically increasing integer that is increased on every push to the master branch of the repository.

The action is available at [.github/workflows/bump-version-and-build.yml](.github/workflows/bump-version-and-build.yml).

