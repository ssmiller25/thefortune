# Implementation task list

- [ ] **1. Scaffold Go module**
  - `go.mod` with module path `github.com/ssmiller25/thefortune`, `go 1.27`.
  - Minimal compiling `main.go` stub.

- [ ] **2. Parser — `ReadFortuneFile`**
  - Read file with `bufio.Scanner`.
  - Split into blocks on lines equal to `%`.
  - Trim blank leading/trailing lines per block; skip empty blocks.
  - Return `[]string` of fortunes.

- [ ] **3. Random selection — `Pick`**
  - Accept `[]string` and `*rand.Rand`.
  - Uniform selection over the slice.
  - `-e` support: select a file uniformly first, then a fortune within it.

- [ ] **4. CLI — `main.go`**
  - Parse flags: `-e`, `-n N`, `-c`, `-seed`.
  - Collect `FILE...` args; default to `devops`.
  - Wire parse → select → print.

- [ ] **5. Output formatting**
  - ANSI cyan wrapper matching `fortune.sh`.
  - `NO_COLOR` env and `-c` flag disable color.

- [ ] **6. Tests — `fortune_test.go`**
  - Fixture files (inline via `t.TempDir()`).
  - Parser: block splitting, trimming, empty-block skipping, missing file.
  - Selection: determinism with seeded RNG; bounds.
  - `-n` filtering; `-e` multi-file behavior.

- [ ] **7. Build tooling**
  - `Makefile`: `build`, `test` targets calling `go build`/`go test`.
  - `azure-pipelines.yml`: add a `go test ./...` step.

- [ ] **8. Docs**
  - Update `README.md` with `go build`/`go run` usage.
  - `.gitignore`: ignore the built binary.
