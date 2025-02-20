#!/usr/bin/env bash
# This script sets up a Python virtual environment and installs the necessary dependencies.

# -e => Exit immediately if a command exits with a non-zero status, 
# -u => treat unset variables as an error, 
# -o => prevent errors in a pipeline from being masked.
set -euo pipefail

echo "Creating a virtual environment in the .venv directory..."
if [ ! -d .venv ]; then
    
    echo "Activating the virtual environment..."
    python3 -m venv .venv
    
    echo "Upgrading pip to the latest version..."
    source .venv/bin/activate
    
    echo "Installing the package in editable mode with development dependencies..."
    pip install --upgrade pip
    echo "Installing [dev] packages..."
    pip install -e .[dev]
    
    echo ".venv created"
    echo "Listing installed packages in the virtual environment..."
    pip list
fi
