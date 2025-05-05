<!-- markdownlint-disable first-line-heading first-line-h1 no-inline-html line-length -->

<div align="center">

# 💻 + ❄️ Setup MacOS via Nix

<!-- Badges will be added here -->
Badges Placeholder
</div>

## Introduction

This repository provides an **automated setup** for MacOS using [Nix](https://nixos.org), [nix-darwin](https://github.com/nix-darwin/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager). It allows you to quickly configure a new MacOS system with a consistent set of applications, system preferences, and dotfiles. The configuration includes common productive applications, development tools, configuration for shells and terminal tools.

**Quick Start:**

```bash
curl -sL https://raw.githubusercontent.com/rockmagma02/setup-macos/main/entry.sh | bash
```

## Usage

### Installation

#### Option 1: One-command Installation

The simplest way to install is using the entry script:

```bash
curl -sL https://raw.githubusercontent.com/rockmagma02/setup-macos/main/entry.sh | bash
```

Or with wget:

```bash
wget -qO- https://raw.githubusercontent.com/rockmagma02/setup-macos/main/entry.sh | bash
```

This will:

1. Install the Nix package manager if not already installed
2. Clone this repository to `~/.config/setup-macos`
3. Collect your personal information (name, hostname, email) for personalized configuration
4. Run the installation script that configures your system

#### Option 2: Manual Installation

If you prefer to install manually:

1. Install Nix:

   > The most recommended way to install Nix is using [nix installer from Determinate Systems](https://github.com/DeterminateSystems/nix-installer) (which will provide uninstallation script for convenient management of Nix). But you need to explicitly say `no` when prompted to install `Determinate Nix` to install official Nix. More information please refer to [nix-darwin README](https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#prerequisites).

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
      sh -s -- install
   ```

2. Clone the repository:

   ```bash
   git clone https://github.com/rockmagma02/setup-macos.git ~/.config/setup-macos
   ```

3. Navigate to the repository:

   ```bash
   cd ~/.config/setup-macos
   ```

4. Run the installation script:

   ```bash
   ./install.sh
   ```

### Switching Configurations

After installation, you can update your system with the latest configuration using:

```bash
~/.config/setup-macos/switch.sh
```

This will:

1. Update nix-darwin configuration
2. Update home-manager configuration
3. Restart the necessary services

For more details on customization, see the [Customization](#customization) section.

## Features

The setup provides a comprehensive development environment for macOS with preconfigured tools and settings:

### System Configuration

|       Category       | Features                                                                                                                                                          |
| :------------------: | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  **Time & Locale**   | <ul><li>Asia/Shanghai timezone</li><li>12-hour time format</li><li>Metric units, Celsius</li></ul>                                                                |
| **Power Management** | <ul><li>Configurable sleep timers (display: 6h, system: 8h)</li><li>Power button sleep enabled</li></ul>                                                          |
|      **Finder**      | <ul><li>Show file extensions</li><li>Show path/status bar</li><li>Remove extension change warning</li><li>Auto-cleanup Trash after 30 days</li></ul>              |
|       **Dock**       | <ul><li>Auto-hide enabled</li><li>Size: 48px (64px on hover)</li><li>Position: bottom</li><li>Genie minimize effect</li><li>Preconfigured app shortcuts</li></ul> |
|     **Menu Bar**     | <ul><li>Customized menu items</li><li>Battery percentage shown</li><li>Date & time format customization</li></ul>                                                 |

### Development Tools

|      Category       | Tools                                                                                                                                                                                                                              |
| :-----------------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Version Control** | <ul><li>Git with LFS support</li><li>Git Extras with more useful command</li><li>GitHub CLI with extensions (gh-copilot, gh-eco, gh-skyline, gh-notify, gh-dash)</li><li>Conventional commit aliases</li><li>lazygit TUI</li></ul> |
|    **Terminal**     | <ul><li>iTerm2</li><li>ZSH with Oh-My-Posh</li><li>40+ ZSH plugins</li><li>tmux session manager</li></ul>                                                                                                                          |
| **Shell Utilities** | <ul><li>Modern alternatives: bat, eza, fd, ripgrep</li><li>File processors: jq, yq, pandoc</li><li>Navigation: fzf, ranger</li><li>Performance: btop, htop</li></ul>                                                               |
|     **Editors**     | <ul><li>VS Code & Cursor with shared config</li><li>Neovim</li><li>Auto-synced extensions</li></ul>                                                                                                                                |

### Programming Languages

|    Language    | Tools & Features                                                                                                                |
| :------------: | ------------------------------------------------------------------------------------------------------------------------------- |
|   **Python**   | <ul><li>Python 3.13</li><li>uv package manager</li><li>System-Level IPython & Jupyter</li><li>Conda/Mamba integration</li></ul> |
| **JavaScript** | <ul><li>Bun runtime</li><li>Biome linter/formatter</li><li>NVM integration</li></ul>                                            |
| **Swift/iOS**  | <ul><li>Xcode</li><li>SwiftLint, SwiftFormat</li><li>XcodeGen, ios-deploy, tuist</li></ul>                                      |
|    **Rust**    | <ul><li>Rustup toolchain manager</li></ul>                                                                                      |
|   **C/C++**    | <ul><li>GCC compiler</li><li>Make, CMake, Autotools</li></ul>                                                                   |
|   **Other**    | <ul><li>SQLite with utilities</li><li>Ruby</li><li>TeX/LaTeX (MacTeX)</li></ul>                                                 |

### Applications

|     Category     | Applications                                                                                               |
| :--------------: | ---------------------------------------------------------------------------------------------------------- |
| **Productivity** | <ul><li>Pages, Numbers, Keynote</li><li>Maccy clipboard manager</li><li>Papers reference manager</li></ul> |
| **Development**  | <ul><li>VS Code, Cursor</li><li>Xcode</li></ul>                                                            |
|    **Media**     | <ul><li>IINA player</li></ul>                                                                              |
|  **Utilities**   | <ul><li>Bob translator</li><li>AlDente battery manager</li><li>Adobe Creative Cloud</li></ul>              |

[Screenshots will be added here]

## Customization

### File Architecture

<!-- markdownlint-disable fenced-code-language -->

```
setup-macos/
├── arguments.nix        # User-specific configuration values
├── entry.sh             # Entry point for automatic installation
├── install.sh           # Main installation script
├── switch.sh            # Script to update configuration
├── system/              # System-wide configurations
│   ├── macos.nix        # MacOS specific settings
│   ├── homebrew.nix     # Homebrew package manager config
│   └── shell.nix        # Shell configurations
├── home-manager/        # User environment configuration
│   ├── home.nix         # Home configuration
│   └── flake.nix        # Home-manager flake
├── nix-darwin/          # System configuration
│   ├── configuration.nix # Main configuration file
│   └── flake.nix        # Nix-darwin flake
├── softwares/           # Software installation lists
│   ├── nixPackages.nix  # CLI tools and utilities
│   ├── casks.nix        # GUI applications via Homebrew Cask
│   ├── masApps.nix      # Mac App Store applications
│   ├── brews.nix        # Homebrew formulas
│   └── fonts.nix        # Font installations
├── configurations/      # Application-specific configurations
│   ├── git.nix          # Git configuration
│   ├── zsh.nix          # ZSH configuration
│   ├── vscode.nix       # VS Code settings and extensions
│   └── ...              # Other application configs
└── dotfiles/            # Custom dotfiles
```

<!-- markdownlint-enable fenced-code-language -->

### How to Customize

#### Adding/Removing Software

1. To add new Nix packages, edit `softwares/nixPackages.nix`
2. To add GUI applications, edit `softwares/casks.nix`
3. To add Mac App Store applications, edit `softwares/masApps.nix` with the app ID

#### Customizing System Settings

1. Edit `system/macos.nix` to change MacOS system preferences
2. Edit `system/homebrew.nix` to configure Homebrew behavior

#### User Environment

1. Edit configuration files in `configurations/` directory for specific applications
2. Update `home-manager/home.nix` to add new configurations or environment variables

#### After Making Changes

Run `./switch.sh` to apply your changes. The script will update both nix-darwin and home-manager configurations.

## Known Issues

1. **Service Restart Issue:** Sometimes nix-darwin won't restart the `org.nixos.activate-systems` service after installing new packages, which cause new installed packages can't be found in `PATH`. If you encounter this issue, restart it manually:

   ```bash
   sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist
   sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist
   ```

2. **Home-Manager Integration:** The officially recommended way to use home-manager in darwin is to use it as a module of nix-darwin. However, in the current version, this integration doesn't always trigger home-manager to run properly. For this reason, we run the two modules separately.

## Contributing

Contributions are welcome! Please feel free to ask question in [issues](https://github.com/rockmagma02/setup-macos/issues) or submit a [Pull Request](https://github.com/rockmagma02/setup-macos/pulls).

## License

This project is licensed under the MIT License.
