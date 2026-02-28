#! /bin/bash

SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")"

echo "Link nix-darwin and home-manager..."
sudo rm -f /etc/nix-darwin
sudo ln -s ${SCRIPT_PATH}/nix-darwin /etc/nix-darwin
rm -f ~/.config/home-manager
ln -s ${SCRIPT_PATH}/home-manager ~/.config/home-manager

echo "Switch to new configurations..."
sudo darwin-rebuild switch

sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist

home-manager switch --impure
