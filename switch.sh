#! /bin/bash

SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")"
echo "${SCRIPT_PATH}"

darwin-rebuild switch --flake "${SCRIPT_PATH}/nix-darwin" --impure || (echo "Running darwin-rebuild switch failed. Please check the logs for details, and try again." && exit 1)

sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist

home-manager switch --flake "${SCRIPT_PATH}/home-manager" --impure || (echo "Running home-manager switch failed. Please check the logs for details, and try again." && exit 1)
