import logging
import os
import subprocess


def call_ping(url):
    args = ["ping", "-c", "1", url]

    try:
        output = subprocess.check_output(args, stderr=subprocess.STDOUT)
        duration_ms = output.decode("utf-8").splitlines()[1].split("time=")[-1].split(" ms")[0]
        return 200, {"TotalDurationInMs": duration_ms}

    except subprocess.CalledProcessError as err:
        fail_lines = filter(lambda x: x.startswith("ping"), err.output.decode("utf-8").splitlines())
        logging.error(", ".join(fail_lines))
        return err.returncode, {}


def call_ping_2(url):
    response = os.system("ping -c 1 " + url)
    print("CheckPt --------------------------------------------------------------------------")
    print(response)

    print("Results --------------------------------------------------------------------------")
    if response == 0:
        print(url, 'is up!')
    else:
        print(url, 'is down!')


code, data = call_ping("google.com")
print(code)
print(data)
