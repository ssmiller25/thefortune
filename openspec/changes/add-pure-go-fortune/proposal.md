## Why

The repository ships fortune data (`devops`) but depends on the system
`fortune` and `strfile` binaries to compile and print it. Those binaries are
not always available (notably on Windows) and require a separate `strfile`
compile step. A self-contained pure-Go utility removes both dependencies.

## What Changes

### 1. Add a pure-Go `fortune` CLI

- Read `%`-delimited fortune text files directly (no `.dat` index).
- Print one randomly selected fortune to stdout.
- Default to the `devops` file when no file argument is given.

### 2. Support multi-file selection and filtering

- Accept one or more fortune files.
- `-e` selects a file with equal probability; otherwise weight by fortune count.
- `-n N` limits results to fortunes of length `<= N` characters.

### 3. Match existing output formatting

- Wrap output in ANSI cyan (matching `fortune.sh`).
- `-c` flag and `NO_COLOR` disable color.

### 4. Provide testable, deterministic behavior

- `-seed` flag for reproducible selection.
- Unit tests using fixture files.

## Capabilities

### New Capabilities

- `fortune`: Parse fortune files and print a random fortune in pure Go.

## Impact

- New files: `main.go`, `fortune.go`, `fortune_test.go`.
- New module: `go.mod`.
- Updated: `Makefile`, `azure-pipelines.yml`, `README.md`, `.gitignore`.
- No changes to the existing `devops` data file.
- No breaking changes to the data format.
