#! /usr/bin/env python
import sys
import json
import pathlib
import subprocess

music_base = f"{pathlib.Path.home()}/Music/"
index = {}
with open(f"{music_base}.rofi-index.json", 'r') as f:
    index = json.load(f)

selection = sys.argv[1:]
if selection:
    name = selection[0]
    path = index[name]["path"]
    cover_img = index[name]["cover_path"]
    if not path:
        print(f"not found in index: {selection}")

    # Whatever music player I'm currently favoring
    subprocess.run(["amberol", path])

    notif = ["notify-send"]
    if cover_img:
        notif += ["-i", cover_img]
    notif += ["-a", "Music", "ADDED TO QUEUE", f"{name}"]

    subprocess.run(notif)
    exit(0)

print("\n".join([meta["rofi_str"] for _, meta in index.items()]))
