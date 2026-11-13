#!/usr/bin/env bash
# Symlink every file in this repo's packages (bash/, bin/) into $HOME.
# Files are linked one at a time, so untracked files in ~/.bashrc.d or
# ~/.local/bin are left alone. An existing real file is moved to NAME.bak.
set -euo pipefail
repo=$(cd "$(dirname "$0")" && pwd)
for pkg in bash bin; do
    (cd "$repo/$pkg" && find . -type f) | while read -r rel; do
        rel=${rel#./}
        src="$repo/$pkg/$rel" dst="$HOME/$rel"
        mkdir -p "$(dirname "$dst")"
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then continue; fi
        if [ -e "$dst" ] || [ -L "$dst" ]; then mv "$dst" "$dst.bak"; echo "backed up $dst -> $dst.bak"; fi
        ln -s "$src" "$dst" && echo "linked $dst"
    done
done
