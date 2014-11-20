#!/bin/zsh
COLOR_NAMES=("= c" "= y" "= m" "= b" "= r" "= g" "+b c" "+b m" "+b b" "+b r" "+b g")
NUM_COLORS=$#COLOR_NAMES

HOSTHASH=`echo "$HOST"| ( openssl md5 || md5 || md5sum ) | cut -d' ' -f1 | awk '{ print "0x" substr($1, 2, 2) }'`
HOSTCOLOR_INDEX=$(($HOSTHASH % $NUM_COLORS))
HOSTCOLOR=$COLOR_NAMES[$HOSTCOLOR_INDEX+1]

echo "\005{$HOSTCOLOR}"
