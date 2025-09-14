#!/usr/bin/env python3
"""
Backup Cursor Settings
Cross-platform Python script to create backups of Cursor IDE settings on Windows and macOS.
"""

import os
import sys
import shutil
import argparse
import platform
from pathlib import Path
from datetime import datetime
from typing import Optional


class CursorSettingsBackup:
    """Cross-platform backup tool for Cursor settings."""

    def __init__(self, what_if: bool = False):
        self.what_if = what_if
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
        print("Cursor Settings Backup Tool")
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

    def _get_backup_path(self, custom_path: Optional[str] = None) -> Path:
        """Generate a backup path."""
        if custom_path:
            return Path(custom_path)

        timestamp = datetime.now().strftime('%Y%m%d-%H%M%S')
        return self.paths['backup_base'] / f"User.backup.{timestamp}"

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

    def create_backup(self, backup_path: Optional[str] = None) -> bool:
        """Create a backup of Cursor settings."""
        self._print_header()

        cursor_path = self.paths['cursor']
        backup_path = self._get_backup_path(backup_path)

        # Check if Cursor settings exist
        if not cursor_path.exists():
            self._print_status(f"Cursor settings not found at: {cursor_path}", "error")
            self._print_status("Please ensure Cursor is installed and has been used at least once.", "warning")
            return False

        self._print_status(f"Cursor settings location: {cursor_path}", "info")
        self._print_status(f"Backup destination: {backup_path}", "info")
        print()

        if self.what_if:
            self._print_status("WHAT-IF MODE: Would create backup", "info")
            self._print_status(f"  Source: {cursor_path}", "info")
            self._print_status(f"  Destination: {backup_path}", "info")
            return True

        try:
            # Create backup directory if it doesn't exist
            backup_path.parent.mkdir(parents=True, exist_ok=True)

            # Create the backup
            self._print_status("Creating backup...", "progress")
            shutil.copytree(cursor_path, backup_path)

            # Verify backup and show statistics
            if backup_path.exists():
                source_size = self._get_directory_size(cursor_path)
                backup_size = self._get_directory_size(backup_path)

                self._print_status("Backup created successfully!", "success")
                self._print_status(f"Source size: {self._format_size(source_size)}", "info")
                self._print_status(f"Backup size: {self._format_size(backup_size)}", "info")
                self._print_status(f"Location: {backup_path}", "info")

                return True
            else:
                self._print_status("Backup failed - destination not found", "error")
                return False

        except Exception as e:
            self._print_status(f"Backup failed: {e}", "error")
            return False

    def list_backups(self) -> None:
        """List existing backups."""
        self._print_header()

        backup_base = self.paths['backup_base']
        if not backup_base.exists():
            self._print_status("No backup directory found", "warning")
            return

        # Find all backup directories
        backup_dirs = []
        for item in backup_base.iterdir():
            if item.is_dir() and item.name.startswith('User.backup.'):
                backup_dirs.append(item)

        if not backup_dirs:
            self._print_status("No backups found", "warning")
            return

        # Sort by modification time (newest first)
        backup_dirs.sort(key=lambda x: x.stat().st_mtime, reverse=True)

        self._print_status(f"Found {len(backup_dirs)} backup(s):", "info")
        print()

        for i, backup_dir in enumerate(backup_dirs, 1):
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
        description="Backup Cursor IDE settings",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s                           # Create backup with timestamp
  %(prog)s --backup-path /path/to/backup  # Create backup to specific location
  %(prog)s --what-if                 # Test what would be backed up
  %(prog)s --list                    # List existing backups
        """
    )

    parser.add_argument(
        '--backup-path',
        help='Custom backup location (default: auto-generated with timestamp)'
    )
    parser.add_argument(
        '--what-if',
        action='store_true',
        help='Show what would be backed up without making changes'
    )
    parser.add_argument(
        '--list',
        action='store_true',
        help='List existing backups'
    )

    args = parser.parse_args()

    # Create backup tool
    backup_tool = CursorSettingsBackup(what_if=args.what_if)

    if args.list:
        backup_tool.list_backups()
        sys.exit(0)

    # Create backup
    success = backup_tool.create_backup(args.backup_path)

    if success and not args.what_if:
        print()
        backup_tool._print_status("To restore from this backup, use:", "info")
        backup_tool._print_status("python restore_cursor_settings.py --backup-path 'BACKUP_PATH'", "info")

    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
