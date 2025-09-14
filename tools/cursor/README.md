# VS Code Insiders to Cursor Import Tools (Python)

Cross-platform Python scripts to import all settings, keybindings, snippets, and extensions from VS Code Insiders to Cursor IDE on Windows and macOS.

## Features

- ✅ **Cross-platform**: Works on Windows, macOS, and Linux
- ✅ **Comprehensive**: Imports all settings, keybindings, snippets, themes, and extension lists
- ✅ **Safe**: Automatic backup creation before importing
- ✅ **Interactive**: What-if mode for testing, interactive backup selection
- ✅ **Robust**: Comprehensive error handling and validation
- ✅ **No Dependencies**: Uses only Python standard library

## Scripts Overview

### 1. `import_vscode_insiders_to_cursor.py`
The main import script that transfers all settings from VS Code Insiders to Cursor.

### 2. `import_vscode_insiders_to_cursor_with_extensions.py` ⭐ **NEW**
Enhanced import script that can also install extensions automatically in Cursor.

### 3. `install_extensions_from_list.py` ⭐ **NEW**
Standalone script to install extensions from a list file.

### 4. `backup_cursor_settings.py`
Creates backups of your current Cursor settings with timestamp.

### 5. `restore_cursor_settings.py`
Restores Cursor settings from a previous backup.

## Quick Start

### Prerequisites
- Python 3.7 or higher
- VS Code Insiders installed and used at least once
- Cursor IDE installed

### Basic Usage

1. **Test what would be imported (recommended first):**
   ```bash
   python import_vscode_insiders_to_cursor.py --what-if
   ```

2. **Import with automatic backup:**
   ```bash
   python import_vscode_insiders_to_cursor.py
   ```

3. **Restart Cursor** to apply the new settings.

### Extension Installation (NEW!)

**Option 1: Import with automatic extension installation:**
```bash
python import_vscode_insiders_to_cursor_with_extensions.py --install-extensions
```

**Option 2: Install extensions from the generated list:**
```bash
# First, run the regular import to generate the extension list
python import_vscode_insiders_to_cursor.py

# Then install extensions from the list
python install_extensions_from_list.py imported-extensions-list.txt
```

## Detailed Usage

### Import Script

```bash
python import_vscode_insiders_to_cursor.py [OPTIONS]
```

**Options:**
- `--backup` (default) - Create backup before importing
- `--no-backup` - Skip backup creation
- `--what-if` - Show what would be done without making changes
- `--force` - Skip confirmation prompts

**Examples:**
```bash
# Basic import with backup
python import_vscode_insiders_to_cursor.py

# Import without backup
python import_vscode_insiders_to_cursor.py --no-backup

# Test what would be imported
python import_vscode_insiders_to_cursor.py --what-if

# Force import without prompts
python import_vscode_insiders_to_cursor.py --force
```

### Enhanced Import Script (with Extensions)

```bash
python import_vscode_insiders_to_cursor_with_extensions.py [OPTIONS]
```

**Options:**
- `--backup` (default) - Create backup before importing
- `--no-backup` - Skip backup creation
- `--what-if` - Show what would be done without making changes
- `--force` - Skip confirmation prompts
- `--install-extensions` - Install extensions automatically in Cursor

**Examples:**
```bash
# Import everything including extensions
python import_vscode_insiders_to_cursor_with_extensions.py --install-extensions

# Test what would be imported and installed
python import_vscode_insiders_to_cursor_with_extensions.py --install-extensions --what-if

# Import settings only (no extension installation)
python import_vscode_insiders_to_cursor_with_extensions.py
```

### Extension Installation Script

```bash
python install_extensions_from_list.py <extension_list_file> [OPTIONS]
```

**Options:**
- `--cursor-command` - Specify Cursor command (default: cursor)
- `--what-if` - Show what would be installed without actually installing

**Examples:**
```bash
# Install extensions from the generated list
python install_extensions_from_list.py imported-extensions-list.txt

# Test what would be installed
python install_extensions_from_list.py imported-extensions-list.txt --what-if

# Use different Cursor command
python install_extensions_from_list.py imported-extensions-list.txt --cursor-command "cursor.exe"
```

### Backup Script

```bash
python backup_cursor_settings.py [OPTIONS]
```

**Options:**
- `--backup-path PATH` - Specify custom backup location
- `--what-if` - Show what would be backed up
- `--list` - List existing backups

**Examples:**
```bash
# Create backup with timestamp
python backup_cursor_settings.py

# Create backup to specific location
python backup_cursor_settings.py --backup-path /path/to/backup

# List existing backups
python backup_cursor_settings.py --list

# Test backup process
python backup_cursor_settings.py --what-if
```

### Restore Script

```bash
python restore_cursor_settings.py [OPTIONS]
```

**Options:**
- `--backup-path PATH` - Path to backup to restore (interactive if not provided)
- `--what-if` - Show what would be restored
- `--force` - Skip confirmation prompts
- `--list` - List available backups

**Examples:**
```bash
# Interactive backup selection
python restore_cursor_settings.py

# Restore from specific backup
python restore_cursor_settings.py --backup-path /path/to/backup

# List available backups
python restore_cursor_settings.py --list

# Test restore process
python restore_cursor_settings.py --backup-path /path/to/backup --what-if
```

