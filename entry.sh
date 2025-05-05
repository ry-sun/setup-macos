#!/bin/bash

set -eo pipefail

echo "==== MacOS Setup Bootstrapper ===="
echo "This script will:"
echo "1. Install Nix package manager"
echo "2. Clone setup-macos repository to ~/.config/setup-macos"
echo "3. Run the installation script"
echo "===================================="
echo ""

# Install Nix package manager
echo "Installing Nix package manager..."
if command -v nix &>/dev/null; then
    echo "Nix is already installed, skipping installation."
else
    echo "Installing Nix..."
    NIX_INSTALLER_NO_CONFIRM=true NIX_INSTALLER_DETERMINATE=false \
        curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix |
        sh -s -- install

    # Source nix environment if this is a fresh install
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
fi

# Clone the repository
REPO_URL="https://github.com/rockmagma02/setup-macos.git"
REPO_PATH="$HOME/.config/setup-macos"

echo "Cloning setup-macos repository to $REPO_PATH..."
if [ -d "$REPO_PATH" ]; then
    echo "Repository directory already exists."
    echo "Updating repository..."
    cd "$REPO_PATH"
    git pull origin main
else
    echo "Cloning repository..."
    mkdir -p "$(dirname "$REPO_PATH")"
    git clone "$REPO_URL" "$REPO_PATH"
    cd "$REPO_PATH"
fi

# Run the installation script
echo "Running installation script..."
chmod +x "$REPO_PATH/install.sh"
bash "$REPO_PATH/install.sh" || (echo "The installation script failed. Please check the logs for details, and try again." && exit 1)

echo "Setup completed successfully!"
