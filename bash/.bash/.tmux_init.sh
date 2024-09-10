if [[ $TMUX ]]; then
  return
fi

default_tmux=0-terminal
$HOME/Scripts/tmux-wrapper $default_tmux
exit
