#!/bin/bash

file=$(fd --type f --hidden --exclude .git | fzf-tmux -p)

if [[ $file ]]; then
  echo $file | xargs nvim
fi
