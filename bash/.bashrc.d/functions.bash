#
#   mkcd command
#   This is an improvised version of the mkcd command at http://superuser.com/questions/152794/is-there-a-shortcut-to-mkdir-foo-and-immediately-cd-into-it
#   This function has to be added to the ~/.bashrc file
#   After that you can run command like: mkdir abc, mkdir -p one/two/three
#

function ask_code() {
    local file=$1
    local prompt=$2
    if [ ! -f "$file" ]; then
        echo "Error: File $file not found."
        return 1
    fi
    echo -e "Analyzing $file...\n"
    (echo "Context file: $file"; echo "---"; cat "$file"; echo "---"; echo "$prompt") | ollama run deepseek-coder-v2
}

function mkcd {
  last=$(eval "echo \$$#")
  if [ ! -n "$last" ]; then
    echo "Enter a directory name"
  elif [ -d $last ]; then
    echo "\`$last' already exists"
  else
    mkdir $@ && cd $last
  fi
}

function kt {
  tracker_pid="$(ps -aux | g tracker | g -v grep | col2)"
  if [ -n "$tracker_pid" ] 
  then
    echo "kill -9 $tracker_pid"
    kill -9 $tracker_pid  
  else
    echo "tracker pid not found"
  fi
}

function fix_quotes {
    for file in *; do
      if [[ -f "$file" ]]; then
        new_name="${file//＂/\"}"
        if [[ "$file" != "$new_name" ]]; then
          mv -- "$file" "$new_name"
        fi
      fi
    done
}

# From https://askubuntu.com/questions/22413/how-to-change-gnome-terminal-title
termtitle() { 
  printf "\033]0;$*\007"; 
}

#remount-lacie() {
#  umount /dev/sda1
#  mount -o rw /dev/sda1 /home/jeff/mnt-usb/
#}

genpw() {
  alphanum=( {a..z} {A..Z} {0..9} ); for((i=0;i<=${#alphanum[@]};i++));
  do printf '%s' "${alphanum[@]:$((RANDOM%255)):1}"; 
  done; echo
}

randpwd() {
  tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 13  ; echo
}

# From https://github.com/junegunn/fzf/wiki/examples
cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

# From https://www.baeldung.com/linux/repeat-command
function repeat(){
  for ((i=0;i<$1;i++)); do
    eval ${*:2}
  done
}

# youtube-dl alias
# The following are from: https://askubuntu.com/questions/178481/how-to-download-an-mp3-track-from-a-youtube-video
yt-mp3 () {
    # youtube-dl --ignore-errors -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s' "$1"
    youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s" --yes-playlist  "$1" 
}

yt-mp3p () {
    youtube-dl --ignore-errors --sleep-interval 30 -i -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "$1"
}

yt-dlv () {
    youtube-dl --ignore-errors -o '%(title)s.%(ext)s' "$1"
}

wg-mirror () {
  wget  --mirror --convert-links --html-extension --wait=2 -o log $1 
}

listdirs(){ 
    set -- */; printf "%s\n" "${@%/}"; 
}

c2mp3 () {
    for FILE in *.webm; do
        echo -e "Processing video '\e[32m$FILE\e[0m'";
        ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.webm}.mp3";
        rm "${FILE}"
    done;

    for FILE in *.mkv; do
        echo -e "Processing video '\e[32m$FILE\e[0m'";
        ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.mkv}.mp3";
        rm "${FILE}"
    done;

    for FILE in *.mp4; do
        echo -e "Processing video '\e[32m$FILE\e[0m'";
        ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.mp4}.mp3";
        rm "${FILE}"
    done

    for FILE in *.aac; do
        echo -e "Processing video '\e[32m$FILE\e[0m'";
        ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.aac}.mp3";
        rm "${FILE}"
    done

    for FILE in *.wma; do
        echo -e "Processing video '\e[32m$FILE\e[0m'";
        ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.wma}.mp3";
        rm "${FILE}"
    done

    for FILE in *.m4a; do
        echo -e "Processing video '\e[32m$FILE\e[0m'";
#       ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.m4a}.mp3";
        ffmpeg -i "${FILE}" -c:v copy -c:a libmp3lame -q:a 4 "${FILE%.m4a}.mp3";nn
        rm "${FILE}"
    done
    #    echo "# rm *.webm; rm *.mkv; rm *.mp4"
    echo "DONE"
} 

function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

#function col_n() {
#    awk '{print $1}'
#}

function ccol() { awk -- "{print \$$1}"; }


# Source - https://superuser.com/a
# Posted by CervEd, modified by community. See post 'Timeline' for change history
# Retrieved 2025-12-30, License - CC BY-SA 4.0

function pdf2md () {
    pdftohtml -s -stdout "${@}" |
    pandoc -f html -t markdown -o "${1%.pdf}".md ;
}

# tat: tmux attach
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# Old version
#function upd() {
#    # === DNF ===
#    if command -v dnf &> /dev/null; then
#      sudo dnf upgrade --refresh -y
#      sudo dnf autoremove -y
#    fi
#
#    # === YUM ===
#    if command -v yum &> /dev/null; then
#      sudo yum update -y
#    fi
#
#    # === Flatpak ===
#    if command -v flatpak &> /dev/null; then
#      flatpak update -y
#    fi
#}
upd ()
{
    if command -v dnf &> /dev/null; then
        sudo dnf upgrade --refresh -y
        sudo dnf autoremove        # prompts before removing anything
        sudo dnf needs-restarting -r
    elif command -v yum &> /dev/null; then
        sudo yum update -y
    fi

    if command -v flatpak &> /dev/null; then
        flatpak update -y
        flatpak uninstall --unused -y
    fi
}

