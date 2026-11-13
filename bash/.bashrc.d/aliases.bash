# alias dirs='for i in $(ls -d */); do echo ${i}; done'
# alias dirs='ls -d */'
# alias ll='ls -alhF'
# alias mc='. /usr/libexec/mc/mc-wrapper.sh'
# Print my public IP
# Recursivly removes subdirectories, dotfiles, *everything* 
# So I don't need to remember the options to tar every time
#alias lsd='echo ./*/'

############ Test area for aliases ################
# Working on a "kill tracker process" alias. 
#    First get the pid...
# alias kt="echo 'packagekitd';ps -aux | g libexec | g packagekitd | col2;"
#    ... then pass it to kill -9?
# kill -9 tracker-pid
############ End test area for aliases ############

alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

alias cb1='xclip -selection a'
alias cb2='xclip -selection b'
alias cb3='xclip -selection c'
alias cl='clear'

# Clean Control Characters from bash
alias ccc='sed -E "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})*)?[m,K,H,f,J]//g"'

# Also use ccol in functions.bash
alias col1='awk -- "{print \$1}"'
alias col2='awk -- "{print \$2}"'
alias col3='awk -- "{print \$3}"'
alias col4='awk -- "{print \$4}"'
alias col5='awk -- "{print \$5}"'
alias col6='awk -- "{print \$6}"'
alias col7='awk -- "{print \$7}"'
alias col8='awk -- "{print \$8}"'
alias col9='awk -- "{print \$9}"'

# alias dirs='for i in $(ls -d */); do echo ${i%%/}; done'


alias clnstr='sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g"'

# *RECURSIVELY* Delete Empty Directories - this directory and below
alias ded='find . -type d -empty -delete'

alias dirs='ls -1 -d */'
alias dlyt="yt-dlp -f 'ba' -x --audio-format mp3 "

##
alias exts="find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -rn"
# alias exts="find . -type f | awk -F. '!a[\$NF]++{print \$NF}' | sort"
##

alias frm="find . -name '*.webm' -o -name '*.mkv' -o -name '*.mp4' -o -name '*.aac'"

# Find Duplicate Files (based on size first, then MD5 hash) - This dup finder saves time by comparing size first, then md5sum, it doesn't delete anything, just lists them.
alias find_dups='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'

alias f='find . | g $1'
alias ff='find -type f'

alias g='grep -i'
# alias gen_password="LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 16; echo"
alias gen_password="LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*()_+' < /dev/urandom | head -c 20; echo"
alias make_random_password="openssl rand -base64 24 | head -c 16; echo"

alias h='history'

alias init_idf='. $HOME/esp/esp-idf/export.sh'

alias line_count="ls 2>/dev/null -Ubad1 -- *.* | wc -l"
alias line_count_2="shopt -s nullglob; files=(*.*); echo ${#files[@]};"


#alias ls='ls --color'
#alias lsn='ls -1vh'
##alias lt='ls --human-readable --size -1 -S --classify'
#alias lt='ls -lht'

# Just trying this out for a while...
#alias ls='eza'
#alias ll='eza -la --git'
# Core replacements - Ensure colors and group folders together first
alias la='ls -lAh'
alias lsl='ls -lah'
alias ls='ls --color=auto --group-directories-first'
alias lsr='ls -rt'

# Specialized views
alias l.='ls -d .*'                  # Show only hidden files and dotfiles
alias lsz='ls -lh -S'                 # Sort by file size (largest first)
alias ltr='ls -lh -tr'               # Sort by modification time (reverse/newest at bottom)
alias ld='ls -d */'                  # Show only directories, skip files

alias mirror_website0='wget --wait=5 --random-wait --mirror --convert-links --adjust-extension --page-requisites --no-parent $1'
alias mirror_website1='wget --mirror --convert-links --adjust-extension --wait=5 --random-wait $1'
alias mktar='tar -czvf'
alias mpdf="magick *.jpg -auto-orient output.pdf"
alias myip='curl ipinfo.io/ip;echo'
alias nukedir='find . -name . -o -prune -exec rm -rf -- {} +'
alias pandoc_math="pandoc parallel-rc-solutions.md -s -o parallel-rc-solutions.pdf --pdf-engine=xelatex -V mainfont='DejaVu Sans' -V mathfont='Latin Modern Math'"
alias p3='python3'

# Used by tmux config
alias pbcopy='wl-copy' # For Wayland users
# OR alias pbcopy='xclip -selection clipboard' # For X11 or if wl-clipboard isn't preferred
alias pbpaste='wl-paste' # For Wayland users
# OR alias pbpaste='xclip -selection clipboard -o' # For X11

alias p='python'

alias q='exit'

alias rga='rga -i -n -U'
alias rmall='find . -name . -o -prune -exec rm -rf -- {} +'
alias rmdirs='rm -r */'												## Remove all directory (recursive), leaving files

alias rmm="rm *.webm; rm *.mkv; rm *.mp4;"
alias rs="rsync -avhP --ignore-existing "
alias rss="rsync -hvrPt "
alias set_anthropic_api_key='ANTHROPIC_API_KEY=$(cat ~/.config/booksort/api_key)'
alias s2sc="sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr -s ' ' '_' | tr -s '&' '+' | tr '[:upper:]' '[:lower:]'"
alias u2l='tr [:upper:] [:lower:]'
alias untar='tar -xzvf'
alias updatedb="systemctl start plocate-updatedb.service"
alias va='source ./venv/bin/activate'
alias ve='python3 -m venv ./venv'

