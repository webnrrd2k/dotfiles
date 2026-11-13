# dotfiles

My bash configuration and personal scripts for Fedora.

## Layout

Each top-level folder mirrors `$HOME`:

| Folder | Installs to |
|---|---|
| `bash/.bashrc` | `~/.bashrc` |
| `bash/.bashrc.d/*.bash` | `~/.bashrc.d/` (sourced by `.bashrc`) |
| `bin/.local/bin/*` | `~/.local/bin/` |

## Install

```bash
git clone https://github.com/webnrrd2k/dotfiles.git ~/Documents/projects/webnrrd2k/dotfiles
~/Documents/projects/webnrrd2k/dotfiles/install.sh
```

`install.sh` symlinks each file into place, one by one. Anything already there
is renamed to `NAME.bak` first. Because files are linked individually, untracked
files in `~/.bashrc.d` and `~/.local/bin` (pip/uv shims, TinyTeX links, etc.)
are left alone. Edit the files in place as usual; the edits land in this repo.

## Secrets

API keys and other machine-local settings go in `~/.bashrc.d/*.local.bash`.
`.bashrc` sources them like any other file, and `.gitignore` keeps them out
of the repo.

## Scripts

| Script | What it does |
|---|---|
| `note` | Tiny command-line note taker |
| `google2org` | Convert text copied from Google results into org-mode |
| `mdfm` | Markdown helper |
| `dirname-clean` | Clean text into a filesystem-friendly folder name |
| `rotate`, `pre.py`, `post.py`, `before.py`, `sandr.py` | Small text and filename utilities |

The Nautilus folder stack (`fstack`, `npush`, …) lives in its own repo:
[nautilus-folder-stack](https://github.com/webnrrd2k/nautilus-folder-stack).
