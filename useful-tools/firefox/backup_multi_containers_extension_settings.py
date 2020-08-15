"""
A script to backup Firefox Multi Containers extension settings.

The files needed are:
   cookies.sqlite
   containers.json
Copy those files to the new profile and all the containers will be present in the new profile.
Don't copy the file cookies.sqlite-wal (if present).
Ref: https://support.mozilla.org/bm/questions/1269248
"""
from os import getenv
from pathlib import Path
from shutil import copy
import sys


def copy_files(src_files, dest_path):
    Path(dest_path).mkdir(parents=True, exist_ok=True)
    cnt = 0
    for f in src_files:
        dest_file = Path(dest_path).joinpath(f"{cnt}_{f.parts[-1]}")
        copy(f, dest_file)
        print(f"Copied {f} to {dest_file}")
        cnt += 1

if len(sys.argv) <= 1 or "help" in sys.argv[1].lower():
    print(f"Usage: {sys.argv[0]} <output_folder>")
    sys.exit(1)

dest_path = sys.argv[1]

profiles_path = f"{getenv('APPDATA')}\Mozilla\Firefox\Profiles"

print(f"Started backing up Firefox Multi-Account Containers settings for profiles in {profiles_path}")
print(f"Backup folder: {dest_path}")

for f in ["containers.json", "cookies.sqlite"]:
    copy_files(Path(profiles_path).rglob(f), dest_path)

