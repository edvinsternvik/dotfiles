#!/bin/python
from hyprland import hyprland_listen

def print_active(data):
    data = data.strip()
    _, title = data.split(',')
    print(title, flush=True)

def handle_command(command, data):
    match command:
        case "activewindow": print_active(data)

hyprland_listen(handle_command)
