# Implementation Tasks

## 1. Workflow

- [ ] 1.1 Add `.github/workflows/ci.yml` with `on` triggers for `push` to `master` and `pull_request` to `master`.
- [ ] 1.2 Configure the job to run on `ubuntu-latest`.
- [ ] 1.3 Add `actions/checkout@v4` as the first step.
- [ ] 1.4 Add a `make test` step.
- [ ] 1.5 Add a step to install `fortune` (`sudo apt-get update && sudo apt-get -y install fortune`).
- [ ] 1.6 Add a `strfile devops` step.

## 2. Documentation

- [ ] 2.1 Replace the Azure DevOps badge URL in `README.md` with the GitHub Actions badge URL.

## 3. Cutover

- [ ] 3.1 Open a PR with the workflow and confirm it runs green.
- [ ] 3.2 Merge the PR.
- [ ] 3.3 Delete `azure-pipelines.yml`.
- [ ] 3.4 Update branch protection required checks, if any, to reference the new "test" check.
- [ ] 3.5 Delete the Azure DevOps pipeline definition after a grace period.

## 4. Verification

- [ ] 4.1 Confirm a push to `master` and a PR to `master` both trigger the workflow.
- [ ] 4.2 Confirm the README badge reflects the GitHub Actions run status.
