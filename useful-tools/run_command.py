import json
import logging
import subprocess

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def call_check_output(command):
    command_list = command.split(" ")
    try:
        output = subprocess.check_output(command_list, stderr=subprocess.STDOUT)
        return json.loads(output)
    except subprocess.CalledProcessError as err:
        logger.error(err)
    except Exception as e:
        logger.error(e)


def call_run(command):
    command_list = command.split(" ")
    try:
        logger.info(f"Running shell command: {command}")
        result = subprocess.run(command_list, stdout=subprocess.PIPE);
        logger.info("Command output:\n---\n{}\n---".format(result.stdout.decode("UTF-8")))
    except Exception as e:
        logger.error(f"Exception: {e}")
        return False
    return True


def main():
    call_run("aws help1")

    call_check_output("aws elbv2 describe-load-balancers")

if __name__ == "__main__":
     main()
