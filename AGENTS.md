# Gemini CLI Project Context: Source Scripts

This repository is a centralized collection of shell environment configurations (dotfile) and automated setup scripts designed to manage, automate, and stylize the deployment of terminal tools, editors, and shell environments (primarily Zsh) across different systems.

## Architecture & Core Components

- **Shell Core (Zsh):** Managed via `source_main.sh`, `zsh_env.sh`, `keybinds.zsh`, `aliases`, and `util_functions.sh`.
- **Component Setup:** Individual tools have dedicated configuration directories and `setup_*.sh` scripts.
    - **Editors:** Configurations and setup scripts for **Emacs** and **Vim**.
    - **Terminal & Multiplexers:** Configurations for **Alacritty** and **Zellij**.
    - **CLI Enhancements:** Integrated setups for **Sheldon** (plugin manager), **Starship** (prompt), and **fzf**.
- **Styling & Utilities:** A centralized `style_helpers.sh` provides a unified UI (headers, info, success, warn, error, attention) and consistent output across all setup scripts.

## Engineering Standards

- **UI & Messaging:** When creating or updating setup scripts, **always** source and use the helper functions in `style_helpers.sh`.
- **Readability:** Maintain clean output by adding empty lines (`echo ""`) after headers and before final success messages or between major logical blocks in scripts.
- **Portability:** Ensure scripts are compatible with both Bash and Zsh where applicable, especially for directory detection (refer to the pattern in `util_functions.sh`).

## Commit Guidelines

When asked to commit changes, follow the **commit-message skill** (`agents/skill/commit-message/SKILL.md`) for the full process, message format, and the required `Co-Authored-By` trailer.

Repository-specific rules:
- **Content style:** Match the existing repository style for the message content: `<component/tool>: <short description in lowercase>` (e.g. `alacritty: update theme to ayu_dark`, `scripts: unify styling with style_helpers`).
- **Ignore trailers in history:** When deducing the format from existing commits (`git log`), follow their content style but **explicitly ignore any trailer lines** (e.g. `AI Tool: …`) — use only the trailer defined by the skill.

## Entry Points

- `source_main.sh`: Primary entry point for shell initialization.
- `util_functions.sh`: Common shell utilities.
- `**/setup_*.sh`: Individual component installation and configuration scripts.
