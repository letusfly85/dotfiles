# Repository Guidelines

## Project Structure & Module Organization
This repository manages personal development environment dotfiles and setup scripts. Core shell/editor configs live at the root: `.zshrc`, `.tmux.conf`, `vimrc`, `wezterm.lua`, and `base_aliases`. Installer scripts (`install-crate.sh`, `install-libraries.sh`, `install-bun.sh`, `install-flutter.sh`) automate tool bootstrapping. Supporting docs are in `docs/` (notably `docs/commit-guideline.md`). Visual assets for terminal themes are stored as `*.png` and `iterm2.itermcolors`.

## Build, Test, and Development Commands
There is no single build system; use targeted shell scripts.
- `./install-crate.sh`: install Rust CLI utilities (e.g., `bat`, `exa`, `hurl`).
- `./install-libraries.sh`: install external CLIs via Homebrew.
- `./install-bun.sh` / `./install-flutter.sh`: install language/runtime tooling.
- `vim -c ':call dein#install()' -c ':qa'`: install Vim plugins after linking `vimrc`.
- `zsh -n .zshrc` and `bash -n install-libraries.sh`: quick syntax checks before PR.

## Coding Style & Naming Conventions
Use POSIX-friendly shell where possible; keep scripts executable and idempotent. Follow existing formatting:
- Shell scripts: `set -e` style safety where appropriate, 2-space or 4-space indentation consistently per file.
- Config files: preserve current style and ordering; append new aliases/settings in related blocks.
- Filenames: use kebab-case for scripts (`install-*.sh`) and conventional dotfile names for configs.
Run `shellcheck` and `shfmt` when editing shell scripts.

## Testing Guidelines
This repo has no formal unit test suite. Validate changes by:
- Running shell syntax checks (`zsh -n`, `bash -n`).
- Executing affected installer scripts in a safe environment.
- Verifying tool/config load manually (e.g., open `wezterm`, start `tmux`, launch `vim`).
Document manual verification steps in the PR.

## Commit & Pull Request Guidelines
Follow `docs/commit-guideline.md`.
- Create small, logically scoped commits.
- Use signed commits (`git commit -S`).
- Prefer Conventional Commit-style prefixes seen in history (`feat`, `fix`, `chore`, `docs`, `refactor`).
- Write clear, specific messages; include impact and rationale when non-trivial.

For PRs, include purpose, key changes, verification steps, and linked issue/PR numbers (e.g., `#33`). Add screenshots when changing terminal/theme visuals.
