# ~/.bashrc: executed by bash(1) for non-login shells.
# 1337 H4X0R EDITION - [secure@root:~$]

# If not running interactively, don't do anything
if [[ $- != *i* || ! -t 1 ]]; then
    return
fi

BLACK='\[\e[1;30m\]'
DARK_BLUE='\[\e[1;34m\]'
CYAN='\[\e[1;36m\]'
RESET='\[\e[0m\]'

PS1="${BLACK}black${DARK_BLUE}arch ${CYAN}-> ${RESET}"

# ========== ORIGINAL CONFIGURATION ========== #
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command
shopt -s checkwinsize

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ========== ENHANCED ALIASES ========== #
# Original aliases
alias ll='ls -alF'
alias la='ls -A'
alias lh='echo -e "File name\t\tFile size" && ls -lah | grep "^-" | awk '\''{printf "%-24s %s\n", $9, $5}'\'''
alias l='ls -CF'
alias c='clear'
alias dev='npm run dev'
alias start='npm run start'
alias setup='npm run setup'
alias dotc='code .'
alias dmip='ip addr show | grep -w inet'
alias sqlmap-dev='python3 /home/yyax/htool/sqlmap-dev/sqlmap.py'
alias proxyon='export http_proxy=http://127.0.0.1:8080; export https_proxy=http://127.0.0.1:8080; export ftp_proxy=http://127.0.0.1:8080; export no_proxy="localhost,127.0.0.1,::1"'
alias proxyoff='unset http_proxy; unset https_proxy; unset ftp_proxy; unset no_proxy'
alias dns10='journalctl -u systemd-resolved --no-pager --since "1 hour ago" | grep -E "Looking up|Positive response for" | grep -oE "[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" | grep -v "127.0.0.1\|localhost" | tail -10 | sort -u'
alias sites10='journalctl -u systemd-resolved --no-pager --since "2 hours ago" | grep -E "Looking up|query" | grep -oE "[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" | grep -vE "^(127\.|192\.168\.|10\.|172\.|localhost)" | sort | uniq -c | sort -nr | head -10'
alias ultimossites='journalctl -u systemd-resolved --no-pager --since "1 hour ago" | grep -oE "[a-zA-Z0-9.-]+\.[a-zA-Z]{2,10}" | grep -vE "^(127|192\.168|10\.|172\.|localhost|pop-os)" | tail -10 | sort -u'

# Safety measures
set -o noclobber        # prevent overwriting files
set -o ignoreeof        # prevent accidental logouts

# ========== ORIGINAL COMPLETION ========== #
# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Go path
export PATH=/usr/local/go/bin:$PATH
export PATH="$HOME/go/bin:$PATH"