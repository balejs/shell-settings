#!/bin/bash
#copy this file in i.e. ~/.local/bin and source it from bashrc

# alias for launching screen that also stores the value of DISPLAY to be propagated
# in existing shells via screen_set_display
alias s='echo $DISPLAY > ~/.screendisplay && scrn -dRR'

# adjust screen settings to remote vs local shells. This is for clipboard support
function screen_set_display {
  if [ -f "$HOME/.screendisplay" ]; then
    echo "export DISPLAY=`cat $HOME/.screendisplay`"
  fi
}

case $TERM in
    screen*)
      # - update the DISPLAY environment variable (maybe there's a more efficient way?)
      # - echo the current folder in screen window title
      SCREEN_PROMPT_COMMAND='$(screen_set_display); echo -ne "\033k$echo ${PWD##*/}\007\033\\"'
        ;;
    *)
      SCREEN_PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
esac

# prompt color
BOLD_YELLOW_ON_BLUE="\[\033[01;33;44m\]"
BLUE="\[\033[01;34m\]"
RESET_COLOR="\[\033[00m\]"

# git status settings for prompt
export GIT_PS1_SHOWCOLORHINTS=yes
export GIT_PS1_SHOWDIRTYSTATE=yes

# prompt command (this overrides whatever is in PS1)
# time product current_folder (git_status)
PROMPT_COMMAND='__git_ps1 "`date +%H:%M:%S` ${BLUE}\W${RESET_COLOR}" "\\\$ "'
PROMPT_COMMAND="$PROMPT_COMMAND; $SCREEN_PROMPT_COMMAND"

# disable flow control characters ctrl+s/ctrl+q to use ctrl+q in gnu screen
bind -r '\C-s'
stty -ixon

#additional paths
export PATH=$PATH:$HOME/.local/bin

# fuzzy finder for ctrl+r and ctrl+t
# the tools must be installed, usually through vim plugins (reply no to the bashrc
# change question). See vimrc for details
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#additional python site packages, installed as user with pip
export PYTHONPATH=$PYTHONPATH:$HOME/.local/lib/python3.6/site-packages
