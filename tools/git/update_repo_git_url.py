import os

DIR_NAME = os.path.abspath(".")


def run(dir_name, from_str, to_str, dry_run):
    for d in os.listdir(dir_name):
        p = os.path.join(dir_name, d, ".git", "config")

        if not os.path.exists(p):
            print(f"Path not found: {p}. Skipped")
            continue

        with open(p) as file:
            content = file.read()

        if from_str in content:

            print(f"Updating {p}")

            if dry_run is False:
                content = content.replace(from_str, to_str)
                with open(p, mode="w") as file2:
                    file2.write(content)


def https_to_ssh():
    # From https to ssh
    from_str="https://github.com/"
    to_str="git@github.com:"
    run(DIR_NAME, from_str, to_str, dry_run=False)


def ssh_to_https():
    # From https to ssh
    from_str="git@github.com:"
    to_str="https://github.com/"
    run(DIR_NAME, from_str, to_str, dry_run=False)


def replace_str():
    from_str="git@github.com"
    to_str="git@me.github.com"
    run(DIR_NAME, from_str, to_str, dry_run=False)


ssh_to_https()
