# Kubuntu Setup Automation Script

This repository contains a Bash script designed to automate the setup of a Kubuntu 24.04 system. The script installs essential packages, configures system settings, and optimizes the environment for a smoother desktop experience.

## Features

- **Remove Snap and Block Future Installations**: Uninstalls Snap and prevents it from being reinstalled.
- **Install Flatpak**: Sets up Flatpak and adds the Flathub repository.
- **Reduce Swappiness**: Optimizes system performance by reducing swappiness.
- **Install Essential Packages**: Installs a wide range of essential applications and tools.
- **Add Repositories**: Adds repositories for additional software like Node.js and Google Chrome.
- **Install Additional Software**: Installs 1Password, Warp Terminal, and other useful applications.
- **Enable Password Feedback**: Shows password feedback in the command line interface.
- **Docker Setup**: Configures Docker and adds the user to the Docker group.

## Contributing
Feel free to open issues or submit pull requests with improvements and new features.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/your-repository.git
   cd your-repository

2. **Run the script**:
   chmod +x kubuntu-setup.sh
   ./kubuntu-setup.sh

3.**Reboot The System**:
   sudo reboot

4.  
