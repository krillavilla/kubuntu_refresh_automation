#!/bin/bash

# Update package list and upgrade all packages
echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

# Remove Snap and block it
echo "Removing Snap and blocking its installation..."
sudo apt purge -y snapd
sudo rm -rf /var/cache/snapd/
sudo rm -rf ~/snap
echo "snapd" | sudo tee -a /etc/apt/preferences.d/nosnap.pref
echo -e 'Package: snapd\nPin: release a=*\nPin-Priority: -10' | sudo tee /etc/apt/preferences.d/nosnap.pref

# Install Flatpak
echo "Installing Flatpak..."
sudo apt install -y flatpak
sudo apt install -y plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Reduce swappiness for desktop installation
echo "Reducing swappiness for desktop installation..."
echo -e "# Reduce swappiness for desktop installation (default = 60)\nvm.swappiness=10" | sudo tee /etc/sysctl.d/99-sysswappiness.conf

# Install essential packages
echo "Installing essential packages..."
ESSENTIAL_PACKAGES=(
    git
    vim
    code
    nodejs
    npm
    python3
    python3-pip
    openjdk-11-jdk
    htop
    ksysguard
    rsync
    timeshift
    firefox
    slack-desktop
    discord
    zoom
    vlc
    gimp
    audacity
    libreoffice
    virtualbox
    docker.io
    docker-compose
    openvpn
    nmap
    wireshark
    curl
    wget
    software-properties-common
    build-essential
    gedit
    mousepad
    bleachbit
    stacer
)

for package in "${ESSENTIAL_PACKAGES[@]}"; do
    sudo apt install -y $package
done

# Add repositories (example: adding a repository for Node.js)
echo "Adding repositories..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Install additional software
echo "Installing additional software..."
sudo apt update
sudo apt install -y nodejs google-chrome-stable

# Install 1Password
echo "Installing 1Password..."
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor -o /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/1password.list
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor -o /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo apt update && sudo apt install -y 1password

# Install Warp Terminal
echo "Installing Warp Terminal..."
curl -s https://apt.fury.io/warpdotdev/key.gpg | sudo apt-key add -
echo "deb [arch=amd64] https://apt.fury.io/warpdotdev/ /" | sudo tee /etc/apt/sources.list.d/warp.list
sudo apt update && sudo apt install -y warp

# Install multimedia codecs, Microsoft fonts, and exFAT utilities
echo "Installing multimedia codecs, Microsoft fonts, and exFAT utilities..."
sudo apt update
sudo apt install -y kubuntu-restricted-extras gstreamer1.0-vaapi libvdpau-va-gl1 rar fonts-crosextra-carlito fonts-crosextra-caladea exfatprogs

# Enable password feedback in the command line interface
echo "Enabling password feedback for the command line interface..."
echo -e "# Enable password feedback\nDefaults pwfeedback" | sudo tee /etc/sudoers.d/pwfeedback
sudo chmod 0440 /etc/sudoers.d/pwfeedback

# Docker post-installation steps
echo "Setting up Docker..."
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Copy configuration files (example: .bashrc, .vimrc)
echo "Copying configuration files..."
cp /path/to/your/dotfiles/.bashrc ~/
cp /path/to/your/dotfiles/.vimrc ~/

# Apply user-specific settings
echo "Setting up user-specific settings..."
# Example: Setting up Git
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Cleanup
echo "Cleaning up..."
sudo apt autoremove -y

echo "Setup complete! Please reboot your system."
