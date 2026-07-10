---
name: nvim-verify
description: Verifies this Neovim config still loads and passes its linters/formatter after a change. Use after editing any Lua under lua/, plugin/, after/, colors/, or ftdetect/, or whenever asked to check/verify/smoke-test the config. Runs stylua, selene, and a headless Neovim load.
allowed-tools: Bash(nvim *) Bash(stylua *) Bash(selene *)
---

# Verify the Neovim config

This config has no test suite; verification is "does it lint, format-check, and load cleanly". Run all three checks from the repo root, then report results.

`stylua`, `selene`, and every other tool are **Mason-provisioned, not on the login-shell `PATH`**. Prepend Mason's bin so the bare commands resolve (or rely on the pre-approved `stylua`/`selene` names):

```sh
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
```

A tool that still doesn't resolve is an uninstalled Mason package (`mason-tool-installer` installs it on the next Neovim start), **not** a reason to install it system-wide — see `lua/plugins/lsp/AGENTS.md` → "Tool provisioning — Mason, not the system". If a tool is genuinely absent, report that rather than skipping the check.

**Scope format/lint to the files this change touched, not the whole repo.** The repo is not fully stylua-formatted (column-aligned assignments) and carries some pre-existing selene warnings; a whole-repo check is all noise. Collect the changed Lua files first:

```sh
{ git diff --name-only --diff-filter=d HEAD -- '*.lua'
  git ls-files --others --exclude-standard -- '*.lua'; } | sort -u
```

## Checks

1. **Format check** — run `stylua --check` on the changed files only. Non-zero exit = not formatted. Show the diff; offer to run `stylua` on them. If no Lua files changed, skip and say so.
2. **Lint** — run `selene` on the changed files only. Report warnings/errors with file:line. Pre-existing warnings in untouched files are out of scope.
3. **Smoke-load** (always whole-config) — `nvim --headless "+qa!" 2>&1` Scan the output for Lua load errors: `E5113`, `stack traceback`, `Error executing`, or any `E\d\d+`. Clean output (and a prompt return) = the config loaded without raising.

## Reporting

- State each check as **pass**, **fail**, or **skipped** (no Lua changed).
- On failure, quote the offending command output (file:line and the error/diff) rather than summarizing — the caller needs the exact location.
- Only call the config verified when format + lint (on changed files) and the smoke-load all pass.

Note: the first headless load on a fresh machine may trigger lazy.nvim/mason installs and extra output; that's expected, not a failure. Judge by error tracebacks, not by length of output.
