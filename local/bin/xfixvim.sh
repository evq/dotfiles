tmux show-environment | sed -n 's/^DISPLAY\=\(.*\)/\1/p'
