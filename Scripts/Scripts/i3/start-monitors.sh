#!/bin/bash

SCRIPT_DIR=$( cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
SESSION="10-monitors"
WINDOW="main"
COMMANDS=(
    "journalctl --user -u barrier-client -f"
    "journalctl --user -u remote-control -f"
    "journalctl --user -u syncthing -f"
)
# "cd $HOME/projects/remote-control/; source .venv/bin/activate; ./remote_control.py"

$SCRIPT_DIR/init-tmux-session -d -s "10-monitors" -n main

# Count existing panes in the target window
EXISTING_PANES=$(tmux list-panes -t "$SESSION:$WINDOW" | wc -l)
COMMAND_COUNT=${#COMMANDS[@]}

# Create only as many additional panes as needed
if [ "$EXISTING_PANES" -lt "$COMMAND_COUNT" ]; then
  for ((i = EXISTING_PANES; i < COMMAND_COUNT; i++)); do
    tmux split-window -t "$SESSION:$WINDOW" -v
  done
fi

for i in "${!COMMANDS[@]}"; do
  tmux send-keys -t "$SESSION":"$WINDOW".${i} C-c
done

sleep 1 && for i in "${!COMMANDS[@]}"; do
  tmux send-keys -t "$SESSION":"$WINDOW".${i} "bash" Enter "${COMMANDS[$i]}" Enter
done

tmux select-layout -t "$SESSION":"$WINDOW" tiled
