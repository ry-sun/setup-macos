#!/bin/bash

SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")"

# Get current user name and architecture
current_user=$(whoami)
architecture=$(uname -m)
if [[ "$architecture" == "arm64" ]]; then
    arch="aarch64"
else
    arch="x86_64"
fi

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

# Update arguments.nix
cat >arguments.nix <<EOF
rec {
  user = "${current_user}";
  firstName = "${first_name}";
  lastName = "${last_name}";
  fullName = "\${firstName} \${lastName}";
  hostname = "${hostname}";
  home = "/Users/\${user}";
  email = "${email}";
  arch = "${arch}";
}
EOF

echo "Updated arguments.nix with your information!"
echo "-----------------------------------------"
echo "User: $current_user"
echo "Name: $first_name $last_name"
echo "Hostname: $hostname"
echo "Email: $email"
echo "Architecture: $arch"
echo "-----------------------------------------"

echo "Installing nix-darwin and home-manager configurations..."

# Run the configuration commands
nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch --flake "${SCRIPT_PATH}/nix-darwin#${hostname}" --impure

sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist

# Disable this line if you didn't install Xcode
sudo xcodebuild -license accept

nix run home-manager/master#home-manager -- switch --flake "${SCRIPT_PATH}/home-manager" --impure

echo "Installation complete! Your MacOS has been configured successfully."
