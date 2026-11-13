# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
. "/home/jeff/.deno/env"
source /home/jeff/.local/share/bash-completion/completions/deno.bash

if [ "$USER" == "root" ]; then
    # Change background to dark red for root user
    printf "\e]11;#440000\e\\"
elif [ "$USER" == "claudeuser" ]; then
    # Change background to dark blue for specific user
    printf "\e]11;#000044\e\\"
fi

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/jeff/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/jeff/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jeff/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jeff/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jeff/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jeff/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/.config/emacs/bin:$PATH"

# Nautilus folder stack from bash
[ -f ~/.local/share/nautilus-folder-stack/fstack.bash ] && . ~/.local/share/nautilus-folder-stack/fstack.bash
