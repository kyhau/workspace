"""
Simple script for renaming files
"""
import click
import os


@click.command()
@click.option("--from-string", "-f", required=True, help="Substring in the filename to be replaced from")
@click.option("--to-string", "-t", required=True, help="Substring in the filename to be replaced to")
@click.option("--exclude-string", "-e", multiple=True, help="Skip renaming if filename contains the given string (support multiple)")
@click.option("--dryrun", "-d", is_flag=True, help="Run without taking real action")
def rename(from_string, to_string, exclude_string, dryrun):
    
    def skip(filename, exclude_string_list):
        if not exclude_string_list:
            return False
        for exclude_string in exclude_string_list:
            if exclude_string in filename:
                return True
        return False

    cwd = os.getcwd()
    cnt, done = 0, 0

    for subdir, dirs, files in os.walk(cwd):
        for filename in files:
            if skip(filename, exclude_string):
                continue
            if from_string not in filename:
                continue

            file_path = os.path.join(subdir, filename)
            new_file_path = file_path.replace(from_string, to_string)
            print(f"mv {file_path} to {new_file_path}")
            
            if dryrun is False:
                os.rename(file_path, new_file_path)
                done += 1
            cnt += 1
    
    print(f"Files matched: {cnt}")
    print(f"Files changed: {done}")


if __name__ == "__main__": rename()
