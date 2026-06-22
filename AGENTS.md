# AGENTS.md

Guidance for AI agents (and humans) working in this repository.

## Repo overview

This is a personal **Neovim configuration**.

- Entry point: `init.lua`.
- Plugin manager: **lazy.nvim**, bootstrapped in `lua/plugin-manager.lua`
  (cloned from `--branch=stable`).
- Configuration lives under `lua/`:
  - `lua/plugins/` — one file per plugin (the plugin spec / config).
  - `lua/plugin-manager.lua` — lazy.nvim bootstrap + `setup()`.
  - `lua/styling.lua`, `lua/utilities.lua`, `lua/local-config.lua`, etc.
  - `lua/themes/`, `lua/ui/`.
- Other config dirs: `after/`, `colors/`, `ftdetect/`, `plugin/`, `spell/`,
  `templates/`.
- Tooling configs present: `stylua.toml`, `selene.toml`, `.prettierrc`,
  `.editorconfig`, `.luarc.json`.

## Commit conventions

This repo uses **Conventional Commits with scopes**. **No gitmoji.**

```
<type>(<scope>): <short summary>
```

- Types in use: `feat`, `fix`, `refactor`, `chore`, `docs`.
- Scopes seen in history: `lsp`, `diff`, `ui`, `treesitter`, `ftdetect`,
  `highlightGroups`, `templates`, and similar feature/area names. Pick the scope
  that matches the area you touched; omit the scope for repo-wide changes.

Examples:

```
feat(lsp): add lensline.nvim with focused toggle via snacks
refactor(diff): replace diffview.nvim with codediff.nvim
chore(deps): bump lazy-lock.json
docs: add AGENTS.md with lockfile handling and commit conventions
```

## Lockfile handling (`lazy-lock.json`) — important

`lazy-lock.json` is lazy.nvim's lockfile. It pins **every plugin to an exact
commit SHA** and is **tracked in git** (intentionally — it makes plugin versions
reproducible across machines). Treat it like `package-lock.json`.

### When to commit it alone vs. bundled

Decide by **what caused the change**:

- **Pure version bump** — you ran `:Lazy update` / `:Lazy sync` /
  `:Lazy restore` and **only `lazy-lock.json` changed** (no `.lua`/config edits)
  → **commit it on its own**:

  ```
  chore(deps): bump lazy-lock.json
  ```

  These standalone commits are your **checkpoints**: each is a reproducible,
  known-good plugin snapshot you can `git revert`, `git bisect`, or
  `:Lazy restore` back to.

- **Consequence of a config change** — you added, removed, replaced, or pinned a
  plugin, so both a `lua/plugins/*.lua` file **and** `lazy-lock.json` changed →
  **bundle the lockfile into the same commit** as the config change. This keeps
  each commit atomic so the config and the locked versions never disagree at any
  point in history (e.g.
  `refactor(diff): replace diffview.nvim with codediff.nvim` includes its
  lockfile change).

Rule of thumb: **the lockfile travels with the manifest change that produced it;
pure bumps stand alone.**

### Using it as a checkpoint (restore workflow)

A committed `lazy-lock.json` is a git-tracked restore point for plugin
**versions** (not for config). To roll back a bad update:

1. `git checkout <good-commit> -- lazy-lock.json`
2. In Neovim, run `:Lazy restore` — this resets every plugin to the SHA recorded
   in the lockfile.

### Don't

- **Never hand-edit `lazy-lock.json`.** Always regenerate it via lazy.nvim
  commands (`:Lazy update`, `:Lazy sync`, `:Lazy restore`).

## Lockfiles in general (reference)

The same policy applies to lockfiles in any ecosystem you might encounter:

1. **Commit the lockfile** (for applications / end products — reproducible
   installs).
2. **Bundle it with the manifest change that produced it** (never let the
   manifest and lockfile drift apart across separate commits).
3. **Pure dependency bumps get standalone commits** (conventionally
   `chore(deps): ...`).
4. **Never hand-edit** — regenerate via the tool.

Common lockfiles: `package-lock.json` / `yarn.lock` / `pnpm-lock.yaml` /
`bun.lock` (JS), `Cargo.lock` (Rust), `poetry.lock` / `uv.lock` / `Pipfile.lock`
(Python), `composer.lock` (PHP), `Gemfile.lock` (Ruby), `go.sum` (Go),
`flake.lock` (Nix), `.terraform.lock.hcl` (Terraform).

**Compiled/generated artifacts are NOT lockfiles** and should be git-ignored,
not committed — e.g. `plugin/packer_compiled.lua` is correctly listed in
`.gitignore`.
