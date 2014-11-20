[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &
sxhkd &
sh ~/.fehbg &
exec bspwm
