## Technical Approach

Flat `package main` in the repository root, using only the Go standard library.

## Architecture Decisions

### Decision: Parse text directly instead of generating a `.dat` index
`strfile` exists to make random access O(1) on very large files. The `devops`
file is small enough that reading the whole file into memory and splitting on
`%` is simpler and removes a compile step. No `.dat` generation.

### Decision: Flat package main
A single-binary CLI does not need internal package separation. Logic is split
across `main.go` (CLI) and `fortune.go` (parse + select) for testability.

### Decision: Seeded RNG for testability
Accept a `-seed` flag and default to a time-based seed so tests can assert
determinism.

## File Changes

- `main.go` (new): flag parsing, file collection, output, exit codes
- `fortune.go` (new): `ReadFortuneFile`, `Pick`
- `fortune_test.go` (new): table-driven tests with fixture files
- `go.mod` (exists): module scaffold
- `Makefile`, `azure-pipelines.yml`, `README.md`, `.gitignore`: wiring
