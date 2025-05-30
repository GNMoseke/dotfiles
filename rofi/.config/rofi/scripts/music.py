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
    # NOTE: this is mpd specific, since it no-likey abs paths.
    # FIXME: I *should* be querying the mpd database directly, but there's 2 problems I need to
    # solve there:
    # 1. The query only gives back files (individual tracks). I want to support adding full albums
    # to the queue.
    # 2. The DB includes every file format for every track, so I'd have to do some post filtering to
    # find the best quality ones (rather than this way, where it's included in the index)
    path = index[name]["highest_quality_path_rel"]
    cover_img = index[name]["cover_path"]
    if not path:
        print(f"not found in index: {selection}")

    # Whatever music player I'm currently favoring
    # NOTE: this uses cwd for the same reason outlined above w.r.t. mpd
    subprocess.run(["mpc", "add", path], cwd=music_base)
    subprocess.run(["mpc", "play"])

    notif = ["notify-send"]
    if cover_img:
        notif += ["-i", cover_img]
    notif += ["-a", "Music", "ADDED TO QUEUE", f"{name}"]

    subprocess.run(notif)
    exit(0)

print("\n".join([meta["rofi_str"] for _, meta in index.items()]))
