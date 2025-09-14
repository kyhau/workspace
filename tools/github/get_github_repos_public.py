"""
Environment variables:
- GITHUB_TOKEN - A GitHub PAT token with sufficient privileges to be able to pull a list of members in a given organization.

To run:
> python3 get_github_repos_public.py ${GITHUB ORGANISATION NAME}
"""
import json
import os
import sys

import requests

TOKEN = os.getenv("GITHUB_TOKEN")

HEADERS = {
    "Content-Type": "application/json; charset=utf-8",
    "X-GitHub-Api-Version": "2022-11-28",
    "Authorization": f"token {TOKEN}"
}


def get_all_users_in_organization(organization):
    base_url = f"https://api.github.com/orgs/{organization}/members"

    all_users = []
    page = 1
    per_page = 100

    while True:
        params = {"page": page, "per_page": per_page}
        response = requests.get(base_url, headers=HEADERS, params=params)
        if response.status_code != 200:
            raise Exception(f"Failed to retrieve users. Status code: {response.status_code}")

        users = response.json()
        if not users:
            break

        all_users.extend(users)
        page += 1

    return all_users


def find_public_repositories(username):
    base_url = f"https://api.github.com/users/{username}/repos"

    response = requests.get(base_url, headers=HEADERS)
    if response.status_code != 200:
        raise Exception(f"Failed to retrieve users. Status code: {response.status_code}")

    return response.json()


def main(organization):
    all_organization_users = get_all_users_in_organization(organization)
    print(f"Retrievied {len(all_organization_users)} users")

    public_repo_dict = {}
    for user in all_organization_users:
        username = user["login"]
        user_repos = find_public_repositories(username)
        if len(user_repos):
            repos_list = [
                {"Url": x["html_url"], "Description": x.get("description", "")}
                for x in user_repos if x["fork"] == False
            ]
            if len(repos_list):
                public_repo_dict.update({username: repos_list})

    print(json.dumps(public_repo_dict, indent=2))


if __name__ == "__main__":
    organization = sys.argv[1]
    main(organization)
