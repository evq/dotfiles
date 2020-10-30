[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &
sxhkd &
compton &
sh ~/.fehbg &
xsetroot -xcf /usr/share/icons/Adwaita/cursors/left_ptr 24
xset +fp /usr/share/fonts/ttf-noto-sans-ib/ || true
volnoti
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
exec bspwm
