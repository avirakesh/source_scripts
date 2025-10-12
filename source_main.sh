# Initialize Zsh completion system
autoload -Uz compinit
compinit

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory # append history to HISTFILE (don't overwrite)
setopt sharehistory  # share history between all sessions
setopt hist_ignore_dups # ignore duplicate commands
setopt hist_ignore_space # ignore commands that start with a space
setopt hist_verify # show command with history expansion before running it
setopt hist_expire_dups_first # expire duplicates first when trimming history

# Directory stack options
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS



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

# Sheldon initialization
eval "$(sheldon source)"

# Starship initialization
eval "$(starship init zsh)"


# auto start zellij at start and exit on zellij exit
if [[ -z "$ZELLIJ" && -n "$AUTOSTART_ZELLIJ" ]]; then
    zellij
    exit
fi
