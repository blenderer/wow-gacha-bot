#!/bin/bash

# Build and Link script for Wow Gacha Bot
# This script builds the addon and updates the symlink automatically

# Default WoW installation path (adjust if different)
WOW_PATH="/c/Program Files (x86)/World of Warcraft/_classic_era_/Interface/AddOns/WowGachaBot"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔨 Building Wow Gacha Bot...${NC}"

# Build the addon
.release/release.sh -d -z -o

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed!${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Build completed successfully!${NC}"

# Check if WoW AddOns directory exists
if [ ! -d "/c/Program Files (x86)/World of Warcraft/_classic_era_/Interface/AddOns" ]; then
    echo -e "${YELLOW}⚠️  WoW Classic Era AddOns directory not found at:${NC}"
    echo "   /c/Program Files (x86)/World of Warcraft/_classic_era_/Interface/AddOns"
    echo -e "${YELLOW}   Skipping symlink update.${NC}"
    exit 0
fi

# Get current directory
CURRENT_DIR=$(pwd)
SOURCE_PATH="$CURRENT_DIR/.release/WowGachaBot"

# Check if source directory exists
if [ ! -d "$SOURCE_PATH" ]; then
    echo -e "${RED}❌ Built addon not found at: $SOURCE_PATH${NC}"
    exit 1
fi

echo -e "${BLUE}🔗 Updating symlink...${NC}"

# Remove existing symlink or directory if it exists
if [ -L "$WOW_PATH" ]; then
    echo -e "${YELLOW}🔄 Removing existing symlink...${NC}"
    rm "$WOW_PATH"
elif [ -d "$WOW_PATH" ]; then
    echo -e "${YELLOW}🔄 Removing existing directory...${NC}"
    rm -rf "$WOW_PATH"
fi

# Create symlink
ln -s "$SOURCE_PATH" "$WOW_PATH"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Symlink updated successfully!${NC}"
    echo -e "${BLUE}📁 Source: $SOURCE_PATH${NC}"
    echo -e "${BLUE}📁 Target: $WOW_PATH${NC}"
    echo ""
    echo -e "${GREEN}🎮 Ready to test in WoW Classic!${NC}"
    echo -e "${YELLOW}   Use /reload in-game to refresh the addon${NC}"
else
    echo -e "${RED}❌ Failed to create symlink. You may need to run as Administrator.${NC}"
    exit 1
fi
