# Repository Guidelines

## Project Structure & Module Organization

This repository provisions a macOS development machine with Nix, nix-darwin, Home Manager, and Homebrew.

- `entry.sh`, `install.sh`, and `switch.sh` are the main bootstrap and update entrypoints.
- `nix-darwin/` contains system-level configuration. Use `nix-darwin/settings/` for macOS, shell, and Homebrew behavior, and `nix-darwin/install/` for formulas, casks, fonts, and Mac App Store apps.
- `home-manager/` contains user-level configuration. Add per-tool modules in `home-manager/configurations/`, packages in `home-manager/install.nix`, and linked editor/tool settings in `home-manager/dotfiles/`.
- `args.nix` files contain tracked placeholders; `args.local.nix` files contain generated user-specific values and should stay untracked.

## Build, Test, and Development Commands

- `./install.sh`: collect user details, link flakes, and apply the initial nix-darwin and Home Manager setup.
- `./switch.sh`: update both flakes and switch the active system and user configurations.
- `cd nix-darwin && nix flake check`: validate the system flake.
- `cd home-manager && nix flake check`: validate the user flake.
- `pre-commit run --all-files`: run repository hygiene checks for JSON, YAML, line endings, executable shebangs, and whitespace.

## Coding Style & Naming Conventions

Use 2-space indentation in Nix, JSON, JSONC, TOML, and YAML unless a file already establishes another style. Keep Nix modules small and purpose-named, for example `home-manager/configurations/zed.nix` or `nix-darwin/settings/macos.nix`. Prefer sorted, readable package lists when editing install files. Shell scripts should keep `bash` shebangs, quote variable expansions, and preserve executable bits.

## Testing Guidelines

There is no separate unit test suite. Treat flake evaluation and activation as the main validation path. Run `nix flake check` in the flake you changed, then run `pre-commit run --all-files`. For changes that affect installed software or macOS defaults, run `./switch.sh` on a suitable machine and verify the resulting app, shell, or dotfile behavior.

## Commit & Pull Request Guidelines

Git history uses short conventional-style messages such as `feat: update codex config`, `fix: do not show docker in omp`, and `chore: update`. Keep commits focused on one tool or configuration area.

Pull requests should include a concise summary, affected paths, validation commands run, and any manual verification notes. Include screenshots only for visible editor, terminal, or macOS UI changes.

## Security & Configuration Tips

Do not commit secrets, access tokens, private hostnames, or personal email changes accidentally. Review `args.local.nix`, SSH, Git, and app configuration diffs carefully before committing.
