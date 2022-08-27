import datetime


def readlines_txt_file(filename):
    with open(filename) as f:
        # ignore empty/commented line
        lns = f.readlines()
        return [x.strip() for x in lns if x.strip() and not x.strip().startswith("#")]


def process_logs():
    ret = []
    cnt = 0
    last_rec = None

    for line in readlines_txt_file("log.txt"):
        if line.startswith("commit"):
            # new entry
            cnt += 1
            if last_rec:
                ret.append(last_rec)
            last_rec = {
                "commit": line.split(" ")[1].strip(),
                "msgs": []
            }

        elif line.startswith("Author:"):
            if "dependabot" in line:
                # skip
                last_rec = None
            else:
                if "virtualda" not in line:
                    raise Exception("Unexpected Author: %s" % line)
                last_rec["author"] = "@kyahu"

        elif line.startswith("Date:"):
            if last_rec:
                # E.g. Date:   Sat Aug 27 13:42:29 2022 +1000
                parts = line.split(" ")
                d = datetime.datetime.strptime(f"{parts[5]} {parts[4]} {parts[7]}", "%d %b %Y").strftime("%Y-%m-%d")
                last_rec["date"] = d

        else:
            if last_rec:
                last_rec["msgs"].append(line)

    return ret


def generate_changelog(records):
    print("# Changelog\n")
    print("All notable changes to this project will be documented in this file.\n")
    print("## [Unreleased]")

    prev_record_date = None
    for record in records:

        if prev_record_date != record["date"]:
            prev_record_date = record["date"]
            print(f"\n## {prev_record_date}\n")

        for line in record["msgs"]:
            print(f"   * {line}")


def main():
    records = process_logs()
    generate_changelog(records)


if __name__ == "__main__":
    main()
