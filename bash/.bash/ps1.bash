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
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}


fg_term() {
    local id=$1
    echo "\e[38;5;${id}m\]"
}

bg_term() {
    local id=$1
    echo "\e[48;5;${id}m\]"
}

rgb_fg() {
    local r=$1
    local g=$2
    local b=$3
    echo "\e[38;2;$r;$g;${b}m\]"
}

rgb_bg() {
    local r=$1
    local g=$2
    local b=$3
    echo "\e[48;2;$r;$g;${b}m\]"
}


COL1=(243 139 168)
COL2=(166 227 161)
COL3=(137 180 250)
COL4=(203 166 247)

FG1=$(rgb_fg 243 139 168)
FG2=$(rgb_fg 166 227 161)
FG3=$(rgb_fg 137 180 250)
FG4=$(rgb_fg 203 166 247)

RESET="\e[00m\]"


virtualenv_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="${VIRTUAL_ENV##*/}"
    else
        venv=""
    fi
    [[ "$venv" ]] && echo "$venv"
}

tg()
{
  git_dir=$(dirname $(upfind .git))
  if [[ ! -z $git_dir ]]; then
    cd $git_dir
  fi
}

functional_check() {
    echo "\$(if [[ $1 ]]; then echo $1; fi)"
}

add_prompt() {
    local text=$1
    local prev=$2
    local r=$3
    local g=$4
    local b=$5

    if [[ -z $text ]]; then
        return
    fi


    local bg_col=$(rgb_bg $r $g $b)
    local sep_col=$(rgb_fg $r $g $b)
    local fg_col=$(fg_term 0)

    local end_sep="$sep_col$RESET"
    local cond_sep="\$(if [[ -z \"$prev\" ]]; then echo ; else echo \"$bg_col \"; fi)"
    start_sep="$sep_col$cond_sep$RESET"

    local col_text="$fg_col$bg_col$text$RESET"
    local value="$start_sep$col_text$end_sep$RESET"

    if [[ $text == "\$("* ]]; then
        value="\$(if [[ $text ]]; then echo \"$value\"; fi)"
    fi

    PS1="$PS1$value"
}

components=(
    "\$(virtualenv_info)"
    "\u"
    "\W"
    "\$(parse_git_branch)"
    )

colours=(
    "$RED[@]"
    "$GREEN[@]"
    "$BLUE[@]"
    "$PURPLE[@]"
    )

print_prompt() {
    local BRANCH=$(parse_git_branch)
    local VENV=$(virtualenv_info)
    local DIRECTORY
    if [[ $(pwd) == $HOME ]]; then
        DIRECTORY="~"
    else
        DIRECTORY="$(basename $(pwd))"
    fi
    GIT_VENV_SEP=""
    if [[ $BRANCH ]] && [[ $VENV ]]; then
        GIT_VENV_SEP="  "
    fi

    PS1L="$USER  $DIRECTORY"
    PS1R="$BRANCH  $VENV"
    PS1R_LEN=${#PS1R}
    if [[ $BRANCH ]]; then
         PS1R_LEN=$(($PS1R_LEN + 2))
         BRANCH=" $BRANCH"
    fi
    PS1R="$BRANCH$GIT_VENV_SEP$VENV"
    # if [[ $BRANCH ]] || [[ $VENV ]]; then
    #     PS1="$(printf "╭─ $FG2%s $RESET $FG3%s%$(($COLUMNS-${#PS1L}-$PS1R_LEN-3))s$FG4%s$RESET$GIT_VENV_SEP$FG1%s\n$RESET│\n╰ " "$USER" "$DIRECTORY" "" "$BRANCH" "$VENV")"
    # else
    #     PS1="$(printf "╭─ $FG2%s $RESET $FG3%s\n$RESET│\n╰ " "$USER" "$DIRECTORY")"
    # fi
    if [[ $BRANCH ]] || [[ $VENV ]]; then
        PS1="$(printf "╭─ $FG2%s $FG3%s$FG4%s$FG1%s$RESET\n╰ " "$USER" "$DIRECTORY" " $BRANCH" " $VENV")"
    else
        PS1="$(printf "╭─ $FG2%s $RESET $FG3%s\n$RESET│\n╰ " "$USER" "$DIRECTORY")"
    fi
}

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND=print_prompt
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w '
fi
unset color_prompt force_color_prompt
