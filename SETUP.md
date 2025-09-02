# Setup Guide

## Local Development Setup

### 1. Environment Variables

For local development and testing with the WoW Packager, create a `.env` file in the `.release` directory with the following variables:

```bash
# CurseForge API Key (for uploading to CurseForge)
CF_API_KEY=your_curseforge_api_key_here

# WoWInterface API Token (for uploading to WoWInterface)
WOWI_API_TOKEN=your_wowinterface_token_here

# Wago API Token (for uploading to Wago)
WAGO_API_TOKEN=your_wago_token_here

# GitHub OAuth Token (for creating releases)
GITHUB_OAUTH=your_github_token_here
```

### 2. GitHub Secrets

For automated releases, add these secrets to your GitHub repository:

1. Go to your repository settings
2. Navigate to "Secrets and variables" > "Actions"
3. Add the following repository secrets:

- `CF_API_KEY` - Your CurseForge API key
- `WOWI_API_TOKEN` - Your WoWInterface API token
- `WAGO_API_TOKEN` - Your Wago API token
- `CURSEFORGE_PROJECT_ID` - Your CurseForge project ID (if uploading to CurseForge)
- `WOWINTERFACE_ADDON_ID` - Your WoWInterface addon ID (if uploading to WoWInterface)
- `WAGO_PROJECT_ID` - Your Wago project ID (if uploading to Wago)

### 3. Initial Git Setup

**Important**: The WoW Packager requires at least one Git commit to work properly. If you're starting fresh:

```bash
git add .
git commit -m "Initial commit: Wow Gacha Bot addon"
```

### 4. Local Testing

#### Option A: Symlink (Recommended for Development)

**Quick setup** using the provided script:

```bash
./setup-symlink.sh
```

**Manual setup**:

```bash
# Windows (Git Bash)
ln -s "$(pwd)/.release/WowGachaBot" "/c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns/WowGachaBot"

# Or if your WoW is in a different location:
ln -s "$(pwd)/.release/WowGachaBot" "/path/to/your/WoW/_classic_/Interface/AddOns/WowGachaBot"
```

**Benefits**:

- Automatically reflects changes when you rebuild
- No need to manually copy files
- Tests the exact same files that will be distributed

#### Option B: Manual Copy

1. Copy the addon files to your WoW Classic AddOns directory:

   ```
   World of Warcraft/_classic_/Interface/AddOns/WowGachaBot/
   ```

2. Start the game and test the addon:
   - Type `/wgb help` to see available commands
   - Type `/wgb test` to test the !open functionality
   - Join a party and type `!open` to test the party chat detection

### 5. Building Locally

To build the addon locally using the WoW Packager:

1. The `release.sh` script is already downloaded in the `.release` directory
2. (Optional) Create a `.env` file in the `.release` directory with your API keys:
   ```bash
   # Copy the example and fill in your values
   cp .release/.env.example .release/.env
   # Edit .release/.env with your actual API keys
   ```
3. Run the script:
   ```bash
   cd .release
   ./release.sh
   ```

#### Available Options

The `release.sh` script supports several options:

- `./release.sh -d -z` - **Build only** (recommended for testing)
- `./release.sh -d` - Build and create zip file (requires zip command)
- `./release.sh` - Build and upload to all configured sites (requires API keys)
- `./release.sh -p 1234` - Upload to CurseForge with project ID 1234
- `./release.sh -w 5678` - Upload to WoWInterface with addon ID 5678
- `./release.sh -a he54k6bL` - Upload to Wago with project ID he54k6bL

**Note**: The script creates separate TOC files for each game version:

- `WowGachaBot_Vanilla.toc` (Classic Era)
- `WowGachaBot_TBC.toc` (Burning Crusade Classic)
- `WowGachaBot_Wrath.toc` (Wrath of the Lich King Classic)

The built addon will be available in the `.release/WowGachaBot/` directory.

## Development Workflow

### Quick Development Cycle

1. **Set up symlink once** (if using Option A above):

   ```bash
   ln -s "$(pwd)/.release/WowGachaBot" "/c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns/WowGachaBot"
   ```

2. **Make changes** to your addon files (`.lua`, `.toc`, `.xml`)

3. **Rebuild** the addon:

   ```bash
   .release/release.sh -d -z -o
   ```

4. **Reload in-game**:

   ```
   /reload
   ```

5. **Test** your changes

The symlink automatically points to the latest built version, so you don't need to copy files manually!

### Testing Different Game Versions

The script creates separate TOC files for each game version. To test a specific version:

1. **Classic Era**: Use `WowGachaBot_Vanilla.toc`
2. **Burning Crusade Classic**: Use `WowGachaBot_TBC.toc`
3. **Wrath of the Lich King Classic**: Use `WowGachaBot_Wrath.toc`

You can temporarily rename the TOC file in the symlinked directory to test different versions.

## Publishing

### Automatic Publishing

The GitHub Actions workflow will automatically:

1. Build the addon when you push to main/develop branches
2. Create releases when you push version tags (e.g., `v1.0.0`)
3. Upload to configured addon sites (CurseForge, WoWInterface, Wago)

### Manual Publishing

1. Create a version tag:

   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. The release workflow will automatically trigger and publish the addon

### Updating Project IDs

To configure upload destinations, update the TOC file with the appropriate IDs:

```lua
## X-Curse-Project-ID: 1234
## X-WoWI-ID: 5678
## X-Wago-ID: he54k6bL
```

Or use the `.pkgmeta` file to override these values.

## Troubleshooting

### "release.sh is ignoring addon files"

**Problem**: The script shows "Ignoring: WowGachaBot.lua, WowGachaBot.toc, WowGachaBot.xml"

**Solution**: Make sure you have at least one Git commit:

```bash
git add .
git commit -m "Initial commit"
```

The WoW Packager requires Git history to identify which files are part of the addon.

### "zip: command not found"

**Problem**: Getting "zip: command not found" error when creating zip files

**Solution**: This is normal on Windows Git Bash. Use the `-z` flag to skip zip creation:

```bash
./release.sh -d -z  # Build only, no zip
```

The addon files will still be built in the `.release/WowGachaBot/` directory.

### "malformed object name 'HEAD'"

**Problem**: Getting Git errors about malformed object names

**Solution**: Make sure you have at least one commit in your repository:

```bash
git add .
git commit -m "Initial commit"
```

### Symlink Issues

**Problem**: "ln: failed to create symbolic link: File exists"

**Solution**: Remove the existing symlink first:

```bash
rm "/c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns/WowGachaBot"
ln -s "$(pwd)/.release/WowGachaBot" "/c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns/WowGachaBot"
```

**Problem**: "ln: failed to create symbolic link: Permission denied"

**Solution**: Run Git Bash as Administrator, or use a different WoW installation path that you have write access to.

**Problem**: Addon not loading in-game

**Solution**: Make sure the symlink path is correct and the addon files exist:

```bash
ls -la "/c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns/WowGachaBot"
```
