RPROMPT="[%*]"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=~/.local/bin:/Users/marco/Library/Python/3.8/bin:$HOME/stuff/launch_times_analyzer/utilities/plotter/:$PATH
RSYNC_PASSWORD=alpine
unsetopt nomatch
unsetopt BEEP
unsetopt share_history
zstyle ':completion:::*:default' menu no select
