<!-- markdownlint-disable first-line-heading first-line-h1 no-inline-html line-length -->

<div align="center">

# 💻 + ❄️ Setup MacOS via Nix

[![macOS](https://img.shields.io/badge/macOS-Sequoia%20%2B-black?logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Nix](https://img.shields.io/badge/Nix-flakes-5277C3?logo=nixos&logoColor=white)](https://nixos.org/)
[![nix-darwin](https://img.shields.io/badge/nix--darwin-enabled-7D56F4)](https://github.com/nix-darwin/nix-darwin)
[![Home%20Manager](https://img.shields.io/badge/home--manager-enabled-40A02B)](https://github.com/nix-community/home-manager)
[![Homebrew](https://img.shields.io/badge/Homebrew-managed-FBB040?logo=homebrew&logoColor=black)](https://brew.sh/)
[![Apple%20Silicon](https://img.shields.io/badge/Apple%20Silicon-aarch64--darwin-333333?logo=apple&logoColor=white)](https://developer.apple.com/documentation/apple-silicon)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
</div>

## Introduction

This repository provides an **automated macOS setup** built on [Nix](https://nixos.org), [nix-darwin](https://github.com/nix-darwin/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager). The setup is split intentionally:

- `nix-darwin` manages system settings, Homebrew packages, casks, fonts, and Mac App Store apps
- `home-manager` manages CLI tools, shell configuration, editor settings, dotfiles, and user-level activation tasks

The repository also includes bootstrap and switch scripts so a new machine can be provisioned quickly and then kept up to date with one command.

**Quick Start:**

```bash
curl -sL https://raw.githubusercontent.com/ry-sun/setup-macos/main/entry.sh | bash
```

## Usage

### Installation

#### Option 1: One-command Installation

The simplest way to install is using the entry script:

```bash
curl -sL https://raw.githubusercontent.com/ry-sun/setup-macos/main/entry.sh | bash
```

Or with wget:

```bash
wget -qO- https://raw.githubusercontent.com/ry-sun/setup-macos/main/entry.sh | bash
```

This will:

1. Install the Nix package manager if it is not already available
2. Clone or update this repository at `~/.config/setup-macos`
3. Run `install.sh`, which collects personal information and writes both `nix-darwin/args.nix` and `home-manager/args.nix`
4. Install Xcode command line tools and Homebrew
5. Link `nix-darwin` to `/etc/nix-darwin` and `home-manager` to `~/.config/home-manager`
6. Apply the `nix-darwin` flake, restart the activation launch daemon, and then run `home-manager switch --impure`

#### Option 2: Manual Installation

If you prefer to install manually:

1. Install Nix:

   > This repository currently expects the Determinate Systems installer path used by `entry.sh`, but with `NIX_INSTALLER_DETERMINATE=false` so the result is official Nix. For background, see the [nix-darwin prerequisites](https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#prerequisites).

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
      sh -s -- install
   ```

2. Clone the repository:

   ```bash
   git clone git@github.com:ry-sun/setup-macos.git ~/.config/setup-macos
   ```

3. Navigate to the repository:

   ```bash
   cd ~/.config/setup-macos
   ```

4. Run the installation script:

   ```bash
   ./install.sh
   ```

During installation you will be prompted for:

1. First name
2. Last name
3. Desired hostname
4. Email address

Those values are written into the generated `args.nix` files and reused by both flakes.

### Switching Configurations

After installation, update the machine with:

```bash
~/.config/setup-macos/switch.sh
```

This script currently:

1. Re-links `/etc/nix-darwin` and `~/.config/home-manager` to the repository
2. Runs `nix flake update` in both `nix-darwin` and `home-manager`
3. Applies the new system configuration with `darwin-rebuild switch`
4. Restarts `org.nixos.activate-system.plist`
5. Applies the user configuration with `home-manager switch --impure`

For more details on customization, see the [Customization](#customization) section.

## Features

The setup provides a macOS development environment with declarative system settings, Homebrew-managed GUI software, and Home Manager-managed CLI tooling and dotfiles.

### System Configuration

|      Category       | Features                                                                                                                                                                                                                                   |
| :-----------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|  **Time & Locale**  | <ul><li>Timezone set to `Asia/Shanghai`</li><li>12-hour clock in menu bar</li><li>Metric units, centimeters, and Celsius</li><li>`TZ`, `LANG`, and `LC_ALL` exported in the user environment</li></ul>                                     |
| **Power / Updates** | <ul><li>Automatic macOS updates enabled</li><li>Guest login disabled</li><li>Nix flakes enabled</li><li>Unfree packages allowed in both layers</li></ul>                                                                                   |
|     **Finder**      | <ul><li>Show file extensions</li><li>Hide hidden files by default</li><li>Search current folder by default</li><li>Show path bar and status bar</li><li>Remove extension change warning</li><li>Auto-clean Trash</li></ul>                 |
|      **Dock**       | <ul><li>Auto-hide enabled</li><li>Magnification enabled</li><li>Bottom dock with Genie minimize effect</li><li>Persistent app shortcuts for Safari, Messages, Mail, Notes, Music, VS Code, Zed, Ghostty, Loon, and ChatGPT Atlas</li></ul> |
|    **Menu Bar**     | <ul><li>AirDrop, Focus, and Now Playing menu extras enabled</li><li>Battery percentage shown</li><li>Clock shows weekday, day of month, AM/PM, and seconds</li></ul>                                                                       |
|     **Shells**      | <ul><li>`zsh` and `bash` registered as login shells</li><li>`zsh` configured as the default shell</li><li>System-level completion and shell helpers enabled through nix-darwin</li></ul>                                                   |

### Development Tools

|      Category       | Tools                                                                                                                                                                                                                                                                                                |
| :-----------------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Version Control** | <ul><li>`gitFull` with LFS</li><li>`gitflow`, `git-extras`, `gitoxide`, `hub`</li><li>GitHub CLI with `gh-eco`, `gh-skyline`, `gh-notify`, `gh-dash`, and Copilot CLI</li><li>Home Manager Git config with `nvimdiff`, Zed diff support, and conventional commit aliases</li><li>`lazygit`</li></ul> |
|    **Terminal**     | <ul><li>Ghostty and iTerm2 configuration</li><li>`zsh` with Oh My Zsh, Antidote plugins, autosuggestions, syntax highlighting, and Oh My Posh</li><li>`bash` with Homebrew, conda, mamba, and nvm init</li><li>`tmux` and shell integrations</li></ul>                                               |
| **Shell Utilities** | <ul><li>`bat`, `eza`, `fd`, `ripgrep`, `fzf`, `zoxide`, `tree`</li><li>`jq`, `yq`, `highlight`, `exiftool`, `mediainfo`, `trash-cli`</li><li>`btop`, `htop`, `clock-rs`, `pay-respects`</li><li>Archive, PDF, HTML, CSV/XLSX, image, video, and font utilities</li></ul>                             |
|     **Editors**     | <ul><li>Neovim installed at both system and user layers</li><li>VS Code settings/keybindings plus synced extensions via `vscode-extension-sync`</li><li>Zed settings/keymaps/tasks/debug config linked via Home Manager</li><li>Codex configuration and MCP integration</li></ul>                    |
|  **File Managers**  | <ul><li>`ranger` with `ranger_devicons` plugin</li><li>`yazi` with synced plugins via `yazi-plugin-sync`, including `ya pkg` plugins and manually cloned plugins</li></ul>                                                                                                                           |

### Programming Languages

|    Language    | Tools & Features                                                                                                                                                                                                                           |
| :------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|   **Python**   | <ul><li>`python314`, `uv`, IPython, `nbconvert`, `pygments`</li><li>Conda and Mamba shell initialization via Miniforge</li><li>Managed `.condarc` and IPython profile files</li></ul>                                                      |
| **JavaScript** | <ul><li>`bun` and `biome` from Nix</li><li>`nvm` from Homebrew</li><li>Activation hook to install the latest LTS Node.js</li></ul>                                                                                                         |
| **Swift/iOS**  | <ul><li>Xcode from the Mac App Store</li><li>`swiftlint`, `swiftformat`, `xcodegen`, `xcbeautify`, `tuist`, `ios-deploy`, `xcode-build-server`</li><li>Activation hook accepts Xcode license and selects the developer directory</li></ul> |
|    **Rust**    | <ul><li>`rustup` from Nix</li><li>Activation hook installs stable and nightly toolchains plus `rustfmt`, `clippy`, and `rust-analyzer`</li></ul>                                                                                           |
|   **C/C++**    | <ul><li>`cmake`, `automake`, `autoconf`</li><li>Uses Apple toolchain / Xcode command line tools rather than overriding the system compiler</li></ul>                                                                                       |
|   **Other**    | <ul><li>`sqlite`, `sqlite-utils`, `duckdb`</li><li>`ruby`</li><li>`texliveFull`, `tex-fmt`, `typst`, `typstyle`</li><li>Nix formatting and language tooling: `alejandra`, `nil`, `nixfmt`</li></ul>                                        |

### Applications

|     Category     | Applications                                                                                                                                                     |
| :--------------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Productivity** | <ul><li>Pages, Numbers, Keynote</li><li>Bob and BobHelper</li><li>Papers and Papers extension</li><li>Zoom</li><li>Color Picker</li></ul>                        |
| **Development**  | <ul><li>Visual Studio Code</li><li>Zed</li><li>Xcode</li><li>Ghostty</li><li>iTerm2</li><li>Codex and Codex App</li><li>ChatGPT, Claude, ChatGPT Atlas</li></ul> |
|    **Media**     | <ul><li>IINA</li><li>Discord</li></ul>                                                                                                                           |
|  **Utilities**   | <ul><li>Miniforge</li><li>AlDente</li><li>Adobe Creative Cloud</li><li>Loon appears in the Dock config but is not installed by this repository</li></ul>         |

## Customization

### File Architecture

<!-- markdownlint-disable fenced-code-language -->

```
setup-macos/
├── entry.sh                    # Bootstrap script: install Nix, clone/update repo, run install.sh
├── install.sh                  # Collect user data, link flakes, apply nix-darwin and home-manager
├── switch.sh                   # Update both flakes and switch both configurations
├── nix-darwin/                 # System-level macOS and Homebrew configuration
│   ├── args.nix                # Generated user-specific values for nix-darwin
│   ├── base.nix                # Main nix-darwin module
│   ├── flake.nix               # nix-darwin flake
│   ├── install/
│   │   ├── brews.nix           # Homebrew formulas
│   │   ├── casks.nix           # Homebrew casks
│   │   ├── fonts.nix           # Homebrew font casks
│   │   └── masApps.nix         # Mac App Store apps
│   └── settings/
│       ├── homebrew.nix        # Homebrew activation behavior
│       ├── macos.nix           # macOS defaults and host settings
│       └── shell.nix           # System shell registration and defaults
├── home-manager/               # User environment configuration
│   ├── args.nix                # Generated user-specific values for home-manager
│   ├── base.nix                # Main Home Manager module
│   ├── flake.nix               # Home Manager flake
│   ├── install.nix             # User-level package list
│   ├── configurations/         # Per-tool Home Manager modules
│   │   ├── git.nix
│   │   ├── ghostty.nix
│   │   ├── vscode.nix
│   │   ├── yazi.nix
│   │   ├── zed.nix
│   │   └── ...
│   └── dotfiles/               # Files linked or consumed by Home Manager modules
└── README.md
```

<!-- markdownlint-enable fenced-code-language -->

### How to Customize

#### Adding/Removing Software

1. Edit `home-manager/install.nix` for user-scoped CLI packages installed by Home Manager
2. Edit `nix-darwin/install/brews.nix` for Homebrew formulas
3. Edit `nix-darwin/install/casks.nix` for GUI applications
4. Edit `nix-darwin/install/fonts.nix` for fonts
5. Edit `nix-darwin/install/masApps.nix` for Mac App Store applications

#### Customizing System Settings

1. Edit `nix-darwin/settings/macos.nix` to change macOS defaults, hostname handling, Dock, Finder, and menu bar behavior
2. Edit `nix-darwin/settings/homebrew.nix` to change Homebrew activation and cleanup policy
3. Edit `nix-darwin/settings/shell.nix` to change login shell registration or system shell features

#### User Environment

1. Edit the modules in `home-manager/configurations/` for program-specific behavior
2. Edit files under `home-manager/dotfiles/` for linked configs such as Git ignore rules, editor settings, IPython config, iTerm2 config, Codex config, Ranger config, Yazi config, and Zed config
3. Update `home-manager/base.nix` to add imports, session variables, or session paths
4. Update generated helper commands such as `vscode-extension-sync` and `yazi-plugin-sync` via their corresponding Home Manager modules

#### After Making Changes

Run `./switch.sh` to apply your changes. The script updates both flakes, re-links `nix-darwin` and `home-manager`, applies the system config, restarts the activation daemon, and then applies the Home Manager config.

## Known Issues

1. **Service Restart Issue:** `switch.sh` and `install.sh` explicitly restart `org.nixos.activate-system.plist` because new packages are not always visible in `PATH` immediately after the `nix-darwin` switch. If you need to do this manually, run:

   ```bash
   sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist
   sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist
   ```

2. **Separate nix-darwin and home-manager runs:** This repository intentionally applies `nix-darwin` and `home-manager` as two separate steps instead of embedding Home Manager as a nix-darwin module. That matches the current scripts and avoids cases where Home Manager does not run reliably during the darwin switch.

3. **Bootstrap assumptions:** The repository assumes Apple Silicon (`aarch64-darwin`), Homebrew under `/opt/homebrew`, and a local checkout at `~/.config/setup-macos`. If you change those assumptions, you will likely need to update the scripts and some Home Manager modules.

## Contributing

Contributions are welcome! Please feel free to ask question in [issues](https://github.com/ry-sun/setup-macos/issues) or submit a [Pull Request](https://github.com/ry-sun/setup-macos/pulls).

## License

This project is licensed under the MIT License.
