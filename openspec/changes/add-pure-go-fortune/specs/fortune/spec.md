## Purpose

Provide a self-contained pure-Go replacement for the system `fortune` and
`strfile` binaries that reads `%`-delimited fortune text files and prints a
random fortune.

## ADDED Requirements

### Requirement: Fortune File Parsing
The system SHALL read a UTF-8 fortune file and return each fortune as a
separate entry, split on lines containing only `%`.

#### Scenario: Split on delimiter
- GIVEN a file containing three fortunes separated by `%` lines
- WHEN the file is parsed
- THEN three fortunes are returned

#### Scenario: Trailing delimiter optional
- GIVEN a file whose final fortune has no trailing `%` line
- WHEN the file is parsed
- THEN the final fortune is still returned

#### Scenario: Empty blocks skipped
- GIVEN a file containing consecutive `%` lines
- WHEN the file is parsed
- THEN empty fortunes are not returned

### Requirement: Random Selection
The system SHALL print exactly one randomly selected fortune.

#### Scenario: Uniform selection
- GIVEN a parsed set of fortunes
- WHEN a fortune is selected
- THEN a single fortune is returned from the set

#### Scenario: Deterministic with seed
- GIVEN a fixed seed
- WHEN a fortune is selected
- THEN the same fortune is selected on every run with that seed

### Requirement: Default Data File
The system SHALL read the `devops` file when no file argument is provided.

#### Scenario: No arguments
- GIVEN a working directory containing `devops`
- WHEN the command runs with no arguments
- THEN one fortune from `devops` is printed

### Requirement: Multiple File Selection
The system SHALL support reading multiple fortune files.

#### Scenario: Equal probability
- GIVEN two fortune files of unequal size
- WHEN the `-e` flag is set
- THEN each file has an equal chance of being chosen before a fortune within
  it is selected

### Requirement: Length Filtering
The system SHALL filter fortunes by character length when `-n N` is provided.

#### Scenario: Long fortunes excluded
- GIVEN a fortune longer than N characters
- WHEN `-n N` is set
- THEN that fortune is not selected

### Requirement: Output Formatting
The system SHALL print the selected fortune wrapped in ANSI cyan escape
sequences.

#### Scenario: Color enabled
- GIVEN a selected fortune
- WHEN color is not disabled
- THEN the output begins with a cyan escape and ends with a reset escape

#### Scenario: Color disabled
- GIVEN the `NO_COLOR` environment variable or the `-c` flag
- WHEN the fortune is printed
- THEN no ANSI color escapes are emitted

### Requirement: Error Handling
The system SHALL report unreadable or empty files and exit non-zero.

#### Scenario: Missing file
- GIVEN a file path that does not exist
- WHEN the command runs
- THEN an error is written to stderr and the exit status is non-zero

#### Scenario: No fortunes
- GIVEN a file with no `%`-delimited fortunes
- WHEN the command runs
- THEN an error is written to stderr and the exit status is non-zero
