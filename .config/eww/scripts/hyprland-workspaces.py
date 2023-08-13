#!/bin/python
from hyprland import hyprland_listen
import json
import subprocess

def reload_data():
    output = []

    monitors = json.loads(subprocess.run(['hyprctl' , '-j', 'monitors'], stdout=subprocess.PIPE).stdout.decode())
    monitors = sorted(monitors, key=lambda d: d['id'])
    workspaces = json.loads(subprocess.run(['hyprctl' , '-j', 'workspaces'], stdout=subprocess.PIPE).stdout.decode())
    workspaces = sorted(workspaces, key=lambda d: d['id'])

    for monitor in monitors:
        output.append({
            "name": monitor["name"],
            "activewindow": "",
            "workspaces": []
        })

        for workspace in workspaces:
            if workspace['monitor'] != monitor['name']:
                continue

            output[-1]['workspaces'].append({
                "id": workspace['id'],
                "name": workspace['name'],
                "active": monitor['activeWorkspace']['id'] == workspace['id']
            })

    print(json.dumps(output), flush=True)

def handle_command(command, _):
    match command:
        case "workspace": reload_data()
        case "monitorremoved": reload_data()
        case "monitoradded": reload_data()
        case "createworkspace": reload_data()
        case "destroyworkspace": reload_data()
        case "moveworkspace": reload_data()

reload_data()
hyprland_listen(handle_command)
