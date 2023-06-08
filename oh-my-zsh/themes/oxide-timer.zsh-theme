# Oxide theme for Zsh
#
# Author: Diki Ananta <diki1aap@gmail.com>
# Repository: https://github.com/dikiaap/dotfiles
# License: MIT
# Modified by: Avichal Rakesh

# Prompt:
# %F => Color codes
# %f => Reset color
# %~ => Current path
# %(x.true.false) => Specifies a ternary expression
#   ! => True if the shell is running with root privileges
#   ? => True if the exit status of the last command was success
#
# Git:
# %a => Current action (rebase/merge)
# %b => Current branch
# %c => Staged changes
# %u => Unstaged changes
#
# Terminal:
# \n => Newline/Line Feed (LF)

setopt PROMPT_SUBST

autoload -U add-zsh-hook
autoload -Uz vcs_info

# Use True color (24-bit) if available.
if [[ "${terminfo[colors]}" -ge 256 ]]; then
    oxide_turquoise="%F{73}"
    oxide_orange="%F{179}"
    oxide_red="%F{167}"
    oxide_limegreen="%F{107}"
else
    oxide_turquoise="%F{cyan}"
    oxide_orange="%F{yellow}"
    oxide_red="%F{red}"
    oxide_limegreen="%F{green}"
fi

# Reset color.
oxide_reset_color="%f"

# VCS style formats.
FMT_UNSTAGED="%{$oxide_reset_color%} %{$oxide_orange%}●"
FMT_STAGED="%{$oxide_reset_color%} %{$oxide_limegreen%}✚"
FMT_ACTION="(%{$oxide_limegreen%}%a%{$oxide_reset_color%})"
FMT_VCS_STATUS="on %{$oxide_turquoise%} %b%u%c%{$oxide_reset_color%}"

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr    "${FMT_UNSTAGED}"
zstyle ':vcs_info:*' stagedstr      "${FMT_STAGED}"
zstyle ':vcs_info:*' actionformats  "${FMT_VCS_STATUS} ${FMT_ACTION}"
zstyle ':vcs_info:*' formats        "${FMT_VCS_STATUS}"
zstyle ':vcs_info:*' nvcsformats    ""
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Check for untracked files.
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain | grep --max-count=1 '^??' &> /dev/null; then
        hook_com[staged]+="%{$oxide_reset_color%} %{$oxide_red%}●"
    fi
}

# START: PERSONAL CHANGES

function box_name() {
    [ -f ~/.box-name ] && cat  ~/.box-name || hostname -s
}

function start_clock() {
    start_time=$(date +%s)
}

function time_prev_command() {
    runtime_prompt=""
    if [[ -z "$start_time" ]]; then
        runtime_prompt="$runtime_prompt"
    else
        local end_time=$(date +%s)
        local runtime=$(($end_time - $start_time))

        local ss=$(($runtime % 60))
        if [[ $ss -le 9 ]]; then ss="0$ss"; fi

        local mm=$(($runtime / 60))
        mm=$(($mm % 60))
        if [[ $mm -le 9 ]]; then mm="0$mm"; fi

        local hh=$(($runtime / 3600))
        if [[ $hh -le 9 ]]; then hh="0$hh"; fi

        local p_time=""
        if [[ $hh -ne 0 ]]; then p_time="${hh}h ${mm}m ${ss}s"
        elif [[ $mm -ne 0 ]]; then p_time="${mm}m ${ss}s"
        else p_time="${ss}s"; fi

        runtime_prompt="%{$oxide_red%}$p_time%{$oxide_reset_color%} | "
        unset start_time
    fi
}

add-zsh-hook preexec start_clock
add-zsh-hook precmd time_prev_command

# END: PERSONAL CHANGES

# Executed before each prompt.
add-zsh-hook precmd vcs_info

# Oxide prompt style.
PROMPT=$'\n%{$oxide_limegreen%}%~%{$oxide_reset_color%} ${vcs_info_msg_0_}\n%(?.%{%F{white}%}.%{$oxide_red%})%(!.#.↳)%{$oxide_reset_color%}  '
RPROMPT='$runtime_prompt%{$fg[magenta]%}$(box_name)%{$oxide_reset_color%} | %{$oxide_orange%}%T%{$oxide_reset_color%}'
