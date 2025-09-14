"""
This script aims to generate a draft of a CHANGELOG for "non-versioned" repo,
based on commit DATE (not based on versions/tags).

git log > log.txt
python git-log-2-changelog-by-dates.py > CHANGELOG-DRAFT.md
"""
import datetime

REPO_NAME = "TODO"
GIT_LOG_FILE = "log.txt"


def readlines_txt_file(filename):
    with open(filename) as f:
        # ignore empty line
        lns = f.readlines()
        return [x.strip() for x in lns if x.strip()]


def read_logs():
    ret = []
    this_commit, this_author, this_date = None, None, None

    for line in readlines_txt_file(GIT_LOG_FILE):
        if line.startswith("commit"):
            this_commit = line.split(" ")[1].strip()

        elif line.startswith("Author:"):
            this_author = line.split("Author: ")[1].strip()

        elif line.startswith("Date:"):
            # E.g. Date:   Sat Aug 27 13:42:29 2022 +1000
            parts = line.split(" ")
            this_date = datetime.datetime.strptime(f"{parts[5]} {parts[4]} {parts[7]}", "%d %b %Y").strftime("%Y-%m-%d")

        else:
            ########################################
            # Add additional filters here

            if "dependabot" in this_author:
                continue

            tmp_line = line.lower()
            if "merge branch" in tmp_line or "merge: " in tmp_line:
                continue

            # Additional filters end here
            ########################################

            category = "Changed"
            tmp_line = line.lower()
            if "add" in tmp_line or "create" in tmp_line:
                category = "Added"
            elif "delete" in tmp_line or "remove" in tmp_line:
                category = "Removed"
            elif "bug" in tmp_line or "fix" in tmp_line:
                category = "Fixed"

            line = line.replace("* ", "")

            ret.append({
                "Commit": this_commit,
                "Author": this_author,
                "Date": this_date,
                "Category": category,
                "Message": line,
            })

    return ret


def group_records_by_date_and_category(records):
    ret = []
    this_date = None
    this_date_records = None

    for record in records:
        if this_date != record["Date"]:
            if this_date_records:
                ret.append(this_date_records)
            this_date = record["Date"]
            this_date_records = {
                "Date": this_date,
                "Added": [],
                "Changed": [],
                "Fixed": [],
                "Removed": []
            }

        this_date_records[record["Category"]].append(record)

    return ret


def generate_changelog(dates_records):
    print("# Changelog\n")
    print("All notable changes to this project will be documented in this file.\n")

    for date_records in dates_records:
        print(f"\n## {date_records['Date']}")

        for category in ["Added", "Changed", "Fixed", "Removed"]:
            if date_records.get(category):
                print(f"\n### {category}\n")

                for record in date_records.get(category, []):
                    commit = record['Commit'][:7]
                    print(f"   * {record['Message']} ({commit} from {record['Author']})")


def main():
    records = read_logs()
    records = group_records_by_date_and_category(records)
    generate_changelog(records)


if __name__ == "__main__":
    main()
