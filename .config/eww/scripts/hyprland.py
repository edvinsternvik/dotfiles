import os
import asyncio

async def ipc_client(handle_command):
    HYPRLAND_INSTANCE_SIGNATURE = os.environ["HYPRLAND_INSTANCE_SIGNATURE"]
    HYPRLAND_IPC = f"/tmp/hypr/{HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"

    reader, _ = await asyncio.open_unix_connection(HYPRLAND_IPC)

    while True:
        line = await reader.readline()
        line = line.decode()
        
        command = line[:line.find(">>")]
        data = line[line.find(">>") + 2:]
        handle_command(command, data)

def hyprland_listen(handle_command):
    asyncio.run(ipc_client(handle_command))
