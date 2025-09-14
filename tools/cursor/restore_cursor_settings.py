#!/usr/bin/env python3
"""
Restore Cursor Settings from Backup
Cross-platform Python script to restore Cursor IDE settings from a previous backup on Windows and macOS.
"""

import os
import sys
import shutil
import argparse
import platform
from pathlib import Path
from datetime import datetime
from typing import Optional


class CursorSettingsRestore:
    """Cross-platform restore tool for Cursor settings."""

    def __init__(self, what_if: bool = False, force: bool = False):
        self.what_if = what_if
        self.force = force
        self.system = platform.system().lower()
        self.paths = self._get_platform_paths()

    def _get_platform_paths(self) -> dict:
        """Get platform-specific paths for Cursor settings."""
        if self.system == "windows":
            appdata = Path(os.environ.get('APPDATA', ''))
            return {
                'cursor': appdata / "Cursor" / "User",
                'backup_base': appdata / "Cursor"
            }
        elif self.system == "darwin":  # macOS
            home = Path.home()
            return {
                'cursor': home / "Library" / "Application Support" / "Cursor" / "User",
                'backup_base': home / "Library" / "Application Support" / "Cursor"
            }
        else:
            # Linux
            home = Path.home()
            return {
                'cursor': home / ".config" / "Cursor" / "User",
                'backup_base': home / ".config" / "Cursor"
            }

    def _print_header(self):
        """Print the script header."""
        print("=" * 40)
        print("Cursor Settings Restore Tool")
        print("=" * 40)
        print(f"Platform: {self.system.title()}")
        print(f"Python: {sys.version.split()[0]}")
        print()

    def _print_status(self, message: str, status: str = "info"):
        """Print status messages with appropriate symbols."""
        symbols = {
            "info": "ℹ️ ",
            "success": "✅",
            "warning": "⚠️ ",
            "error": "❌",
            "progress": "🔄"
        }
        print(f"{symbols.get(status, '')} {message}")

    def _get_directory_size(self, path: Path) -> int:
        """Calculate the total size of a directory in bytes."""
        total_size = 0
        try:
            for file_path in path.rglob('*'):
                if file_path.is_file():
                    total_size += file_path.stat().st_size
        except (OSError, PermissionError):
            pass
        return total_size

    def _format_size(self, size_bytes: int) -> str:
        """Format size in bytes to human readable format."""
        for unit in ['B', 'KB', 'MB', 'GB']:
            if size_bytes < 1024.0:
                return f"{size_bytes:.1f} {unit}"
            size_bytes /= 1024.0
        return f"{size_bytes:.1f} TB"

    def _confirm_restore(self) -> bool:
        """Ask for user confirmation before restoring."""
        if self.force:
            return True

        print("⚠️  Current Cursor settings will be overwritten!")
        print(f"   Current settings location: {self.paths['cursor']}")
        print()

        while True:
            response = input("Do you want to continue? (y/N): ").strip().lower()
            if response in ['y', 'yes']:
                return True
            elif response in ['n', 'no', '']:
                return False
            else:
                print("Please enter 'y' for yes or 'n' for no.")

    def _list_available_backups(self) -> list:
        """List available backups in the backup directory."""
        backup_base = self.paths['backup_base']
        if not backup_base.exists():
            return []

        backup_dirs = []
        for item in backup_base.iterdir():
            if item.is_dir() and item.name.startswith('User.backup.'):
                backup_dirs.append(item)

        # Sort by modification time (newest first)
        backup_dirs.sort(key=lambda x: x.stat().st_mtime, reverse=True)
        return backup_dirs

    def _interactive_backup_selection(self) -> Optional[Path]:
        """Allow user to interactively select a backup."""
        backups = self._list_available_backups()

        if not backups:
            self._print_status("No backups found in the backup directory", "warning")
            return None

        self._print_status(f"Found {len(backups)} backup(s):", "info")
        print()

        for i, backup_dir in enumerate(backups, 1):
            try:
                size = self._format_size(self._get_directory_size(backup_dir))
                mtime = datetime.fromtimestamp(backup_dir.stat().st_mtime)
                print(f"{i:2d}. {backup_dir.name}")
                print(f"    Size: {size}")
                print(f"    Date: {mtime.strftime('%Y-%m-%d %H:%M:%S')}")
                print(f"    Path: {backup_dir}")
                print()
            except Exception as e:
                print(f"{i:2d}. {backup_dir.name} (Error reading: {e})")
                print()

        while True:
            try:
                choice = input(f"Select backup to restore (1-{len(backups)}, or 'q' to quit): ").strip()
                if choice.lower() == 'q':
                    return None

                index = int(choice) - 1
                if 0 <= index < len(backups):
                    return backups[index]
                else:
                    print(f"Please enter a number between 1 and {len(backups)}.")
            except ValueError:
                print("Please enter a valid number or 'q' to quit.")

    def restore_from_backup(self, backup_path: Optional[str] = None) -> bool:
        """Restore Cursor settings from a backup."""
        self._print_header()

        # Determine backup path
        if backup_path:
            backup_path = Path(backup_path)
        else:
            # Interactive selection
            backup_path = self._interactive_backup_selection()
            if not backup_path:
                self._print_status("No backup selected", "warning")
                return False

        cursor_path = self.paths['cursor']

        # Check if backup exists
        if not backup_path.exists():
            self._print_status(f"Backup not found at: {backup_path}", "error")
            self._print_status("Please verify the backup path is correct.", "warning")
            return False

        self._print_status(f"Backup location: {backup_path}", "info")
        self._print_status(f"Restore destination: {cursor_path}", "info")
        print()

        # Check if Cursor settings directory exists
        if cursor_path.exists():
            if not self._confirm_restore():
                self._print_status("Restore cancelled by user", "warning")
                return False
        else:
            self._print_status("Cursor settings directory not found, will be created", "info")

        if self.what_if:
            self._print_status("WHAT-IF MODE: Would restore from backup", "info")
            self._print_status(f"  Source: {backup_path}", "info")
            self._print_status(f"  Destination: {cursor_path}", "info")
            return True

        try:
            # Create Cursor settings directory if it doesn't exist
            cursor_path.parent.mkdir(parents=True, exist_ok=True)

            # Remove existing settings if they exist
            if cursor_path.exists():
                self._print_status("Removing existing Cursor settings...", "progress")
                shutil.rmtree(cursor_path)

            # Restore from backup
            self._print_status("Restoring from backup...", "progress")
            shutil.copytree(backup_path, cursor_path)

            # Verify restore and show statistics
            if cursor_path.exists():
                backup_size = self._get_directory_size(backup_path)
                restored_size = self._get_directory_size(cursor_path)

                self._print_status("Settings restored successfully!", "success")
                self._print_status(f"Backup size: {self._format_size(backup_size)}", "info")
                self._print_status(f"Restored size: {self._format_size(restored_size)}", "info")
                self._print_status(f"Restored to: {cursor_path}", "info")

                return True
            else:
                self._print_status("Restore failed - destination not found", "error")
                return False

        except Exception as e:
            self._print_status(f"Restore failed: {e}", "error")
            return False

    def list_backups(self) -> None:
        """List available backups."""
        self._print_header()

        backups = self._list_available_backups()

        if not backups:
            self._print_status("No backups found", "warning")
            return

        self._print_status(f"Available backups ({len(backups)}):", "info")
        print()

        for i, backup_dir in enumerate(backups, 1):
            try:
                size = self._format_size(self._get_directory_size(backup_dir))
                mtime = datetime.fromtimestamp(backup_dir.stat().st_mtime)
                print(f"{i:2d}. {backup_dir.name}")
                print(f"    Size: {size}")
                print(f"    Date: {mtime.strftime('%Y-%m-%d %H:%M:%S')}")
                print(f"    Path: {backup_dir}")
                print()
            except Exception as e:
                print(f"{i:2d}. {backup_dir.name} (Error reading: {e})")
                print()


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Restore Cursor IDE settings from backup",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s                                    # Interactive backup selection
  %(prog)s --backup-path /path/to/backup      # Restore from specific backup
  %(prog)s --what-if                          # Test what would be restored
  %(prog)s --force                            # Skip confirmation prompts
  %(prog)s --list                             # List available backups
        """
    )

    parser.add_argument(
        '--backup-path',
        help='Path to the backup to restore (if not provided, interactive selection will be used)'
    )
    parser.add_argument(
        '--what-if',
        action='store_true',
        help='Show what would be restored without making changes'
    )
    parser.add_argument(
        '--force',
        action='store_true',
        help='Skip confirmation prompts'
    )
    parser.add_argument(
        '--list',
        action='store_true',
        help='List available backups'
    )

    args = parser.parse_args()

    # Create restore tool
    restore_tool = CursorSettingsRestore(what_if=args.what_if, force=args.force)

    if args.list:
        restore_tool.list_backups()
        sys.exit(0)

    # Restore from backup
    success = restore_tool.restore_from_backup(args.backup_path)

    if success and not args.what_if:
        print()
        restore_tool._print_status("Next steps:", "info")
        restore_tool._print_status("1. Restart Cursor to apply the restored settings", "info")
        restore_tool._print_status("2. Verify that your settings and extensions are working correctly", "info")
        restore_tool._print_status("3. Check that your keybindings and themes are restored", "info")

        print()
        restore_tool._print_status("Tips:", "info")
        restore_tool._print_status("• If you encounter issues, you can create a new backup before making changes", "info")
        restore_tool._print_status("• Some extensions may need to be reinstalled if they're not compatible", "info")

    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
