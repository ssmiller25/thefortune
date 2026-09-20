# Spec: Pure-Go `fortune` utility

## Goal

Replace the dependency on the system `fortune` and `strfile` binaries with a
self-contained Go program that reads fortune text files directly and prints a
random fortune. No C, no external tooling, no third-party Go dependencies.

## Background

This repository is a collection of fortune quotes. The canonical data file is
`devops`, a plain-text file in the classic BSD fortune format:

- A "fortune" (cookie) is one or more lines of text.
- Fortunes are separated by a line containing only the single character `%`.
- The file may or may not end with a trailing `%`.

Today, using the file requires:

```sh
strfile devops      # produces devops.dat (index)
fortune devops      # prints a random cookie
```

Both commands come from the system `fortune` package and are not always
available (notably on Windows). The goal is to replace them with a single Go
binary.

## File format (supported subset)

- UTF-8 plain text.
- Blocks separated by a line consisting of exactly `%`.
- Leading/trailing blank lines around a block are ignored.
- Empty blocks (a `%` followed immediately by another `%`) are skipped.

The current `devops` file contains curly quotes, curly apostrophes, and an
ellipsis character. The Go tool treats the file as opaque UTF-8 text and does
not modify or validate these characters.

## CLI behavior (v1)

```
fortune [flags] [FILE...]
```

- With no `FILE` arguments, read `devops` from the current working directory.
- With one or more `FILE` arguments, read each file and print one random
  fortune from the union of all fortunes across all files.
- If a file cannot be read, or contains no fortunes, report the error on
  stderr and exit with a non-zero status.

### Flags

| Flag | Meaning |
|------|---------|
| `-e` | Equal probability. With multiple files, choose a file first (each with equal probability), then a fortune within it. Without `-e`, weight file selection by number of fortunes in each file (BSD `fortune` behavior). |
| `-n N` | Only consider fortunes whose length is `<= N` characters. |
| `-c` | Disable ANSI color (also honored via the `NO_COLOR` environment variable). |

### Output

Print the selected fortune to stdout. When color is enabled, wrap the output
in ANSI cyan (`\033[36m` ... `\033[39m`) with a leading and trailing blank
line, matching the existing `fortune.sh`:

```sh
echo
echo -e "\033[36m"
fortune devops
echo -e "\033[39m"
echo
```

## Non-goals (v1)

- `strfile` equivalent: no `.dat` index generation or consumption.
- Full BSD flag set (`-a`, `-s`, `-l`, `-m`, `-i`, `-o`, `-w`, `%` ratios).
- Cookie files (files beginning with `(`), rotated/dated files, tilde
  expansion, directory recursion.
- `%` inside a fortune is not escapable (matches this repo's data).

## Design

Flat `package main` in the repository root.

| File | Responsibility |
|------|----------------|
| `main.go` | Flag parsing, file collection, output/color, exit codes. |
| `fortune.go` | `ReadFortuneFile(path) ([]string, error)` — split on `%`, trim blank blocks; `Pick(fortunes []string, rng *rand.Rand) string`. |
| `fortune_test.go` | Table-driven unit tests using small fixture files and a seeded RNG. |

Standard library only: `flag`, `os`, `bufio`, `strings`, `math/rand`,
`errors`.

### Seeding

Accept an optional random seed (e.g. `-seed`) for reproducibility in tests;
default to a time-based seed at runtime.

## Error handling

| Condition | Behavior |
|-----------|----------|
| File not found / unreadable | stderr message, exit 1 |
| No fortunes after parsing | stderr message, exit 1 |
| No file arguments and `devops` missing | stderr message with hint, exit 1 |

## Acceptance criteria

- [ ] `go build ./...` succeeds.
- [ ] `go vet ./...` and `go test ./...` pass.
- [ ] `./fortune devops` prints exactly one quote from `devops`.
- [ ] `./fortune` with no args defaults to `devops`.
- [ ] Multiple files and `-e` selection behave as specified.
- [ ] `-n` filters by length; `-c` / `NO_COLOR` disables color.
- [ ] Deterministic output when `-seed` is supplied.

## Out of scope / future

- `go:embed` the `devops` file into the binary for a single self-contained
  artifact.
- Auto-generate `devops.dat` for compatibility with the system `fortune`.
