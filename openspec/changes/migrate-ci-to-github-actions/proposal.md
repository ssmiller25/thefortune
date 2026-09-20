## Why

- CI currently runs on Azure Pipelines (`azure-pipelines.yml`). The repo is
  hosted on GitHub and is already using GitHub for PRs and issues, so running
  CI on GitHub Actions keeps everything in one place.
- GitHub Actions is free for public repos and requires no separate Azure DevOps
  project or service connection to maintain.
- The README build badge points at Azure DevOps and will break once the Azure
  pipeline is removed; it must move to a GitHub Actions badge.

## What Changes

- **Add** `.github/workflows/ci.yml` that reproduces the current pipeline:
  checkout, `make test`, install `fortune`, and `strfile devops`, on
  `ubuntu-latest`, triggered by push to `master` and PRs targeting `master`.
- **Update** `README.md` to use the GitHub Actions badge URL in place of the
  Azure DevOps badge.
- **Remove** `azure-pipelines.yml` once the new workflow is green.

## Impact

- **Specs:** `ci`
- **Code / config:**
  - `.github/workflows/ci.yml` (new)
  - `azure-pipelines.yml` (deleted)
  - `README.md` (badge URL only)
- **External:** the Azure DevOps pipeline definition for this repo becomes
  obsolete and can be deleted after a grace period.

## Notes

- No secrets, environments, or service connections are used by either pipeline,
  so no credential migration is required.
- `make test` is the default Makefile goal and runs unchanged.
