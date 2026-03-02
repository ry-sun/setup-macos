#!/bin/bash

SCRIPT_PATH="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

# Get current user name
current_user=$(whoami)

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

# Update args.nix
cat >nix-darwin/args.nix <<EOF
rec {
  user = "${current_user}";
  firstname = "${first_name}";
  lastname = "${last_name}";
  fullname = "\${firstname} \${lastname}";
  home = "/Users/\${user}";
  hostname = "${hostname}";
  email = "${email}";
}
EOF
cat >home-manager/args.nix <<EOF
rec {
  user = "${current_user}";
  firstname = "${first_name}";
  lastname = "${last_name}";
  fullname = "\${firstname} \${lastname}";
  home = "/Users/\${user}";
  hostname = "${hostname}";
  email = "${email}";
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

echo "Install Command Line Tools..."
xcode-select --install
sudo xcodebuild -license accept

echo "Install Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Link nix-darwin and home-manager..."
sudo rm -f /etc/nix-darwin
sudo ln -s ${SCRIPT_PATH}/nix-darwin /etc/nix-darwin
rm -f ~/.config/home-manager
ln -s ${SCRIPT_PATH}/home-manager ~/.config/home-manager

echo "Installing nix-darwin and home-manager configurations..."
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake "/etc/nix-darwin#${hostname}"

sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.activate-system.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.activate-system.plist

# Disable this line if you didn't install Xcode
sudo xcodebuild -license accept

nix run home-manager/master -- switch --impure

echo "Installation complete! Your MacOS has been configured successfully."
