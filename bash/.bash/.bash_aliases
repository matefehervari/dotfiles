function in_toggle_term {
  [ $TOGGLETERM ]
}

function in_tmux {
  [ $TMUX ]
}

function multiple_panes {
  num_panes=$(tmux list-panes | wc -l)
  [ $num_panes -gt 1 ]
}

function in_temp_term {
  [ $TEMP_TERM ]
}

function toggleterm_tmux_exit {
  if multiple_panes && ! in_toggle_term; then
    local active_pane=$(tmux list-panes | grep active | grep -Po "^\d+")
    tmux kill-pane -t $active_pane
  elif ! in_toggle_term && in_tmux && ! in_temp_term; then
    tmux detach-client
  else
    exit
  fi
}

alias e="toggleterm_tmux_exit"
alias c="clear"
alias v="~/Scripts/popup-nvim.sh"
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
alias py="python3 -i ~/util/python-shell-startup.py"
alias todo="todoist"
alias tdlist="todoist --indent list"
alias rm="trash"
