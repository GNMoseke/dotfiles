#! /home/garrett/.local/bin/music/bin/python
import os
import glob
import tinytag
import json
import pathlib

'''
to make sure this is set up correctly (I know a venv in local bin is smelly but idc):
cd ~/.local/bin
python -m venv music
./music/bin/pip install tinytag
for dev:
. music/bin/activate.fish

see docs: https://davatorium.github.io/rofi/current/rofi-script.5/

This works very specifically with **my** music organization strategy, which supports both flat
directories with one file type or nested file type subdirs per album:

$ ls --tree
'01 - Albums'
├── 'Beast In Black - Berserker'
│   ├── FLAC
│   │   ├── 'Beast In Black - Berserker - 01 Beast In Black.flac'
│   │   ├── ...
│   │   └── cover.jpg
│   └── MP3
│       ├── 'Beast In Black - Berserker - 01 Beast In Black.mp3'
│       ├── ...
│       └── cover.jpg
├── 'Bones UK - Bones UK'
│   ├── 'Bones UK - Bones UK - 01 Beautiful Is Boring.flac'
│   ├── ...
│   └── cover.jpg
'02 - Soundtracks'
├── ... Same as Albums ...
'03 - Lofi'
├── ... Same as Albums ...
'04 - Singles'
├── 'Des Rocks - Let Me Live Let Me Die'
│   ├── cover.jpg
│   └── 'Des Rocs - Let Me Live Let Me Die.mp3'
└── 'MattStaghram - Petty'
    ├── FLAC
    │   └── 'MattstaGrahm- Petty.flac'
    ├── MP3
    │   └── 'MattstaGrahm- Petty.mp3'
    └── cover.jpg
'''

# NOTE: specifically avoiding os.walk() here since I want to selectively recurse
music_base = f"{pathlib.Path.home()}/Music/"

options = {}
for entry in os.listdir(music_base):
    top_path = os.path.join(music_base, entry)
    if not os.path.isdir(top_path): continue
    if entry == "zUncategorized" or entry == "05 - Podcasts" or entry == "06 - D&D Ambiance": continue

    for album in os.listdir(top_path):
        album_path = os.path.join(top_path, album)

        # add album itself
        cover_imgs = glob.glob("**/cover.png", root_dir=album_path, recursive=True) + glob.glob("**/cover.jpg", root_dir=album_path, recursive=True)
        cover_img = None
        if cover_imgs:
            cover_img = os.path.join(album_path, cover_imgs[0])

        if entry != "04 - Singles":
            key = f'ALBUM: {album_path.split('/')[-1]}'
            qualities = [dir for dir in os.listdir(album_path) if os.path.isdir(os.path.join(album_path, dir))]
            best_path = album_path
            found_best = False
            # FIXME: this is quite a heavy handed loop that can be significantly cleaned up when I'm
            # feeling less lazy
            for quality in qualities:
                if quality.lower() == "flac":
                    best_path = os.path.join(album_path, quality)
                    break
                elif quality.lower() == "wav":
                    best_path = os.path.join(album_path, quality)
                    found_best = True
                elif quality.lower() == "mp3" and not found_best:
                    best_path = os.path.join(album_path, quality)
                    found_best = True
                elif quality.lower() == "opus" and not found_best:
                    best_path = os.path.join(album_path, quality)
                else:
                    print(f"couldn't index quality for {album_path}, found {qualities} but none match")
                
            album_rofi_str = f'{key}\0icon\x1fthumbnail://{cover_img}'
            if key not in options:
                options[key] = {
                    "type": "album",
                    "rofi_str": album_rofi_str,
                    "path": best_path,
                    "cover_path": cover_img
                }

        highest_quality_paths = []
        for ext in ['flac', 'wav', 'mp3', 'opus']:
            tracks = glob.glob(f"**/*.{ext}", root_dir=album_path, recursive=True)
            if tracks:
                highest_quality_paths = tracks
                break

        for track_path in highest_quality_paths:
            filepath = os.path.join(album_path, track_path)
            tag = tinytag.TinyTag.get(filepath)
            key = "TRACK: "
            if tag.artist != None:
                key += f"{tag.artist} - "
            if tag.album != None:
                key += f"{tag.album} - "
            if tag.title != None:
                key += f"{tag.title}"

            track_rofi_str = f"{key}\0icon\x1fthumbnail://{cover_img}"
            if key not in options:
                options[key] = {
                    "type": "track",
                    "rofi_str": track_rofi_str,
                    "path": filepath,
                    "cover_path": cover_img
                }

with open(f"{music_base}.rofi-index.json", 'w') as f:
    json.dump(options, f)
