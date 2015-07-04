[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &
xsetroot -cursor_name left_ptr &
pulseaudio --start &
sxhkd &
compton &
sh ~/.fehbg &
eval $(envoy -p)
exec bspwm