alias x='xsel -b'
alias x1='xsel -b'
alias x1c='xsel --clipboard --clear'

alias xc='xsel --clipboard'
alias xp='xsel --primary'
alias xs='xsel --secondary'

alias x2='xsel --clipboard'
alias x3='xsel --primary'
alias x4='xsel --secondary'

alias yt-dl='yt-dlp --download-archive download-archive.txt -o "%(title)s.%(ext)s"'
alias yt-dlpa='yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --download-archive download-archive.txt --add-metadata --parse-metadata "playlist_index:%(track_number)s" -o "%(artist)s - %(title)s.%(ext)s"'
#alias yt-dlpa='yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --download-archive download-archive.txt --add-metadata --parse-metadata "playlist_index:%(playlist_index)s" -o "%(artist)s - %(title)s.%(ext)s"'
alias yt-dlpl="yt-dlp --force-write-archive -s --download-archive download-archive.txt"
alias yt-dlmix='yt-dlp -I 1:50  --download-archive download-archive.txt --yes-playlist -x --audio-format mp3 -o "%(playlist_title)s/%(playlist_index)03d - %(artist)s - %(title)s.%(ext)s" "$1"'
alias yt-ppl='yt-dlp --flat-playlist --print title $1'

# =================================================
# OLD ALIASES
# alias cl='clear'
# # alias dirs='ls -d */'
# # alias dirs='for i in $(ls -d */); do echo ${i%%/}; done'
# # alias dirs='for i in $(ls -d */); do echo ${i}; done'
# alias dirs='ls -1 -d */'
# alias lsd='echo */'
# #alias lsd='echo ./*/'
# # alias ll='ls -alhF'

# # Find Duplicate Files (based on size first, then MD5 hash) - This dup finder saves time by comparing size first, then md5sum, it doesn't delete anything, just lists them.
# alias find_dups='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'
# alias g='grep -i'
# alias ls='ls --color'
# alias lsl='ls -lah
# alias lt='ls --human-readable --size -1 -S --classify'

# # alias mc='. /usr/libexec/mc/mc-wrapper.sh'
# # So I don't need to remember the options to tar every time
# alias mktar='tar -czvf'
# alias untar='tar -xzvf'
# alias p='python'
# alias p3='python3'
# alias u2l='tr [:upper:] [:lower:]'
# alias ve='python3 -m venv ./venv'
# alias va='source ./venv/bin/activate'

# alias ss2usb="rsync -rcP /home/jeff/Documents/school/ /run/media/jeff/usb-disk/school/"

# alias q='exit'
# # Recursivly removes subdirectories, dotfiles, *everything* 
# alias rmall='find . -name . -o -prune -exec rm -rf -- {} +'
# alias h='history'
# alias x='xsel -b'
# alias g='grep -i'


# alias init_idf='. $HOME/esp/esp-idf/export.sh'

# alias dlyt="yt-dlp -f 'ba' -x --audio-format mp3 "

# # Print my public IP
# alias myip='curl ipinfo.io/ip'
# alias updatedb="systemctl start plocate-updatedb.service"

# alias line_count="ls 2>/dev/null -Ubad1 -- *.* | wc -l"
# alias line_count_2="shopt -s nullglob; files=(*.*); echo ${#files[@]};"
# alias rmm="rm *.webm; rm *.mkv; rm *.mp4;"

# alias col1='awk "{print $1}'
# alias col2='awk "{print $2}'
# alias col3='awk "{print $3}'
# alias col4='awk "{print $4}'
# alias col5='awk "{print $5}'
# alias col6='awk "{print $6}'
# alias col7='awk "{print $7}'
# alias col8='awk "{print $8}'
# alias col9='awk "{print $9}'
# ========================================================

# Bash shell settings
# Typing a directory name just by itself will automatically change into that directory.
shopt -s autocd

# Automatically fix directory name typos when changing directory.
shopt -s cdspell

# Automatically expand directory globs and fix directory name typos whilst completing. 
# Note, this works in conjuction with the cdspell option listed above.
shopt -s direxpand dirspell

# Enable the ** globstar recursive pattern in file and directory expansions.
# For example, ls **/*.txt will list all text files in the current directory hierarchy.
shopt -s globstar

# Ignore lines which begin with a <space> and match previous entries.
# Erase duplicate entries in history file.
# HISTCONTROL=ignoreboth:erasedups

# Ignore saving short- and other listed commands to the history file.
# HISTIGNORE=?:??:history

# From https://superuser.com/questions/232885/can-you-share-wisdom-on-using-histignore-in-bash
# suppress anything as you wish by adding a space at the front of the command:
# HISTIGNORE="[ \t]*"

# The maximum number of lines in the history file.
HISTFILESIZE=99999

# The number of entries to save in the history file.
HISTSIZE=99999

# Set Bash to save each command to history, right after it has been executed.
PROMPT_COMMAND='history -a'

# Save multi-line commands in one history entry.
shopt -s cmdhist

# Append commands to the history file, instead of overwriting it.
# History substitution are not immediately passed to the shell parser.
shopt -s histappend histverify
