# Implementation Tasks

## 1. Workflow

- [x] 1.1 Add `.github/workflows/ci.yml` with `on` triggers for `push` to `master` and `pull_request` to `master`.
- [x] 1.2 Configure the job to run on `ubuntu-latest`.
- [x] 1.3 Add `actions/checkout@v4` as the first step.
- [x] 1.4 Add a `make test` step.
- [x] 1.5 Add a step to install `fortune` (`sudo apt-get update && sudo apt-get -y install fortune`).
- [x] 1.6 Add a `strfile devops` step.
- [x] 1.7 Fix the pre-existing false positive in the `make test` duplicate check, which assumed every non-`%` line starts with `"` and so rejected the multi-line entry at `devops:139-141`; replace the `grep -v -e ' 1 "'` filter with `awk '$$1 > 1'` so the guard still catches real duplicates.

## 2. Documentation

- [x] 2.1 Replace the Azure DevOps badge URL in `README.md` with the GitHub Actions badge URL.

## 3. Cutover

- [x] 3.1 Open a PR with the workflow and confirm it runs green. (PR #23; the `test` job succeeded on the `pull_request` event.)
- [x] 3.2 Merge the PR. (Merged to `master` as `1093415` on 2026-10-03; review requirement overridden by the author.)
- [x] 3.3 Delete `azure-pipelines.yml`. (Removed once the GitHub Actions `test` job was green on `master`.)
- [x] 3.4 Update branch protection required checks, if any, to reference the new "test" check. (Not applicable: `master` has no `required_status_checks` configured, so nothing referenced the old Azure check.)
- [ ] 3.5 Delete the Azure DevOps pipeline definition after a grace period.

## 4. Specification

- [x] 4.1 Apply the delta in `specs/ci/spec.md` to `openspec/specs/ci/spec.md`, deleting the `Azure Pipelines provider` requirement and its scenario.
- [x] 4.2 Rewrite the `CI runner` requirement to drop `Microsoft-hosted` and reference the `ubuntu-latest` GitHub Actions runner.
- [x] 4.3 Rewrite the `Fortune file validation` and `Fortune file compilation` requirements so they describe steps of a GitHub Actions workflow.
- [x] 4.4 Rewrite the `Build status badge` requirement to require a GitHub Actions badge instead of an Azure DevOps badge.
- [x] 4.5 Confirm `openspec/specs/ci/spec.md` has no remaining references to Azure Pipelines, Azure DevOps, `azure-pipelines.yml`, or Microsoft-hosted runners.
- [x] 4.6 Run `openspec validate migrate-ci-to-github-actions --strict`.

## 5. Verification

- [x] 5.1 Confirm a push to `master` and a PR to `master` both trigger the workflow. (`pull_request` run on `migration/gh-actions` and `push` run `37129883854` on `master` both completed successfully.)
- [x] 5.2 Confirm the README badge reflects the GitHub Actions run status. (Badge returns HTTP 200 with title `CI - passing`.)
