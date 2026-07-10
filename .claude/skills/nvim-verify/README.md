# nvim-verify

Verifies the Neovim config loads cleanly: runs stylua and selene on changed Lua files, then smoke-loads the full config
headlessly.

## Invocation

```
/nvim-verify
```

Also auto-triggers after Claude edits any Lua file. Tools (stylua, selene, nvim) are resolved from Mason's bin at
`~/.local/share/nvim/mason/bin`.

## Examples

**Run after making changes:**

```
/nvim-verify
```

Reports pass/fail/skipped for each of the three checks (format, lint, smoke-load) with file:line details on failure.

**After a plugin swap that broke startup:**

The smoke-load scans headless output for Lua errors (`E5113`, `stack traceback`, `Error executing`, `E\d\d+`) and quotes
the offending line. Fix the error, then re-run `/nvim-verify` to confirm.

## What it checks

| Check      | Scope                     | Tool                     |
| ---------- | ------------------------- | ------------------------ |
| Formatting | Changed `.lua` files only | `stylua --check`         |
| Linting    | Changed `.lua` files only | `selene`                 |
| Smoke-load | Entire config             | `nvim --headless "+qa!"` |

Changed files are collected via `git diff --name-only HEAD` plus untracked files. The repo is not fully
stylua-formatted, so only touched files are checked.
