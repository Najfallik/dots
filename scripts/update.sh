#!/bin/bash

## Start echo
echo "Starting sikko's Fedora update script..."

## Check for updates
echo "Checking for updates..."
UPDATES=$(sudo dnf check-update 2>&1)

## If updates available, install them
if [[ $UPDATES != "" ]]; then
  echo "Updates are available. Installing..."
  sudo dnf upgrade -y
else
  echo "No updates available"
fi

## Clean caches
echo "Cleaning up..."
sudo dnf clean all
