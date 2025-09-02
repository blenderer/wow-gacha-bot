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

### 3. Local Testing

1. Copy the addon files to your WoW Classic AddOns directory:

   ```
   World of Warcraft/_classic_/Interface/AddOns/WowGachaBot/
   ```

2. Start the game and test the addon:
   - Type `/wgb help` to see available commands
   - Type `/wgb test` to test the !open functionality
   - Join a party and type `!open` to test the party chat detection

### 4. Building Locally

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

- `./release.sh` - Build and upload to all configured sites
- `./release.sh -d` - Build only (skip uploading)
- `./release.sh -z` - Build and create zip file only
- `./release.sh -d -z` - Build and create zip file, skip uploading
- `./release.sh -p 1234` - Upload to CurseForge with project ID 1234
- `./release.sh -w 5678` - Upload to WoWInterface with addon ID 5678
- `./release.sh -a he54k6bL` - Upload to Wago with project ID he54k6bL

The built addon will be available as a zip file in the `.release` directory.

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
