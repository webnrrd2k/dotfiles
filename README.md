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

On a new machine:

```bash
sudo dnf install git     # if it's missing
git clone https://github.com/webnrrd2k/dotfiles.git ~/Documents/projects/webnrrd2k/dotfiles
~/Documents/projects/webnrrd2k/dotfiles/install.sh
source ~/.bashrc         # or open a new terminal
```

Then copy the `~/.bashrc.d/*.local.bash` files over from the old machine by
hand (see [Secrets](#secrets)), for example:

```bash
scp oldlaptop:~/.bashrc.d/*.local.bash ~/.bashrc.d/
```

`install.sh` symlinks each file into place, one by one. Anything already there
is renamed to `NAME.bak` first. Because files are linked individually, untracked
files in `~/.bashrc.d` and `~/.local/bin` (pip/uv shims, TinyTeX links, etc.)
are left alone. Edit the files in place as usual; the edits land in this repo.

The installed files are links into the clone, so keep the clone where it is.
If you move it, run `install.sh` again from the new location.

### cn

At the end, `install.sh` asks whether to download and build `cn`, the Rust
version of `dirname-clean`, from
[clean_dir_name](https://github.com/webnrrd2k/clean_dir_name). It needs cargo
(`sudo dnf install cargo`) and installs to `~/.local/bin`. Pass `--with-cn` or
`--no-cn` to skip the question.

### Updating

Run `git pull` in the clone. Changes to existing files take effect right away.
If the pull adds new files, run `install.sh` again to link them; files that are
already linked are skipped.

Cloning needs no login, but pushing from a new machine does: run
`gh auth login` or set up an SSH key first.

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
| `dirname-clean` | Clean text into a filesystem-friendly folder name (`cn` is the Rust version; see [cn](#cn)) |
| `rotate`, `pre.py`, `post.py`, `before.py`, `sandr.py` | Small text and filename utilities |

The Nautilus folder stack (`fstack`, `npush`, …) lives in its own repo:
[nautilus-folder-stack](https://github.com/webnrrd2k/nautilus-folder-stack).
