# ci Specification

## Purpose

Continuous integration validates the `devops` fortune file on every change and
compiles it with `strfile` so it stays usable by `fortune`.

## Requirements

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

The CI pipeline SHALL execute on a GitHub-hosted Ubuntu Linux runner.

#### Scenario: Ubuntu runner

- **WHEN** the CI pipeline runs
- **THEN** it executes on a `ubuntu-latest` GitHub Actions runner

### Requirement: Fortune file validation

The CI pipeline SHALL validate the `devops` fortune file by running `make test`
in a GitHub Actions workflow.

#### Scenario: Validation step

- **WHEN** the workflow runs
- **THEN** it checks out the repository
- **AND** it runs `make test`
- **AND** the run fails if the file contains smart quotes or duplicate entries

### Requirement: Fortune file compilation

The CI pipeline SHALL install the `fortune` package and compile the `devops`
file with `strfile`.

#### Scenario: Install and compile

- **WHEN** the workflow runs
- **THEN** it refreshes the apt package index and installs the `fortune` package
- **AND** it runs `strfile devops`

### Requirement: Build status badge

The README SHALL display a GitHub Actions build status badge for the CI
workflow.

#### Scenario: Badge in README

- **WHEN** the README is rendered
- **THEN** it shows a GitHub Actions badge pointing at the CI workflow
- **AND** the badge is no longer sourced from Azure DevOps
