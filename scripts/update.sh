#!/bin/sh

# ASCII ART
echo ""
echo "███████╗██╗██╗  ██╗██╗  ██╗ ██████╗ ███████╗    ██╗   ██╗███████╗"
echo "██╔════╝██║██║ ██╔╝██║ ██╔╝██╔═══██╗██╔════╝    ██║   ██║██╔════╝"
echo "███████╗██║█████╔╝ █████╔╝ ██║   ██║███████╗    ██║   ██║███████╗"
echo "╚════██║██║██╔═██╗ ██╔═██╗ ██║   ██║╚════██║    ██║   ██║╚════██║"
echo "███████║██║██║  ██╗██║  ██╗╚██████╔╝███████║    ╚██████╔╝███████║"
echo "╚══════╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝     ╚═════╝ ╚══════╝"
echo ""

# Read sudo password
printf "Enter your sudo password: "
read -r -s SUDO_PASSWORD

# Check for updates
UPDATES=$(echo "$SUDO_PASSWORD" | sudo -s dnf check-update)

# If updates available, install them
if [ -n "$UPDATES" ]; then
  echo "Updates are available. Installing..."
  echo "$SUDO_PASSWORD" | sudo -s dnf upgrade -y
else
  echo "No updates available"
fi

# Clean caches
echo "$SUDO_PASSWORD" | sudo dnf clean all

# Clear sudo password from memory
SUDO_PASSWORD=""
