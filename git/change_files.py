import os


def run(dir_name, from_str, to_str):
    for d in os.listdir(dir_name):
        p = os.path.join(dir_name, d, ".git", "config")
        with open(p) as file:
            content = file.read()

        if from_str in content:
            print("Updating {}".format(p))
            content = content.replace(from_str, to_str)
            with open(p, mode="w") as file2:
                file2.write(content)

run(dir_name="/mnt/c/Workspace/bitbucket", from_str="https://bitbucket.org/biarrinetworks", to_str="git@bitbucket.org:biarrinetworks")
