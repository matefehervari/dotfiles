# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mate/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mate/.fzf/bin"
fi

eval "$(fzf --bash)"
