import csv
from collections import namedtuple
import logging
import os
import time

from requests import Session
from warrant import Cognito

# Hardcoded to the 'production' details?
COGNITO_USERPOOL_APPCLIENTID = "7l526fp7mo1htrf01d7odn25bt"
COGNITO_USERPOOL_ID = "ap-southeast-2_GWE7XmZ5I"
ORCA_API_BASE_URL = "https://orca.biarrinetworks.com/v1"
COGNITO_UNAME = os.environ.get("COGNITO_UNAME")
COGNITO_UPASS = os.environ.get("COGNITO_UPASS")


def a_settings():
    """Retrieve pytest and AWS settings from the environment variables and command line options
    """
    # Hack to overwrite the default AWS profile loading in Warrant
    # See https://github.com/capless/warrant/issues/80
    os.environ["AWS_ACCESS_KEY_ID"] = ""
    os.environ["AWS_SECRET_ACCESS_KEY"] = ""
    os.environ["AWS_ACCESS_KEY_ID"] = ""
    os.environ["AWS_SECRET_ACCESS_KEY"] = ""

    ret = {
        "cognito_test_user": COGNITO_UNAME,
        "cognito_test_user_pw": COGNITO_UPASS,
        "cognito_userpool": COGNITO_USERPOOL_ID,
        "cognito_userpool_appclientid": COGNITO_USERPOOL_APPCLIENTID,
    }

    logging.info("\n==================================================\nTest Settings:")
    return ret


# TODO: Replace usage with official Orca Python client once we make one (DEV-3403)
class OrcaClient(object):
    def __init__(self, userpool, userpool_appclientid, username, password):
        self._user = Cognito(userpool, userpool_appclientid, user_pool_region="ap-southeast-2", username=username)
        #self._user = Cognito(userpool, userpool_appclientid, user_pool_region="ap-southeast-2", access_key="none",
        #                     secret_key="none", username=username)
        self._user.authenticate(password=password)
        self._session = Session()
        self._session.headers.update({"authorizationToken": self._user.access_token})
        self.api_base_url = ORCA_API_BASE_URL


#print(os.environ["AWS_ACCESS_KEY_ID"])
#print(os.environ["AWS_SECRET_ACCESS_KEY"])

settings = a_settings()
a = OrcaClient(
    settings["cognito_userpool"],
    settings["cognito_userpool_appclientid"],
    settings["cognito_test_user"],
    settings["cognito_test_user_pw"],
)


print(a._user.access_token)