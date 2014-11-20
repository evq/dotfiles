#! /bin/sh
# Yubin totally wrote this one herself
# Run this script outside of tmux!
for name in `tmux ls -F '#{session_name}'`; do
    tmux setenv -g -t $name DISPLAY $DISPLAY #set display for all sessions
done
