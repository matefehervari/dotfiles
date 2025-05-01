# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HOME="/home/mate"

if [ -f $HOME/.bash/.gcloudrc ]; then
  source $HOME/.bash/.gcloudrc
fi
if [ -f $HOME/.bash/.tmux_completion ]; then
  source $HOME/.bash/.tmux_completion.sh
fi
if [ -f $HOME/.bash/.custom_completions ]; then
  source $HOME/.bash/.custom_completions
fi

# ----- Terminal History Setup -----

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

# -------------------------

# ----- Friendly pipe -----

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -------------------------------

# ----- Command line status -----

source $HOME/.bash/ps1.bash

# -------------------

# ----- Aliases -----

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
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

# -----------------------------


# ----- Programmable completion -----

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

# -----------------------------------

# ----- Environment Variables -----

PATHS=(
  "$PATH"
  "/home/mate/nodejs/bin"
  "/home/mate/Scripts"
  "/usr/lib/jvm/jdk-17/bin"
  "/opt/apache-maven-3.8.6/bin"
  "/opt/weylus"
  "/opt"
  "$HOME/.config/polybar"
  "/opt/bsc-2024.07-ubuntu-22.04/bin"
  "/opt/bdw/bin"
  "$HOME/uni/latex-util/"
  "$HOME/util/i3-battery-popup"
  "$HOME/.cargo/bin"
  "/usr/local/go/bin/"
  "/opt/riscv/bin"
  "/home/mate/util/riscv/bin/"
)
# export PATH="$PATH:/home/mate/nodejs/bin:/home/mate/Scripts:/usr/lib/jvm/jdk-17/bin:/opt/apache-maven-3.8.6/bin:/opt/weylus:/opt:$HOME/.config/polybar:/opt/bsc-2024.07-ubuntu-22.04/bin"
export PATH=$(IFS=: ; echo "${PATHS[*]}")
export JAVA_HOME=/usr/lib/jvm/jdk-17
export NVIM=$HOME/.config/nvim/lua/endoxide/
export PYTHON_HOME=$HOME/Atom/Python/
export DB_HOME=$HOME/uni/part1a/ticks/databases/movies-relational/
export BG="$HOME/Pictures/Wallpapers/ashenPyke.jpg"
export UNI_HOME="$HOME/uni"
export UNI_YEAR="part2"
export SUPO_HOME="$UNI_HOME/latex-util"
export AOC="/home/mate/Atom/C/C++/AdventCalender"
export PERSONAL_TEX="$UNI_HOME/$UNI_YEAR/supervisions/Personal/personal.tex"
export I3_HOME=$HOME/.config/i3/
export POLYBAR_HOME=$HOME/.config/polybar/
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export TEXINPUT=".:$SUPO_HOME:$TEXINPUTS"
export BLUESPECDIR="/opt/bsc-2024.07-ubuntu-22.04/lib/" # used for building diss
export VIRTUAL_ENV_DISABLE_PROMPT=1
export RISCV="/home/mate/util/riscv/"

# ---------------------------------

# ----- Alias definitions -----

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $HOME/.bash/.bash_aliases ]; then
    source $HOME/.bash/.bash_aliases
fi

# -----------------------------

# ----- Cargo -----

if [ -f $HOME/.cargo/env ]; then
  . $HOME/.cargo/env
fi

# -----------------

# ----- Fix arrow keys in tmux -----

bind '"\e[1;5D" backward-word' 
bind '"\e[1;5C" forward-word'

# ----------------------------------

# ----- Uni shortcuts -----

t() { cd $UNI_HOME/$UNI_YEAR/ticks/$1; }
s() { 
  if [[ ! -z $2 ]] ; then
    cd $UNI_HOME/$UNI_YEAR/supervisions/$1/$1_$2;
  else
    cd $UNI_HOME/$UNI_YEAR/supervisions/$1;
  fi
}
p() { cd $UNI_HOME/$UNI_YEAR/practicals/$1; }
d() { cd $UNI_HOME/$UNI_YEAR/dissertation/$1; }

# -------------------------

# ---- Eza (better ls) ----

alias ls="eza --color=always --git --icons=always"

# -------------------------

# ----- cd venv activation -----

function handle_venv() {
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
}

function cd() {
  builtin cd "$@"
  handle_venv
}

# ------------------------------

function mkcd() {
  mkdir $1 && cd $_
}

# ----- FZF -----
#
# Set up fzf key bindings and fuzzy completion
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

# Use fd instead of fzf

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
source $HOME/util/fzf-git.sh/fzf-git.sh

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- Unbind bash keymaps for movement -----
bind -r "\C-l"
bind -r "\C-r"
bind -r "\C-j"
bind -r "\C-k"

# ---- Attach to or make default tmux sessiond ----- !!KEEP LAST
source $HOME/.bash/.tmux_init.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/home/mate/.ghcup/env" ] && . "/home/mate/.ghcup/env" # ghcup-env