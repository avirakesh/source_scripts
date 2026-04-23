# Gemini CLI Project Context: Source Scripts

This repository is a centralized collection of shell environment configurations (dotfiles) and automated setup scripts designed for a modern, consistent development environment across different systems.

## Project Purpose
To manage, automate, and stylize the deployment of terminal tools, editors, and shell environments (primarily Zsh).

## Core Components
- **Shell (Zsh):** Integrated via `source_main.sh`, `aliases`, `keybinds.zsh`, `zsh_env.sh`, and `util_functions.sh`.
- **Editors:** Configurations and setup scripts for **Emacs**, **Vim**.
- **Terminal & Multiplexers:** Configurations for **Alacritty**, **Zellij**.
- **CLI Enhancements:** Integrated setups for **Sheldon** (plugin manager), **Starship** (prompt), and **fzf**.
- **Styling:** A centralized `style_helpers.sh` providing consistent UI output (colors, emojis, headers) across all setup scripts.

## Guidelines for Future Agents

### Engineering Standards
- **UI & Messaging:** When creating or updating setup scripts, **always** source and use the helper functions in `style_helpers.sh` (`header`, `info`, `success`, `warn`, `error`, `attention`).
- **Readability:** Maintain clean output by adding empty lines (`echo ""`) after headers and before final success messages or between major logical blocks in scripts.
- **Portability:** Ensure scripts are compatible with both Bash and Zsh where applicable, especially for directory detection (refer to the pattern in `util_functions.sh`).

### Mandatory Commit Process
When asked to commit changes, follow these strict rules:

1.  **Atomic Changes:** Focus on one logical change at a time. Do not bundle unrelated modifications into a single commit.
2.  **Verify State:** Always check the current status and diff (`git status && git diff HEAD`) before crafting a commit to ensure only intended changes are included.
3.  **Message Pattern:** Craft commit messages following the existing repository style: `<component/tool>: <short description in lowercase>`.
    *   *Examples:* `alacritty: update theme to ayu_dark`, `scripts: unify styling with style_helpers`.
4.  **Confirm Before Action:** Propose the commit message to the user before executing the commit command.

## Entry Points
- `source_main.sh`: Primary entry point for shell initialization.
- `util_functions.sh`: Common shell utilities.
- `**/setup_*.sh`: Individual component installation and configuration scripts.
