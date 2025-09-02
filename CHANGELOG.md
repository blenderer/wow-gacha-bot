# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial release
- Basic addon structure with TOC files for Era and Anniversary realms
- Party chat command detection for `!open`
- "Hello World!" response functionality
- Slash command interface (`/wgb`, `/wowgachabot`)
- Debug mode and configuration options
- GitHub Actions workflows for building and releasing
- Support for multiple WoW Classic versions:
  - Classic Era (Interface 11502)
  - Burning Crusade Classic (Interface 20504)
  - Wrath of the Lich King Classic (Interface 30403)

### Technical Details

- Uses WoW Packager for automated building and publishing
- Configured with `.pkgmeta` for proper packaging
- Includes proper addon metadata and versioning
- Compatible with CurseForge, WoWInterface, and Wago publishing

## [1.0.0] - 2025-01-27

### Added

- Initial release of Wow Gacha Bot
- Basic functionality to respond to `!open` command in party chat
- Support for both Era and Anniversary realms
- Slash command interface for addon management
- Debug mode for troubleshooting
- Automated build and release pipeline
