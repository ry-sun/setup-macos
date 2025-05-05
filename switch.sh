#! /bin/bash

SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")"
echo "${SCRIPT_PATH}"

darwin-rebuild switch --flake "${SCRIPT_PATH}/nix-darwin" --impure

sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist

home-manager switch --flake "${SCRIPT_PATH}/home-manager" --impure
