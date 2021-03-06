setopt ALL_EXPORT

PAGER='less'
EDITOR='vim'

LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C

#_JAVA_AWT_WM_NONREPARENTING=1
ARDUINO_DIR=/usr/share/arduino
AVR_TOOLS_DIR=/usr

PANEL_FIFO="/tmp/panel-fifo"
PANEL_HEIGHT=28
#PANEL_FONT_FAMILY="-*-noto sans-medium-r-*-*-14-*-*-*-*-*-*-*"
PANEL_FONT_FAMILY="-*-terminus*-*-*-*-12-*-*-*-*-*-*-*"

# Brave build settings
DISABLE_WEBPACK_NOTIFIER=1

unsetopt ALL_EXPORT

# Include local zshenv
if [[ -e ~/.localzshenv ]]; then
  source ~/.localzshenv
fi
