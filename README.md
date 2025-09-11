# Wow Gacha Bot

A simple World of Warcraft Classic addon that responds to party chat commands.

## Features

- Responds to `!open` command in party chat with "Hello World!" message
- Supports both Era and Anniversary realms
- Configurable via slash commands
- Debug mode for troubleshooting

## Installation

1. Download the latest release from the [Releases](https://github.com/yourusername/wow-gacha-bot/releases) page
2. Extract the zip file to your World of Warcraft Classic `Interface/AddOns/` directory
3. Restart the game or reload your UI (`/reload`)

## Usage

### In-Game Commands

- Type `!open` in party chat to trigger the "Hello World!" message
- Use `/wgb` or `/wowgachabot` for addon management:
  - `/wgb toggle` - Enable/disable the addon
  - `/wgb debug` - Toggle debug mode
  - `/wgb test` - Test the !open command
  - `/wgb help` - Show help

### Supported Game Versions

- **Classic Era & Anniversary**: Interface 11507
- **Burning Crusade Classic**: Interface 20504
- **Wrath of the Lich King Classic**: Interface 30403

## Development

### Prerequisites

- Git
- A text editor or IDE
- World of Warcraft Classic for testing

### Building

This project uses the [WoW Packager](https://github.com/marketplace/actions/wow-packager) GitHub Action for automated building and publishing.

#### Local Development

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/wow-gacha-bot.git
   cd wow-gacha-bot
   ```

2. **Important**: Make sure you have at least one Git commit before building:

   ```bash
   git add .
   git commit -m "Initial commit"
   ```

3. Copy the addon files to your WoW Classic AddOns directory for testing

4. Make your changes and test in-game

#### Automated Building

The project includes GitHub Actions workflows:

- **Build**: Runs on every push and PR, creates build artifacts
- **Release**: Runs on version tags, builds and publishes to addon sites

### Project Structure

```
wow-gacha-bot/
├── .github/
│   └── workflows/
│       ├── build.yml      # Build workflow
│       └── release.yml    # Release workflow
├── .pkgmeta              # Package configuration
├── WowGachaBot.toc       # Addon table of contents
├── WowGachaBot.lua       # Main addon code
├── WowGachaBot.xml       # UI definitions
├── CHANGELOG.md          # Version history
├── LICENSE               # License file
└── README.md             # This file
```

### Testing

To test the weapon database functionality locally:

```bash
lua test_random_weapons.lua
```

This will display 10 random weapons from the WeaponsDB with their properties including name, type, quality, level, TBC status, and damage values. The test script loads the WeaponsDB.lua file and uses the `GetRandomWeapon()` method to fetch random weapons.

### Configuration

The addon can be configured through the `.pkgmeta` file:

- `enable-toc-creation: yes` - Creates separate TOC files for different game versions
- `package-as: WowGachaBot` - Sets the package name
- `manual-changelog: CHANGELOG.md` - Uses the changelog file for releases

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built using the [WoW Packager](https://github.com/marketplace/actions/wow-packager) by BigWigsMods
- Compatible with World of Warcraft Classic Era and Anniversary realms
