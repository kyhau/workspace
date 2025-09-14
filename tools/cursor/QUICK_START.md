# Windsurf - VS Code Insiders to Cursor Import Tools

Quick start guide for importing VS Code Insiders settings to Cursor IDE.

## 🚀 Quick Start

### 1. Test First (Recommended)
```bash
python import_vscode_insiders_to_cursor.py --what-if
```

### 2. Import Settings
```bash
python import_vscode_insiders_to_cursor.py
```

### 3. Restart Cursor
Close and reopen Cursor to apply the new settings.

## 📋 Available Scripts

- `import_vscode_insiders_to_cursor.py` - Main import script
- `backup_cursor_settings.py` - Create backups
- `restore_cursor_settings.py` - Restore from backup

## 🛡️ Safety Features

- ✅ Automatic backup before importing
- ✅ What-if mode for testing
- ✅ Cross-platform (Windows, macOS, Linux)
- ✅ No external dependencies

## 📖 Full Documentation

See `README.md` for complete usage instructions and troubleshooting.

## 💡 Pro Tips

1. Always test with `--what-if` first
2. Close both VS Code Insiders and Cursor during import
3. Check extensions after import - some may need reinstallation
4. Keep backups until you're satisfied with the import
