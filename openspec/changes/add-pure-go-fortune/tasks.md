## 1. Scaffold

- [ ] 1.1 Verify `go.mod` and `main.go` stub compile with `go build ./...`

## 2. Parser

- [ ] 2.1 Implement `ReadFortuneFile` in `fortune.go` (split on `%`, trim blank lines, skip empty blocks)
- [ ] 2.2 Return an error when the file is unreadable

## 3. Selection

- [ ] 3.1 Implement `Pick` for uniform selection over a `[]string`
- [ ] 3.2 Implement `-e` equal-probability selection across multiple files

## 4. CLI

- [ ] 4.1 Parse flags `-e`, `-n`, `-c`, `-seed` in `main.go`
- [ ] 4.2 Collect `FILE...` args and default to `devops`
- [ ] 4.3 Implement `-n` length filtering
- [ ] 4.4 Exit non-zero on missing/empty file

## 5. Output

- [ ] 5.1 Wrap output in ANSI cyan matching `fortune.sh`
- [ ] 5.2 Honor `NO_COLOR` and `-c`

## 6. Tests

- [ ] 6.1 Add parser tests with fixture files
- [ ] 6.2 Add selection determinism and bounds tests
- [ ] 6.3 Add `-n` and `-e` tests
- [ ] 6.4 Add error-handling tests

## 7. Tooling

- [ ] 7.1 Add `build` and `test` targets to `Makefile`
- [ ] 7.2 Add `go test ./...` step to `azure-pipelines.yml`

## 8. Docs

- [ ] 8.1 Update `README.md` with `go build`/`go run` usage
- [ ] 8.2 Ensure `.gitignore` ignores the built binary
