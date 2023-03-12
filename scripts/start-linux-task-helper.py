#!/usr/bin/env python3
import os
import time
import json
import datetime
from subprocess import Popen, PIPE
import schedule

__TASKS = []

# Json configuration loading

def __close(fstring: str, res: int):
    print(fstring)
    print("\nScheduler Closed")
    exit(res)


__JSON_CONFIG_PATH = f"/etc/tasks_config.json"
if not os.path.exists(__JSON_CONFIG_PATH):
    __close(f"\nCannot find json file {__JSON_CONFIG_PATH}", -1)

with open(__JSON_CONFIG_PATH, "r") as fp:
    j = json.load(fp)
    if j == None or "tasks" not in j or not isinstance(j["tasks"], list):
        __close(f"\nJson format error: no tasks label", -1)

    for i, task in enumerate(j["tasks"]):
        if "workDir" not in task or "cmd" not in task:
            __close(
                f"\nJson format error: workDir label or cmd label not found in task {i}",
                -1,
            )

        if not os.path.exists(task["workDir"]):
            __close(
                f"\nJson format error: workDir {task['workDir']} doesn't exists in task {i}",
                -1,
            )
        __TASKS.append(task)

        if len(task["cmd"]) == 0:
            __close(f"\nJson format error: Empty cmd field", -1)


def __run_task(task: dict):
    print(f"\nRunning task: {task['cmd']}")
    p = Popen(task["cmd"], cwd=task["workDir"], shell=True, stdout=PIPE, stderr=PIPE)
    output, _err = p.communicate()
    p.wait()


__START_JOBS = []
for task in __TASKS:
    if len(task["runsOn"]) == 0:
        __START_JOBS.append(task)
        continue

    for date in task["runsOn"]:
        try:
            schedule.every().day.at(date).do(lambda : __run_task(task))
        except Exception as e:
            print(str(e))
            __close(f"\nFailed to schedule script on date: {date}", -1)

print("\nSetup Successfull")

for task in __START_JOBS:
    try:
        __run_task(task)
    except Exception as e:
        print(str(e))
        print(f"\nFailed to run Task: {task['cmd']}")

print(f"\nRunning scheduler...")
while True:
    try:
        schedule.run_pending()
    except Exception as e:
        __close(f"\nScheduler got exception {str(e)}", -1)

    time.sleep(1)

__close("", 0)
