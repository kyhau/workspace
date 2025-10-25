#!/usr/bin/env python3
"""Copy rules to AI coding assistant configurations."""
import argparse
import shutil
from pathlib import Path

ASSISTANTS = {
    "cursor": ".cursor/rules",
    "windsurf": ".windsurf/rules",
    "copilot": ".github/instructions",
    "q": ".amazonq/rules",
}


def copy_rules(source_dir: Path, targets: list[str], project_dir: Path):
    """Copy rules from source to target assistant directories."""
    if not source_dir.exists():
        print(f"❌ Source directory not found: {source_dir}")
        return

    rule_files = list(source_dir.glob("*.md"))
    if not rule_files:
        print(f"❌ No .md files found in {source_dir}")
        return

    print(f"📁 Found {len(rule_files)} rule file(s) in {source_dir}")

    for target in targets:
        target_path = project_dir / ASSISTANTS[target]
        target_path.mkdir(parents=True, exist_ok=True)

        for rule_file in rule_files:
            if target == "cursor":
                dest = target_path / rule_file.with_suffix(".mdc").name
            else:
                dest = target_path / rule_file.name
            shutil.copy2(rule_file, dest)
            print(f"✅ Copied {rule_file.name} → {dest}")


def main():
    parser = argparse.ArgumentParser(description="Copy rules to AI assistant configurations")
    parser.add_argument(
        "-t",
        "--targets",
        nargs="+",
        choices=list(ASSISTANTS.keys()),
        required=True,
        help="Target assistant(s): cursor, windsurf, copilot, q",
    )
    parser.add_argument(
        "-s",
        "--source",
        type=Path,
        default=Path(__file__).parent.parent.parent / "rules",
        help="Source rules directory (default: workspace/rules/)",
    )
    parser.add_argument(
        "-p",
        "--project",
        type=Path,
        default=Path.cwd(),
        help="Target project directory (default: current directory)",
    )

    args = parser.parse_args()
    copy_rules(args.source, args.targets, args.project)


if __name__ == "__main__":
    main()
