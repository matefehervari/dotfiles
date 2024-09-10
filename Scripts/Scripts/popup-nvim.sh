#!/bin/bash

file=$(fd --type f --hidden \
  --exclude .git \
  --exclude *.zip \
  --exclude *.pdf \
  --exclude *.png \
  --exclude *.jpg \
  --exclude *.bmp \
  --exclude undodir \
  --exclude site-packages \
  --exclude .opam \
  --exclude .pub-cache \
  | fzf-tmux -p -w 90% --reverse)

if [[ $file ]]; then
  echo $file | xargs nvim
fi
