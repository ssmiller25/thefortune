# Project Context: thefortune

A collection of fortune-cookie quotes in the classic BSD `fortune` format,
packaged with a self-contained pure-Go `fortune` utility.

## Tech Stack

- Go 1.27, standard library only (no third-party dependencies)
- Flat `package main` layout at the repository root

## Conventions

- Fortune data lives in `devops`, a UTF-8 text file with fortunes separated by
  lines containing only `%`.
- Build: `go build ./...`; test: `go test ./...`
- CI: Azure Pipelines (`azure-pipelines.yml`)
- Planning follows OpenSpec (this `openspec/` directory).
