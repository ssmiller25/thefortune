# ci Specification

## Purpose

Continuous integration validates the `devops` fortune file on every change and
compiles it with `strfile` so it stays usable by `fortune`.

## Requirements

### Requirement: Azure Pipelines provider

The CI pipeline SHALL be defined in `azure-pipelines.yml` and run on Azure
Pipelines.

#### Scenario: Azure Pipelines definition

- **WHEN** the CI pipeline runs
- **THEN** it uses the `azure-pipelines.yml` definition on Azure Pipelines

### Requirement: CI triggers

The CI pipeline SHALL run on pushes to `master` and on pull requests targeting
`master`.

#### Scenario: Push to master

- **WHEN** a commit is pushed to `master`
- **THEN** the CI pipeline runs

#### Scenario: Pull request targeting master

- **WHEN** a pull request targeting `master` is opened or updated
- **THEN** the CI pipeline runs

### Requirement: CI runner

The CI pipeline SHALL execute on a Microsoft-hosted Ubuntu Linux runner.

#### Scenario: Ubuntu runner

- **WHEN** the CI pipeline runs
- **THEN** it executes on the `ubuntu-latest` Azure Pipelines image

### Requirement: Fortune file validation

The CI pipeline SHALL validate the `devops` fortune file by running `make test`.

#### Scenario: Validation step

- **WHEN** the CI pipeline runs
- **THEN** it runs `make test`
- **AND** the run fails if the file contains smart quotes or duplicate entries

### Requirement: Fortune file compilation

The CI pipeline SHALL install the `fortune` package and compile the `devops`
file with `strfile`.

#### Scenario: Install and compile

- **WHEN** the CI pipeline runs
- **THEN** it installs the `fortune` package
- **AND** it runs `strfile devops`

### Requirement: Build status badge

The README SHALL display a build status badge for the CI pipeline.

#### Scenario: Badge in README

- **WHEN** the README is rendered
- **THEN** it shows an Azure DevOps build status badge reflecting the latest
  pipeline run
