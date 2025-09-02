#! /usr/bin/env python
import sys
import json
import pathlib
import subprocess

# TODO: when I replace this with eurydice, it needs to be a driver bash script that
# invokes eurydice correctly (can't pass arguments to the binary from rofi)
# so it will call eurydice for the list, and then pass back to this script (or some other
# function) in order to add to the mpd queue.
music_base = f"{pathlib.Path.home()}/Music/"
index = {}
with open(f"{music_base}.rofi-index.json", 'r') as f:
    index = json.load(f)

selection = sys.argv[1:]
if selection:
    name = selection[0]

    # Why do lot work when string match do trick?
    if "Eurydice: Random" in name:
        eur_command = [f"{pathlib.Path.home()}/.local/bin/eurydice", "surprise-me"]
        if "Random Mixtape (1 Hour)" in name:
            subprocess.run(eur_command + ["playlist"])
        if "Random Mixtape (3 Hours)" in name:
            subprocess.run(eur_command + ["playlist", "--target-length", "180"])
        if "Random Album" in name:
            subprocess.run(eur_command + ["album"])
        if "Random 3 Albums" in name:
            subprocess.run(eur_command + ["album", "--count", "3"])
        cover_img = f"{music_base}/eurydice.png"
    elif index[name]["type"] == "playlist":
        subprocess.run(["mpc", "load", index[name]["mpd_name"]])
        subprocess.run(["mpc", "play"])
        cover_img = index[name]["cover_path"]
    else:
        # NOTE: this is mpd specific, since it no-likey abs paths.
        # FIXME: I *should* be querying the mpd database directly, but there's 2 problems I need to
        # solve there:
        # 1. The query only gives back files (individual tracks). I want to support adding full albums
        # to the queue.
        # 2. The DB includes every file format for every track, so I'd have to do some post filtering to
        # find the best quality ones (rather than this way, where it's included in the index)
        path = index[name]["highest_quality_path_rel"]
        if not path:
            print(f"not found in index: {selection}")

        # Whatever music player I'm currently favoring
        # NOTE: this uses cwd for the same reason outlined above w.r.t. mpd
        subprocess.run(["mpc", "add", path], cwd=music_base)
        subprocess.run(["mpc", "play"])
        cover_img = index[name]["cover_path"]

    notif = ["notify-send"]
    if cover_img:
        notif += ["-i", cover_img, "--transient"]
    notif += ["-a", "Music", "ADDED TO QUEUE", f"{name}"]

    subprocess.run(notif)
    exit(0)

indexed_items = [meta["rofi_str"] for _, meta in index.items()]
indexed_items.insert(0, f"Eurydice: Random 3 Albums\0icon\x1fthumbnail://{music_base}/eurydice.png")
indexed_items.insert(0, f"Eurydice: Random Album\0icon\x1fthumbnail://{music_base}/eurydice.png")
indexed_items.insert(0, f"Eurydice: Random Mixtape (3 Hours)\0icon\x1fthumbnail://{music_base}/eurydice.png")
indexed_items.insert(0, f"Eurydice: Random Mixtape (1 Hour)\0icon\x1fthumbnail://{music_base}/eurydice.png")
print("\n".join(indexed_items))
