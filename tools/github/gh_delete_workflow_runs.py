"""
Select and delete workflow runs of a GitHub workflow

Prerequisites
- pip install click InquirerPy

"""
import json
import subprocess
import sys

import click
from InquirerPy import inquirer
from InquirerPy.base.control import Choice


def prompt_single_selection(name, options):
    if not options:
        raise ValueError("No profiles retrieved for selection.")

    return inquirer.select(
        message=f"Please choose the {name}",
        choices=options,
        default=None,
    ).execute()


def prompt_multi_selection(name, options):
    if not options:
        raise ValueError("No options retrieved for selection.")

    choices = [Choice(option, enabled=False) for option in options]

    return inquirer.checkbox(
        message=f"Please choose the {name}",
        choices=choices,
        cycle=True,
        transformer=lambda result: f"{len(result)} {name} selected",
    ).execute()


def call_check_output(command, to_json=True):
    command_list = command.split(" ")
    try:
        output = subprocess.check_output(command_list, stderr=subprocess.STDOUT)
        return json.loads(output) if to_json else output
    except subprocess.CalledProcessError as err:
        print(err)
        raise


@click.command(f"gh helper", help=f"{sys.argv[0]} OWNER/REPO")
@click.argument("OWNER_REPO")
@click.option("--dryrun", "-d", is_flag=True, help="Dry run")
def main(owner_repo, dryrun):

    cmd_workflows = f"gh api -X GET /repos/{owner_repo}/actions/workflows"
    workflows_json = call_check_output(cmd_workflows)

    # TODO Is workflow name unique?
    workflow_name_id_dict = {w["name"]: w["id"] for w in workflows_json["workflows"]}

    selected_name = prompt_single_selection("workflow", workflow_name_id_dict.keys())
    if not selected_name:
        print("Nothing selected")
        return

    workflow_id = workflow_name_id_dict[selected_name]

    cmd_workflow_runs = f"gh api -X GET /repos/{owner_repo}/actions/workflows/{workflow_id}/runs --paginate"
    workflow_runs_json = call_check_output(cmd_workflow_runs)

    workflow_runs_runnum_id_dict = {str(w["run_number"]):w["id"] for w in workflow_runs_json["workflow_runs"]}
    if not workflow_runs_runnum_id_dict:
        print("No workflow run returned")
        return

    selected_runs = prompt_multi_selection("workflow-run", workflow_runs_runnum_id_dict)
    if not selected_runs:
        print("Nothing selected")
        return

    for run_number, run_id in workflow_runs_runnum_id_dict.items():
        if run_number in selected_runs:
            if dryrun:
                print(f"Dryrun: Delete workflow run {selected_name}/{run_number} ({run_id})")
            else:
                print(f"Delete workflow run {selected_name}/{run_number} ({run_id})")
                cmd_del_workflow_run = f"gh api -X DELETE /repos/{owner_repo}/actions/runs/{run_id}"
                call_check_output(cmd_del_workflow_run, to_json=False)


if __name__ == "__main__":
    main()
