#!/bin/bash

# Set the installation directory
INSTALL_DIR="/usr/share/smlnj"
VERSION="110.79"  # Replace with the desired version

# Install 32-bit compatibility libraries (required for SML/NJ on 64-bit systems)
echo "Installing 32-bit compatibility libraries..."
sudo dnf install -y glibc-devel.i686

# Create the installation directory
echo "Creating installation directory at $INSTALL_DIR..."
sudo mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Download the config.tgz file
echo "Downloading config.tgz for version $VERSION..."
sudo wget http://smlnj.cs.uchicago.edu/dist/working/$VERSION/config.tgz

# Extract the config.tgz file
echo "Extracting config.tgz..."
sudo gunzip <config.tgz | tar xf -

# Edit the config/targets file to include all packages (full installation)
# This step can be skipped if you want a minimal installation
echo "Configuring targets for a full installation..."
sudo sed -i 's/^\(.*\)$/#\1/' config/targets  # Comment out all lines
sudo echo "src-smlnj" | sudo tee -a config/targets
sudo echo "old-basis" | sudo tee -a config/targets
sudo echo "ml-yacc" | sudo tee -a config/targets
sudo echo "ml-lex" | sudo tee -a config/targets
sudo echo "ml-burg" | sudo tee -a config/targets
sudo echo "smlnj-lib" | sudo tee -a config/targets
sudo echo "pgraph-util" | sudo tee -a config/targets
sudo echo "cml" | sudo tee -a config/targets
sudo echo "cml-lib" | sudo tee -a config/targets
sudo echo "eXene" | sudo tee -a config/targets
sudo echo "ckit" | sudo tee -a config/targets
sudo echo "ml-nlffi-lib" | sudo tee -a config/targets
sudo echo "ml-nlffigen" | sudo tee -a config/targets
sudo echo "mlrisc-tools" | sudo tee -a config/targets
sudo echo "nowhere" | sudo tee -a config/targets
sudo echo "doc" | sudo tee -a config/targets

# Run the installer
echo "Running the SML/NJ installer..."
sudo config/install.sh

# Add SML/NJ to the PATH
echo "Adding SML/NJ to the system PATH..."
echo "export PATH=\$PATH:$INSTALL_DIR/bin" | sudo tee /etc/profile.d/smlnj.sh
source /etc/profile.d/smlnj.sh

# Verify installation
echo "SML/NJ installation complete. Running 'sml' to verify..."
sml

# run instructions chmod +x install_smlnj.sh   sudo ./install_smlnj.sh
