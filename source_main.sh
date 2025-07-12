# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source all files in this directory
CURR_DIR="$(dirname $0)"
for f in $CURR_DIR/*; do
    if [[ -f $f && "$f" != "$0" ]]; then
        source $f;
    fi;
done;

export PATH="$PATH:$HOME/bin"

# Make emacs the default editor
export ALTERNATE_EDITOR="" # causes emacsclient to start a new daemon if needed
export EDITOR="emacsw"

if [[ -z "$COLORTERM" ]]; then
    # More often than not, the backing terminal will support truecolor
    export COLORTERM="truecolor"
fi

# Used for live_rsync in util_functions.sh
export CUSTOM_RSYNC_EXCLUDE_PATH="$CURR_DIR/rsync/ignore.txt"

#Powerlevel10k setup

# To customize prompt, run `p10k configure` or edit $CURR_DIR/oh-my-zsh/powerlevel/p10k.zsh.
[[ ! -f $CURR_DIR/oh-my-zsh/powerlevel/p10k.zsh ]] || source $CURR_DIR/oh-my-zsh/powerlevel/p10k.zsh


# auto start zellij at start and exit on zellij exit
if [[ -z "$ZELLIJ" && -n "$AUTOSTART_ZELLIJ" ]]; then
    zellij
    exit
fi
