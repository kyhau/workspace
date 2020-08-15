import os
import sys

# If not arg specified, use `github`
opt = "github" if len(sys.argv) == 1 else sys.argv[1]
print(f"Started processing {opt} repos...")

OPTS = {
    "bitbucket": {
        "account": "kyhau",
        "site": "bitbucket.org"
    },
    "github": {
        "account": "kyhau",
        "site": "github.com",
    },
}


def run(dir_name, from_str, to_str):
    for d in os.listdir(dir_name):
        p = os.path.join(dir_name, d, ".git", "config")
        
        if not os.path.exists(p):
            print(f"Path not found: {p}. Skipped")
            continue

        with open(p) as file:
            content = file.read()

        if from_str in content:
            print("Updating {}".format(p))
            content = content.replace(from_str, to_str)
            with open(p, mode="w") as file2:
                file2.write(content)

run(
    dir_name=f"/mnt/c/Workspaces/{opt}",
    from_str=f"https://{OPTS[opt]['site']}/{OPTS[opt]['account']}",
    to_str=f"git@{OPTS[opt]['site']}:{OPTS[opt]['account']}",
)
