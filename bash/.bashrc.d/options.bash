# Turn the prompt symbol red if the user is root
if [ $(id -u) -eq 0 ];
then # you are root, make the prompt red
	PROMPT_COLOR='31;53'
	#PS1="\[\e[01;31m\]$PS1\[\e[00m\]"
fi

#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi
