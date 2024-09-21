if [[ $TMUX ]]; then
  return
fi

if [ ! -f /tmp/temp_term_counter ]; then
  touch /tmp/temp_term_counter
  echo 0 > /tmp/temp_term_counter
fi

temp_term_count=$(cat /tmp/temp_term_counter)
default_tmux=0-terminal

if [ $TEMP_TERM ]; then
  let "++temp_term_count"; echo $temp_term_count > /tmp/temp_term_counter

  session_name="temp-terminal-$temp_term_count"
else
  session_name=$default_tmux
fi

$HOME/Scripts/tmux-wrapper $session_name
exit
