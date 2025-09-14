#!/usr/bin/env python3
"""
Import VS Code Insiders Settings to Cursor
Cross-platform Python script to import all settings, keybindings, snippets, and extensions
from VS Code Insiders to Cursor IDE on Windows and macOS.
"""

import os
import sys
import shutil
import json
import argparse
import platform
from pathlib import Path
from datetime import datetime
from typing import Optional, List, Dict, Any


class VSCodeToCursorImporter:
    """Cross-platform importer for VS Code Insiders settings to Cursor."""

    def __init__(self, what_if: bool = False, backup: bool = True):
        self.what_if = what_if
        self.backup = backup
        self.system = platform.system().lower()
        self.paths = self._get_platform_paths()

    def _get_platform_paths(self) -> Dict[str, Path]:
        """Get platform-specific paths for VS Code Insiders and Cursor."""
        if self.system == "windows":
            appdata = Path(os.environ.get('APPDATA', ''))
            return {
                'vscode_insiders': appdata / "Code - Insiders" / "User",
                'cursor': appdata / "Cursor" / "User",
                'backup_base': appdata / "Cursor"
            }
        elif self.system == "darwin":  # macOS
            home = Path.home()
            return {
                'vscode_insiders': home / "Library" / "Application Support" / "Code - Insiders" / "User",
                'cursor': home / "Library" / "Application Support" / "Cursor" / "User",
                'backup_base': home / "Library" / "Application Support" / "Cursor"
            }
        else:
            # Linux
            home = Path.home()
            return {
                'vscode_insiders': home / ".config" / "Code - Insiders" / "User",
                'cursor': home / ".config" / "Cursor" / "User",
                'backup_base': home / ".config" / "Cursor"
            }

    def _print_header(self):
        """Print the script header."""
        print("=" * 50)
        print("VS Code Insiders to Cursor Import Tool")
        print("=" * 50)
        print(f"Platform: {self.system.title()}")
        print(f"Python: {sys.version.split()[0]}")
        print()

    def _print_status(self, message: str, status: str = "info"):
        """Print status messages with appropriate colors/symbols."""
        symbols = {
            "info": "ℹ️ ",
            "success": "✅",
            "warning": "⚠️ ",
            "error": "❌",
            "progress": "🔄"
        }
        print(f"{symbols.get(status, '')} {message}")

    def _get_backup_path(self) -> Path:
        """Generate a timestamped backup path."""
        timestamp = datetime.now().strftime('%Y%m%d-%H%M%S')
        return self.paths['backup_base'] / f"User.backup.{timestamp}"

    def _create_backup(self) -> Optional[Path]:
        """Create a backup of existing Cursor settings."""
        if not self.backup:
            return None

        cursor_path = self.paths['cursor']
        if not cursor_path.exists():
            return None

        backup_path = self._get_backup_path()

        self._print_status("Creating backup of existing Cursor settings...", "progress")

        if self.what_if:
            self._print_status(f"[WHAT-IF] Would backup to: {backup_path}", "info")
            return backup_path

        try:
            shutil.copytree(cursor_path, backup_path)
            self._print_status(f"Backup created at: {backup_path}", "success")
            return backup_path
        except Exception as e:
            self._print_status(f"Backup failed: {e}", "error")
            return None

    def _copy_file(self, source: Path, destination: Path, description: str) -> bool:
        """Copy a single file with error handling."""
        if not source.exists():
            self._print_status(f"{description} not found (skipping)", "warning")
            return False

        if self.what_if:
            self._print_status(f"[WHAT-IF] Would copy {description}", "info")
            self._print_status(f"  From: {source}", "info")
            self._print_status(f"  To: {destination}", "info")
            return True

        try:
            # Ensure destination directory exists
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, destination)
            self._print_status(f"Copied {description}", "success")
            return True
        except Exception as e:
            self._print_status(f"Failed to copy {description}: {e}", "error")
            return False

    def _copy_directory(self, source: Path, destination: Path, description: str) -> bool:
        """Copy a directory with error handling."""
        if not source.exists():
            self._print_status(f"{description} directory not found (skipping)", "warning")
            return False

        if self.what_if:
            self._print_status(f"[WHAT-IF] Would copy {description} directory", "info")
            self._print_status(f"  From: {source}", "info")
            self._print_status(f"  To: {destination}", "info")
            return True

        try:
            # Remove existing destination if it exists
            if destination.exists():
                shutil.rmtree(destination)

            # Ensure parent directory exists
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copytree(source, destination)
            self._print_status(f"Copied {description} directory", "success")
            return True
        except Exception as e:
            self._print_status(f"Failed to copy {description} directory: {e}", "error")
            return False

    def _get_extension_list(self) -> List[str]:
        """Extract extension list from VS Code Insiders."""
        extensions_file = self.paths['vscode_insiders'] / "extensions" / "extensions.json"
        extensions = []

        if not extensions_file.exists():
            self._print_status("Extensions file not found", "warning")
            return extensions

        try:
            with open(extensions_file, 'r', encoding='utf-8') as f:
                data = json.load(f)

            if isinstance(data, list):
                for ext in data:
                    if isinstance(ext, dict):
                        # Try different possible keys for extension ID
                        ext_id = ext.get('identifier', {}).get('id') or ext.get('id') or ext.get('name')
                        if ext_id:
                            extensions.append(ext_id)

            self._print_status(f"Found {len(extensions)} extensions in VS Code Insiders", "success")

        except Exception as e:
            self._print_status(f"Could not read extensions file: {e}", "warning")

        return extensions

    def _save_extension_list(self, extensions: List[str]) -> bool:
        """Save extension list to Cursor directory."""
        if not extensions:
            return False

        extensions_file = self.paths['cursor'] / "imported-extensions-list.txt"

        if self.what_if:
            self._print_status(f"[WHAT-IF] Would create extensions list at: {extensions_file}", "info")
            return True

        try:
            # Ensure directory exists
            extensions_file.parent.mkdir(parents=True, exist_ok=True)

            with open(extensions_file, 'w', encoding='utf-8') as f:
                for ext in extensions:
                    f.write(f"{ext}\n")

            self._print_status(f"Created extensions list at: {extensions_file}", "success")
            return True
        except Exception as e:
            self._print_status(f"Failed to create extensions list: {e}", "error")
            return False

    def _import_configuration_files(self) -> int:
        """Import main configuration files."""
        self._print_status("Importing configuration files:", "info")
        success_count = 0

        files_to_copy = [
            ("settings.json", "Settings"),
            ("keybindings.json", "Keybindings"),
            ("locale.json", "Locale settings")
        ]

        for filename, description in files_to_copy:
            source = self.paths['vscode_insiders'] / filename
            destination = self.paths['cursor'] / filename

            if self._copy_file(source, destination, description):
                success_count += 1

        return success_count

    def _import_directories(self) -> int:
        """Import configuration directories."""
        self._print_status("Importing directories:", "info")
        success_count = 0

        directories_to_copy = [
            ("snippets", "User snippets"),
            ("History", "History"),
            ("CachedExtensions", "Cached extensions"),
            ("workspaceStorage", "Workspace storage")
        ]

        for dirname, description in directories_to_copy:
            source = self.paths['vscode_insiders'] / dirname
            destination = self.paths['cursor'] / dirname

            if self._copy_directory(source, destination, description):
                success_count += 1

        return success_count

    def _import_global_state(self) -> bool:
        """Import global state files."""
        self._print_status("Importing global state:", "info")

        global_state_file = self.paths['vscode_insiders'] / "globalStorage" / "storage.json"
        if not global_state_file.exists():
            self._print_status("Global state file not found (skipping)", "warning")
            return False

        destination_dir = self.paths['cursor'] / "globalStorage"
        destination_file = destination_dir / "storage.json"

        return self._copy_file(global_state_file, destination_file, "Global state")

    def _import_theme_files(self) -> int:
        """Import theme and appearance files."""
        self._print_status("Importing theme files:", "info")
        success_count = 0

        theme_files = [
            ("colorTheme.json", "Color theme"),
            ("iconTheme.json", "Icon theme"),
            ("productIconTheme.json", "Product icon theme")
        ]

        for filename, description in theme_files:
            source = self.paths['vscode_insiders'] / filename
            destination = self.paths['cursor'] / filename

            if self._copy_file(source, destination, description):
                success_count += 1

        return success_count

    def _validate_paths(self) -> bool:
        """Validate that required paths exist."""
        vscode_path = self.paths['vscode_insiders']
        cursor_path = self.paths['cursor']

        if not vscode_path.exists():
            self._print_status(f"VS Code Insiders settings not found at: {vscode_path}", "error")
            self._print_status("Please ensure VS Code Insiders is installed and has been used at least once.", "warning")
            return False

        # Create Cursor directory if it doesn't exist
        if not cursor_path.exists():
            self._print_status(f"Creating Cursor settings directory: {cursor_path}", "info")
            if not self.what_if:
                cursor_path.mkdir(parents=True, exist_ok=True)

        return True

    def import_settings(self) -> bool:
        """Main import function."""
        self._print_header()

        # Validate paths
        if not self._validate_paths():
            return False

        # Create backup
        backup_path = self._create_backup()

        # Import all components
        self._print_status("Importing settings from VS Code Insiders to Cursor...", "info")
        print()

        # Import configuration files
        config_success = self._import_configuration_files()
        print()

        # Import directories
        dir_success = self._import_directories()
        print()

        # Import global state
        global_success = self._import_global_state()
        print()

        # Import theme files
        theme_success = self._import_theme_files()
        print()

        # Handle extensions
        self._print_status("Extension information:", "info")
        extensions = self._get_extension_list()
        ext_success = self._save_extension_list(extensions)
        print()

        # Summary
        total_operations = config_success + dir_success + (1 if global_success else 0) + theme_success + (1 if ext_success else 0)

        if self.what_if:
            self._print_status("WHAT-IF MODE: No actual changes were made", "info")
            self._print_status("Run without --what-if to perform the actual import", "warning")
        else:
            self._print_status("Import completed successfully!", "success")
            print()
            self._print_status("Next steps:", "info")
            self._print_status("1. Restart Cursor to apply the new settings", "info")
            self._print_status("2. Check that your extensions are working correctly", "info")
            self._print_status("3. Verify your keybindings and settings", "info")
            if backup_path:
                self._print_status(f"4. Your original settings are backed up at: {backup_path}", "info")

        print()
        self._print_status("Tips:", "info")
        self._print_status("• Some extensions may need to be reinstalled in Cursor", "info")
        self._print_status("• Check Cursor's extension marketplace for any missing extensions", "info")
        self._print_status("• You can restore from backup if needed using the restore script", "info")

        return total_operations > 0


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Import VS Code Insiders settings to Cursor IDE",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s                    # Basic import with backup
  %(prog)s --no-backup        # Import without backup
  %(prog)s --what-if          # Test what would be imported
  %(prog)s --force            # Skip confirmation prompts
        """
    )

    parser.add_argument(
        '--backup',
        action='store_true',
        default=True,
        help='Create backup before importing (default: True)'
    )
    parser.add_argument(
        '--no-backup',
        action='store_false',
        dest='backup',
        help='Skip backup creation'
    )
    parser.add_argument(
        '--what-if',
        action='store_true',
        help='Show what would be done without making changes'
    )
    parser.add_argument(
        '--force',
        action='store_true',
        help='Skip confirmation prompts'
    )

    args = parser.parse_args()

    # Create importer and run
    importer = VSCodeToCursorImporter(what_if=args.what_if, backup=args.backup)
    success = importer.import_settings()

    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
