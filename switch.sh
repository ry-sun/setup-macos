#!/bin/bash

set -euo pipefail

SCRIPT_PATH="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
export SETUP_MACOS_NIX_DARWIN_ARGS="${SCRIPT_PATH}/nix-darwin/args.local.nix"
export SETUP_MACOS_HOME_MANAGER_ARGS="${SCRIPT_PATH}/home-manager/args.local.nix"

if [ ! -f "$SETUP_MACOS_NIX_DARWIN_ARGS" ] || [ ! -f "$SETUP_MACOS_HOME_MANAGER_ARGS" ]; then
    echo "Missing generated args.local.nix files. Run ./install.sh first or copy args.nix to args.local.nix."
    exit 1
fi

darwin_hostname="$(nix eval --impure --raw --expr "(import \"$SETUP_MACOS_NIX_DARWIN_ARGS\").hostname")"
home_manager_user="$(nix eval --impure --raw --expr "(import \"$SETUP_MACOS_HOME_MANAGER_ARGS\").user")"

echo "Link nix-darwin and home-manager..."
sudo rm -f /etc/nix-darwin
sudo ln -s "${SCRIPT_PATH}/nix-darwin" /etc/nix-darwin
rm -f ~/.config/home-manager
ln -s "${SCRIPT_PATH}/home-manager" ~/.config/home-manager

echo "Update nix-darwin and home-manager"
cd "${SCRIPT_PATH}/nix-darwin" || exit
nix flake update
cd "${SCRIPT_PATH}/home-manager" || exit
nix flake update

echo "Switch to new configurations..."
sudo -E darwin-rebuild switch

sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist 2>/dev/null || true
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist

home-manager switch --impure
