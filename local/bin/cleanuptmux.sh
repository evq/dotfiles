#!/bin/bash

inact_sessions=$(tmux ls | grep -v 'attached' | sed -n 's/^\([0-9]*\):.*/\1/p')
for session in $inact_sessions; do
  echo "Removing session: $session"
  tmux kill-session -t $session
done
echo -e "\nActive sessions:"
tmux ls
