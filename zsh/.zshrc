export ZSH=$HOME/.oh-my-zsh

plugins=(git docker brew fabric golang gradle python pip postgres 
repo tmux
)

source $ZSH/oh-my-zsh.sh

# Setup vim mode
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Magic
function paste {
  if [[ -n $TMUX ]]; then
    BUF=`xsel -ob < /dev/null`
    ZZZ=`tmux set-buffer i$BUF; tmux paste-buffer`
  fi
}
zle -N paste
bindkey -M vicmd 'p' paste

#function tmuxcliptoxsel {
  #if [[ -n $TMUX ]]; then
     #BUF=`tmux show-buffer | xsel -ib`
  #fi
#}
#zle -N tmuxcliptoxsel
#bindkey -M vicmd 'y' tmuxcliptoxsel

# Setup mode indicator
RPS1="--INSERT--"
function zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/}/(main|viins)/-- INSERT --}"
    zle reset-prompt
}
zle -N zle-keymap-select

# Completion
autoload -U compinit
compinit
# Allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

# Automatically pushd - then I can go to an old dir with cd - <tab> (pick no.)
setopt AUTOPUSHD
export DIRSTACKSIZE=11 # stack size of eleven gives me a list with ten entries

setopt APPEND_HISTORY
unsetopt BG_NICE    # do NOT nice bg commands
setopt CORRECT      # command CORRECTION
setopt EXTENDED_HISTORY   # puts timestamps in the history
setopt HIST_ALLOW_CLOBBER
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

if [[ (! -z $SSH_AUTH_SOCK) && ($SSH_AUTH_SOCK != "$HOME/.ssh/agent_sock")]]; then
  unlink "$HOME/.ssh/agent_sock" 2>/dev/null
  ln -s $SSH_AUTH_SOCK "$HOME/.ssh/agent_sock"
fi
export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"

setopt ALL_EXPORT

autoload -U colors && colors

COLOR_VALUES=(117 161 141 208 112)
#       blue orange green magenta purple
NUM_COLORS=$#COLOR_VALUES

HOSTHASH=`echo "$HOST"| ( openssl md5 2> /dev/null || md5 2> /dev/null ||
          md5sum 2> /dev/null ) |
          cut -d' ' -f2 | awk '{ print "0x" substr($1, 2, 2) }'`
HOSTCOLOR_INDEX=$(($HOSTHASH % $NUM_COLORS))
HOSTCOLOR=%F{$COLOR_VALUES[$HOSTCOLOR_INDEX+1]}
TMUXCOLOR="colour$COLOR_VALUES[$HOSTCOLOR_INDEX+1]"

USERHASH=`whoami | ( openssl md5 2> /dev/null || md5 2> /dev/null ||
          md5sum 2> /dev/null ) | 
          cut -d' ' -f2 | awk '{ print "0x" substr($1, 2, 2) }'`
          USERCOLOR_INDEX=$((($USERHASH + 1) % $NUM_COLORS))

if [[ $USERCOLOR_INDEX -eq $HOSTCOLOR_INDEX ]]; then
  USERCOLOR_INDEX=$USERCOLOR_INDEX+1
fi

USERCOLOR=%F{$COLOR_VALUES[$USERCOLOR_INDEX+1]}

HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000

PROMPT="%{$reset_color%}[%{$USERCOLOR%}%n%{$reset_color%}@%{$HOSTCOLOR%}%m"`
`"%{$reset_color%}:%3~]%# "

if [[ $(whoami) == "root" ]]; then
  PROMPT="%{$reset_color%}[%{$fg[red]%}r"`
  `"%{$fg[yellow]%}o"`
  `"%{$fg[green]%}o"`
  `"%{$fg[blue]%}t"`
  `"%{$reset_color%}@%{$HOSTCOLOR%}%m"`
  `"%{$reset_color%}:%3~]%# "
fi

unsetopt ALL_EXPORT

# Aliases
alias wget="noglob wget" # No globbing
alias su="su -"
alias sudo="sudo -E"
alias history="history 1"
alias ack="ack --smart-case"
alias weather="weather -u si"
alias ijulia="ipython console --profile julia"
if (( $+commands[nvim] )) ; then
  alias vim="nvim"
  alias vimdiff="nvim -d"
fi
function mdig () {
  dig -x $1 @224.0.0.251 -p 5353
}
function search () {
  ls -d **/*$1* | tr ' ' '\n'
}

function vimsearch () {
  vim `ls -d **/*$1* | tr ' ' '\n' | head -$2 | tail -1`
}

function dosearch () {
  $3 `ls -d **/*$1* | tr ' ' '\n' | head -$2 | tail -1`
}

# Completion
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat '`
          `'{/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
compctl -g '*.java' javac

# Set screen title to current
preexec () {
  if [[ -n $STY ]] || [[ -n $TMUX ]]; then
    export CMD=$1
    echo -ne "\ek$CMD[(w)1]\e\\"
  fi
}

precmd() {
  if [[ -n $STY ]] || [[ -n $TMUX ]]; then
    echo -ne "\ek$(pwd | sed 's/.*\/\(.*\/.*\/[^/]*$\)/\1/g')\e\\"
    export DISPLAY=`tmux show-environment | sed -n 's/^DISPLAY\=\(.*\)/\1/p'`
  fi
}

# Include local zshrc
if [[ -e ~/.localzshrc ]]; then
  source ~/.localzshrc
fi

if [[ -n $SSH_CONNECTION ]]; then
  if [[ ! -n $TMUX ]]; then
    session=$(tmux ls | sed -n 's/^\([0-9]*\):.*/\1/p'| head -n 1)
    if [[ ! -n $session ]]; then
      session=0
      xpra start :100
    fi
      xpra attach :100 &
      DISPLAY=:100 tmux new-session -t $session
  fi
fi

source ~/.zsh/fuzzy-match.zsh

function fuzzy-wrap {
  zle vi-insert
  fuzzy-match
}
zle -N fuzzy-wrap

bindkey -M vicmd '^I' fuzzy-wrap
