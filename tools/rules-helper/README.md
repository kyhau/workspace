# Rules Helper

Copy coding rules to AI assistant project configurations (Cursor, Windsurf, GitHub Copilot, Amazon Q).

## Usage

```bash
# Copy to single assistant in current directory
python copy_rules.py -t cursor

# Copy to multiple assistants
python copy_rules.py -t cursor windsurf q

# Copy to specific project directory
python copy_rules.py -t q -p /path/to/project

# Copy from custom source
python copy_rules.py -t cursor -s /path/to/rules
```

## Target Paths

- **cursor**: `.cursor/rules/` (uses .mdc extension)
- **windsurf**: `.windsurf/rules/` (uses .md extension)
- **copilot**: `.github/instructions/` (uses .md extension)
- **q**: `.amazonq/rules/` (uses .md extension)

## Default Source

`workspace/rules/` (contains `general-standards.md`, `python-makefile.md`)
