#!/bin/bash

set -euo pipefail

SCRIPT_PATH="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
export SETUP_MACOS_NIX_DARWIN_ARGS="${SCRIPT_PATH}/nix-darwin/args.local.nix"
export SETUP_MACOS_HOME_MANAGER_ARGS="${SCRIPT_PATH}/home-manager/args.local.nix"

# Get current user name
current_user=$(whoami)
arch="$(uname -m)"

nix_escape_string() {
    local value="$1"
    value="${value//\\/\\\\}"
    value="${value//\"/\\\"}"
    value="${value//$'\n'/\\n}"
    value="${value//$'\r'/\\r}"
    value="${value//$'\t'/\\t}"
    value="${value//\$\{/\\\$\{}"
    printf '%s' "$value"
}

# Try to get name from iCloud as fallback
icloud_first_name=""
icloud_last_name=""
if [ -f "$HOME/Library/Preferences/MobileMeAccounts.plist" ]; then
    if command -v plutil &>/dev/null; then
        icloud_first_name=$(plutil -extract Accounts.0.firstName raw "$HOME/Library/Preferences/MobileMeAccounts.plist" 2>/dev/null || echo "")
        icloud_last_name=$(plutil -extract Accounts.0.lastName raw "$HOME/Library/Preferences/MobileMeAccounts.plist" 2>/dev/null || echo "")
    fi
fi

# Collect user information with fallbacks
read -rp "Enter your first name [${icloud_first_name:=$current_user}]: " first_name </dev/tty
first_name=${first_name:-$icloud_first_name}

read -rp "Enter your last name [${icloud_last_name}]: " last_name </dev/tty
last_name=${last_name:-$icloud_last_name}

read -rp "Enter your desired hostname [${current_user}-MacBook]: " hostname </dev/tty
while [[ -z "$hostname" || ! "$hostname" =~ ^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$ ]]; do
    echo "Please enter a valid hostname."
    read -rp "Enter your desired hostname [${current_user}-MacBook]: " hostname </dev/tty
done

read -rp "Enter your email: " email </dev/tty
while [[ -z "$email" || ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; do
    echo "Please enter a valid email address."
    read -rp "Enter your email: " email </dev/tty
done

user_value=$(nix_escape_string "$current_user")
first_name_value=$(nix_escape_string "$first_name")
last_name_value=$(nix_escape_string "$last_name")
hostname_value=$(nix_escape_string "$hostname")
email_value=$(nix_escape_string "$email")

# Update local generated args. Tracked args.nix files document the shape.
cat >"$SETUP_MACOS_NIX_DARWIN_ARGS" <<EOF
rec {
  user = "${user_value}";
  firstname = "${first_name_value}";
  lastname = "${last_name_value}";
  fullname = "\${firstname} \${lastname}";
  home = "/Users/\${user}";
  hostname = "${hostname_value}";
  email = "${email_value}";
}
EOF
cat >"$SETUP_MACOS_HOME_MANAGER_ARGS" <<EOF
rec {
  user = "${user_value}";
  firstname = "${first_name_value}";
  lastname = "${last_name_value}";
  fullname = "\${firstname} \${lastname}";
  home = "/Users/\${user}";
  hostname = "${hostname_value}";
  email = "${email_value}";
}
EOF

echo "Updated args.local.nix with your information!"
echo "-----------------------------------------"
echo "User: $current_user"
echo "Name: $first_name $last_name"
echo "Hostname: $hostname"
echo "Email: $email"
echo "Architecture: $arch"
echo "-----------------------------------------"

echo "Install Command Line Tools..."
if xcode-select -p &>/dev/null; then
    echo "Command Line Tools are already installed, skipping installation."
else
    xcode-select --install
fi
sudo xcodebuild -license accept

echo "Install Homebrew..."
if command -v brew &>/dev/null; then
    echo "Homebrew is already installed, skipping installation."
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Link nix-darwin and home-manager..."
sudo rm -f /etc/nix-darwin
sudo ln -s "${SCRIPT_PATH}/nix-darwin" /etc/nix-darwin
rm -f ~/.config/home-manager
ln -s "${SCRIPT_PATH}/home-manager" ~/.config/home-manager

echo "Installing nix-darwin and home-manager configurations..."
sudo -E nix run nix-darwin/master#darwin-rebuild -- switch --impure --flake "/etc/nix-darwin#${hostname}"

sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist 2>/dev/null || true
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist

# Disable this line if you didn't install Xcode
sudo xcodebuild -license accept

nix run home-manager/master -- switch --impure

echo "Installation complete! Your MacOS has been configured successfully."
