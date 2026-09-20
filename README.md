# Fortune files for those of us.

[![Build Status](https://dev.azure.com/ssmiller25/thefortune/_apis/build/status/ssmiller25.thefortune?branchName=master)](https://dev.azure.com/ssmiller25/thefortune/_build/latest?definitionId=1&branchName=master)

To compile fortune
```sh
strfile devops
```

To run at prompt, copy fortune.sh to /etc/profile.d/

## Testing

Basic sanity tests can be run manually by calling:

```sh
make test
```

## Development workflow (OpenSpec)

This repo uses [OpenSpec](https://openspec.dev) for spec-driven development.
Specs (the system as built) live in `openspec/specs/`; in-progress work lives in
`openspec/changes/`.

1. **Explore** an idea: `/opsx-explore "your idea"`
2. **Propose** a change: `/opsx-propose "your idea"` (writes the plan only)
3. **Review** the plan: read `openspec/changes/<name>/proposal.md`, its `specs/`
   delta, and `tasks.md`.
4. **Apply** the plan: `/opsx-apply` (implements `tasks.md`, ticking off each
   step)
5. **Archive** the change: `/opsx-archive` (merges the delta into `specs/`)

Validate a change manually with:

```sh
openspec validate <change-name> --strict
```

The OpenSpec CLI and its workflow files are checked in under `openspec/` and
`.opencode/`. See the [OpenSpec docs](https://openspec.dev/docs) for details.

## Using on Windows

1. [Download Windows Fortune](https://github.com/Lmpessoa/Fortune)  
2. Create install folder to put it in - Such as C:\\Fortune  
3. Create data folder under the previously created install folder - Such as
C:\\Fortune\\Data  
4. Unzip the file from step 1 into the folder created in step 2  
5. Download the file `devops` from this repo into the data folder created in
step 3
6. Open File Explorer and in the navigation bar put `shell:startup`  
7. Create a shortcut in the startup folder that points at the Fortune.exe
unzipped in step 4  
