# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
source $HOME/.bash/.gcloudrc
source $HOME/.bash/.tmux_completion.sh

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ ( \1)/'
}

tg()
{
  git_dir=$(dirname $(upfind .git))
  if [[ ! -z $git_dir ]]; then
    cd $git_dir
  fi
}

if [ "$color_prompt" = yes ]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[35m\]$(parse_git_branch)\[\033[00m\]\$\n'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias sus='systemctl suspend'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$PATH:/home/mate/nodejs/bin:/home/mate/Scripts:/usr/lib/jvm/jdk-17/bin:/opt/apache-maven-3.8.6/bin:/opt/weylus:/opt:/$HOME/.config/polybar
export JAVA_HOME=/usr/lib/jvm/jdk-17
export NVIM=$HOME/.config/nvim/lua/endoxide/
export PYTHON_HOME=$HOME/Atom/Python/
export DB_HOME=$HOME/uni/part1a/ticks/databases/movies-relational/
export BG="$HOME/Pictures/Wallpapers/ashenPyke.jpg"
export UNI_HOME="$HOME/uni/"
export UNI_YEAR="part2"
export AOC="/home/mate/Atom/C/C++/AdventCalender"
export PERSONAL_TEX="$UNI_HOME/$UNI_YEAR/supervisions/Personal/personal.tex"
export I3_HOME=$HOME/.config/i3/
export POLYBAR_HOME=$HOME/.config/polybar/
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

. "$HOME/.cargo/env"

alias e="exit"
alias c="clear"
alias nh="cd $NVIM"
alias i3h="cd $I3_HOME"
alias polyh="cd $POLYBAR_HOME"
alias ph="cd $PYTHON_HOME"
alias dbh="cd $DB_HOME"
alias mvnc="mvn archetype:generate -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4"
alias aoc="cd $AOC"
alias g++="g++ -std=c++2a"
alias pythonenv="source $GLOBAL_PYTHON_VENV/bin/activate"
alias pls="ps aux | grep $1"
alias uni="cd $UNI_HOME/$UNI_YEAR"

bind '"\e[1;5D" backward-word' 
bind '"\e[1;5C" forward-word'

t() { cd $UNI_HOME/$UNI_YEAR/ticks/$1; }
s() { 
  if [[ ! -z $2 ]] ; then
    cd $UNI_HOME/$UNI_YEAR/supervisions/$1/$1_$2;
  else
    cd $UNI_HOME/$UNI_YEAR/supervisions/$1;
  fi
}
p() { cd $UNI_HOME/$UNI_YEAR/practicals/$1; }

# ---- Eza (better ls) ----
alias ls="eza --color=always --git --icons=always"

function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.venv ]] ; then
        source ./.venv/bin/activate

      elif [[ -d ./venv ]] ; then
        source ./venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi

  ls
}

function mkcd() {
  mkdir $1 && cd $_
}

# ----- FZF -----
#
# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ---- fzf git ---
source ~/util/fzf-git.sh/fzf-git.sh

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- Unbind bash keymaps for movement -----
bind -r "\C-l"
bind -r "\C-r"
bind -r "\C-j"
bind -r "\C-k"

# ---- Attach to or make default tmux sessiond -----
source $HOME/.bash/.tmux_init.sh
