#!/bin/bash

# Setup symlink for Wow Gacha Bot development
# This script creates a symlink from the built addon to your WoW Classic AddOns directory

# Default WoW installation path (adjust if different)
WOW_PATH="/c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns/WowGachaBot"

# Check if WoW path exists
if [ ! -d "/c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns" ]; then
    echo "❌ WoW Classic AddOns directory not found at:"
    echo "   /c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns"
    echo ""
    echo "Please update the WOW_PATH variable in this script with your WoW installation path."
    exit 1
fi

# Get current directory
CURRENT_DIR=$(pwd)
SOURCE_PATH="$CURRENT_DIR/.release/WowGachaBot"

# Check if source directory exists
if [ ! -d "$SOURCE_PATH" ]; then
    echo "❌ Built addon not found at: $SOURCE_PATH"
    echo "Please run the build first:"
    echo "   .release/release.sh -d -z -o"
    exit 1
fi

# Remove existing symlink if it exists
if [ -L "$WOW_PATH" ]; then
    echo "🔄 Removing existing symlink..."
    rm "$WOW_PATH"
elif [ -d "$WOW_PATH" ]; then
    echo "❌ Directory already exists at: $WOW_PATH"
    echo "Please remove it manually or choose a different name."
    exit 1
fi

# Create symlink
echo "🔗 Creating symlink..."
ln -s "$SOURCE_PATH" "$WOW_PATH"

if [ $? -eq 0 ]; then
    echo "✅ Symlink created successfully!"
    echo "   Source: $SOURCE_PATH"
    echo "   Target: $WOW_PATH"
    echo ""
    echo "Now you can:"
    echo "1. Start WoW Classic"
    echo "2. Test the addon with /wgb help"
    echo "3. Make changes and rebuild with: .release/release.sh -d -z -o"
    echo "4. Reload in-game with /reload"
else
    echo "❌ Failed to create symlink. You may need to run as Administrator."
    exit 1
fi
