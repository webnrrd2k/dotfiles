#!/usr/bin/env bash
# Symlink every file in this repo's packages (bash/, bin/) into $HOME.
# Files are linked one at a time, so untracked files in ~/.bashrc.d or
# ~/.local/bin are left alone. An existing real file is moved to NAME.bak.
#
# Then optionally download and build cn (github.com/webnrrd2k/clean_dir_name)
# with cargo. It asks when run from a terminal; --with-cn or --no-cn answers
# ahead of time.
set -euo pipefail
repo=$(cd "$(dirname "$0")" && pwd)

want_cn=ask
case "${1:-}" in
    --with-cn) want_cn=yes ;;
    --no-cn)   want_cn=no ;;
    "")        ;;
    *) echo "usage: $0 [--with-cn | --no-cn]" >&2; exit 2 ;;
esac

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

if [ "$want_cn" = ask ]; then
    want_cn=no
    if [ -t 0 ]; then
        read -rp "Download and build cn (clean_dir_name) with cargo? [y/N] " answer
        case "$answer" in [yY]*) want_cn=yes ;; esac
    fi
fi

if [ "$want_cn" = yes ]; then
    if ! command -v cargo >/dev/null; then
        echo "cargo not found; install it with 'sudo dnf install cargo' and rerun with --with-cn" >&2
        exit 1
    fi
    # --root ~/.local puts cn in ~/.local/bin (cargo also keeps its
    # .crates.toml / .crates2.json bookkeeping in ~/.local).
    if ! cargo install --list --root "$HOME/.local" | grep -q '^clean_dir_name '; then
        # cargo won't overwrite a cn it didn't install, so set any such file aside.
        old="$HOME/.local/bin/cn"
        if [ -e "$old" ] || [ -L "$old" ]; then mv "$old" "$old.bak"; echo "backed up $old -> $old.bak"; fi
    fi
    cargo install --root "$HOME/.local" --git https://github.com/webnrrd2k/clean_dir_name
fi