## Platform-Specific Paths

### Windows
- **VS Code Insiders**: `%APPDATA%\Code - Insiders\User\`
- **Cursor**: `%APPDATA%\Cursor\User\`
- **Backups**: `%APPDATA%\Cursor\User.backup.TIMESTAMP\`

### macOS
- **VS Code Insiders**: `~/Library/Application Support/Code - Insiders/User/`
- **Cursor**: `~/Library/Application Support/Cursor/User/`
- **Backups**: `~/Library/Application Support/Cursor/User.backup.TIMESTAMP/`

### Linux
- **VS Code Insiders**: `~/.config/Code - Insiders/User/`
- **Cursor**: `~/.config/Cursor/User/`
- **Backups**: `~/.config/Cursor/User.backup.TIMESTAMP/`

## What Gets Imported

The import script transfers the following from VS Code Insiders to Cursor:

### Configuration Files
- `settings.json` - All your VS Code settings
- `keybindings.json` - Custom keyboard shortcuts
- `locale.json` - Language/locale preferences

### Directories
- `snippets/` - User-defined code snippets
- `History/` - Command and file history
- `CachedExtensions/` - Extension cache data
- `workspaceStorage/` - Workspace-specific settings
- `globalStorage/` - Global application state

### Theme Files
- `colorTheme.json` - Color theme settings
- `iconTheme.json` - Icon theme settings
- `productIconTheme.json` - Product icon theme settings

### Extension Information
- Creates a list of installed extensions for reference
- Saves extension list to `imported-extensions-list.txt`

## Advanced Usage

### Making Scripts Executable (Unix/macOS)

```bash
chmod +x import_vscode_insiders_to_cursor.py
chmod +x backup_cursor_settings.py
chmod +x restore_cursor_settings.py

# Then run directly
./import_vscode_insiders_to_cursor.py --what-if
```

### Creating Aliases

Add to your shell profile (`.bashrc`, `.zshrc`, etc.):

```bash
# VS Code to Cursor import aliases
alias vscode-to-cursor="python /path/to/scripts/py/import_vscode_insiders_to_cursor.py"
alias cursor-backup="python /path/to/scripts/py/backup_cursor_settings.py"
alias cursor-restore="python /path/to/scripts/py/restore_cursor_settings.py"
```

### Integration with Your Workflow

```bash
# Quick import workflow
python backup_cursor_settings.py --list
python import_vscode_insiders_to_cursor.py --what-if
python import_vscode_insiders_to_cursor.py
```

## Troubleshooting

### Common Issues

1. **"VS Code Insiders settings not found"**
   - Ensure VS Code Insiders is installed and has been used at least once
   - Check that the platform-specific path exists

2. **Permission errors**
   - On Unix systems, ensure you have write permissions to the Cursor directory
   - On Windows, run as Administrator if needed

3. **Extensions not working after import**
   - Some extensions may not be compatible with Cursor
   - Check the `imported-extensions-list.txt` file for your extension list
   - Reinstall extensions manually from Cursor's extension marketplace

4. **Settings not applying**
   - Restart Cursor completely after import
   - Check Cursor's settings to verify the import worked

### Recovery

If something goes wrong:

1. **Restore from backup:**
   ```bash
   python restore_cursor_settings.py --list
   python restore_cursor_settings.py --backup-path /path/to/backup
   ```

2. **Reset Cursor settings:**
   - Close Cursor
   - Delete the Cursor User directory (see platform paths above)
   - Restart Cursor (it will create default settings)

## Best Practices

1. **Always test first** - Use `--what-if` to preview changes
2. **Create backups** - The import script creates backups automatically
3. **Close applications** - Close both VS Code Insiders and Cursor during import
4. **Verify after import** - Check that settings and extensions work correctly
5. **Keep backups** - Don't delete backup files immediately

## Script Features

- ✅ **Cross-platform compatibility** (Windows, macOS, Linux)
- ✅ **Automatic backup creation**
- ✅ **Comprehensive settings transfer**
- ✅ **Extension list generation**
- ✅ **What-if mode for testing**
- ✅ **Interactive backup selection**
- ✅ **Error handling and validation**
- ✅ **Progress reporting with emojis**
- ✅ **Size verification**
- ✅ **Recovery options**
- ✅ **No external dependencies**

## Alternative Methods

### Method 1: VS Code Settings Sync
1. Enable Settings Sync in VS Code Insiders
2. Install regular VS Code and sync settings
3. Use Cursor's built-in VS Code import feature

### Method 2: Manual File Copying
1. Copy files manually from VS Code Insiders directory to Cursor directory
2. Focus on `settings.json`, `keybindings.json`, and `snippets/` folder

### Method 3: Folder Renaming Trick
1. Temporarily rename VS Code Insiders directory to match regular VS Code
2. Use Cursor's import feature
3. Rename the folder back

## Support

If you encounter issues:

1. Check the troubleshooting section above
2. Verify file paths and permissions
3. Use the `--what-if` parameter to test without making changes
4. Restore from backup if needed
5. Check that Python 3.7+ is installed

## Requirements

- **Python**: 3.7 or higher
- **Operating System**: Windows, macOS, or Linux
- **Applications**: VS Code Insiders and Cursor IDE installed
- **Dependencies**: None (uses only Python standard library)
