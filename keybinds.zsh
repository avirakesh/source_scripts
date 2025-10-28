# Key bindings for word jumps and line start/end
bindkey '\e[1;5C' forward-word # Ctrl+Right
bindkey '\e[1;5D' backward-word # Ctrl+Left
bindkey '\e[H' beginning-of-line # Home
bindkey '\e[F' end-of-line # End

# For some terminals, these might be different
bindkey '\e[5C' forward-word # Ctrl+Right (alternative)
bindkey '\e[5D' backward-word # Ctrl+Left (alternative)
bindkey '\e[OH' beginning-of-line # Home (alternative)
bindkey '\e[OF' end-of-line # End (alternative)

# Fix for the delete key not working in some terminals
bindkey '\e[3~' delete-char

# Key bindings for zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
