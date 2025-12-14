# Hide Player Frame

A simple World of Warcraft addon that automatically hides your player frame, showing it only during combat or when you have a target selected.

## Features

- **Auto-hide player frame** when not in combat and without a target
- **Toggle on/off** with a simple slash command
- **Persistent settings** - your preference is saved across sessions
- **Lightweight** - minimal performance impact

## Installation

### Manual Installation

1. Download the latest release
2. Extract the `hide-player-frame` folder to your WoW AddOns directory:
   - **Windows**: `C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\`
   - **Mac**: `/Applications/World of Warcraft/_retail_/Interface/AddOns/`
   - **Linux**: `~/.steam/steam/steamapps/compatdata/[ID]/pfx/drive_c/Program Files (x86)/World of Warcraft/_retail_/Interface/AddOns/`
3. Restart WoW or type `/reload`

## Usage

Type `/hpf` in chat to toggle the auto-hide feature:

- **Enabled**: Player frame is hidden by default, shows only in combat or when targeting
- **Disabled**: Player frame is always visible (default WoW behavior)

## How It Works

When auto-hide is enabled:
- ✅ Player frame **shows** when you enter combat
- ✅ Player frame **shows** when you target something
- ❌ Player frame **hides** when you leave combat and clear your target

## Requirements

- World of Warcraft Retail (tested on 11.0.2.07)
- No dependencies

## Author

**Kullah**

## License

This project is open source and available for anyone to use and modify.

## Support

Found a bug or have a feature request? [Open an issue](https://github.com/rvhonorato/hide-player-frame/issues) on GitHub!
