import json
import logging
import subprocess

logging.getLogger().setLevel(logging.DEBUG)


def call_check_output(command):
    command_list = command.split(" ")
    try:
        output = subprocess.check_output(command_list, stderr=subprocess.STDOUT)
        return json.loads(output)
    except subprocess.CalledProcessError as err:
        logging.error(err)
    except Exception as e:
        logging.error(e)


def call_run(command):
    command_list = command.split(" ")
    try:
        logging.info(f"Running shell command: {command}")
        result = subprocess.run(command_list, stdout=subprocess.PIPE);
        logging.info("Command output:\n---\n{}\n---".format(result.stdout.decode("UTF-8")))
    except Exception as e:
        logging.error(f"Exception: {e}")
        return False
    return True


def main():
    call_run("aws help1")

    call_check_output("aws elbv2 describe-load-balancers")

if __name__ == "__main__":
     main()
