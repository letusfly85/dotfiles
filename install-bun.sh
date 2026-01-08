#!/usr/bin/env bash

# Install bun (JavaScript runtime & toolkit)
# https://bun.sh/

set -e

echo "Installing bun..."

# Check if bun is already installed
if command -v bun &> /dev/null; then
    echo "bun is already installed: $(bun --version)"
    echo "Upgrading to latest version..."
    bun upgrade
else
    # Install bun using official installer
    curl -fsSL https://bun.sh/install | bash
fi

echo "bun installation completed!"
echo "Please restart your shell or run: source ~/.zshrc"
