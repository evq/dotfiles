#/bin/bash
pamixer "$@" 5
volnoti-show $(pamixer --get-volume)
