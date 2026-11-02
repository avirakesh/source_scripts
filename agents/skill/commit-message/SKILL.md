---
name: commit-message
description: Generates a git commit message that follows the repository's strict guidelines.
---
## Instructions

When you need to generate a git commit message, follow these steps:

1.  **Analyze the staged changes**:
    - Run `git --no-pager status` to see what is currently staged.
    - Run `git --no-pager diff --cached` to understand the specific changes being committed.

2.  **Reference the guidelines**:
    - **MANDATORY**: Check `AGENTS.md` and follow its commit message guidelines exactly.

3.  **Identify the format, then draft the message** (in this order of precedence):
    - **AGENTS.md**: If `AGENTS.md` specifies a commit message format, use it.
    - **Recent history**: Otherwise, run `git --no-pager log -n 5` and mimic the dominant **content style** from the last 5 commits exactly (trailers are governed by step 4 — ignore any in history).
    - **Fallback**: If no clear pattern can be deduced (empty, inconsistent, or mixed history), do not invent a format — default to the [Default Guidelines](#default-guidelines) below (summarized from <https://chris.beams.io/git-commit>).

4.  **Ensure adherence to rules**:
    - **Atomic Changes**: Ensure the message reflects only one logical change. Do not bundle unrelated modifications.
    - **Completeness**: The commit message must cover the entire diff, regardless of whether you created the changes or not.
    - **CRITICAL (AI Attribution)**: If you are generating the commit, append a blank line and a `Co-Authored-By` trailer at the end, in the form `Co-Authored-By: <harness> <model@harness.local>` — `<harness>` is the coding harness (e.g. `opencode`), `<model>` is the model identifier (e.g. `qwen-3.8-27b`). Example: `Co-Authored-By: opencode <qwen-3.8-27b@opencode.local>`.

5.  **Present to User**:
    - Propose the drafted commit message to the user for confirmation before executing the `git commit` command.

## Default Guidelines

If no clear or strong pattern can be deduced from the recent commit history, default to the guidelines from [How to Write a Git Commit Message](https://chris.beams.io/git-commit). The seven rules of a great commit message are:

1.  **Separate subject from body with a blank line**: A short subject line summarizing the change, followed by a blank line and then a more thorough description. Not every commit needs a body; a single line is fine when the change is simple enough to be self-explanatory.
2.  **Limit the subject line to 50 characters**: A rule of thumb rather than a hard limit. It keeps subjects readable and forces concise phrasing. Consider 72 characters the hard limit.
3.  **Capitalize the subject line**: Begin the subject line with a capital letter.
4.  **Do not end the subject line with a period**: Trailing punctuation is unnecessary in subject lines.
5.  **Use the imperative mood in the subject line**: Write as if giving a command (e.g. `Refactor subsystem X`), not in the indicative or descriptive (e.g. not `Fixed bug with Y` or `Changing behavior of X`). A properly formed subject should always complete the sentence: "If applied, this commit will <subject>".
6.  **Wrap the body at 72 characters**: Git never wraps text automatically, so wrap the body manually at 72 characters.
7.  **Use the body to explain *what* and *why*, not *how***: The diff shows what changed; the body should explain the problem the commit is solving and why the change matters. Details about how the change was made are usually unnecessary, since the code itself explains that.

Example:

```text
Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters or so.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).

Resolves: #123
See also: #456, #789
```

Note: the AI attribution rule (step 4) still applies — append the `Co-Authored-By` trailer at the end of the message.

## Example of pattern detection

### Input: `git --no-pager log -n 5` output
```text
commit ee0b1fb566f76bdb8297f4c955b64c344cb27503
Author: Avichal Rakesh <avichal.rakesh@gmail.com>
Date:   Sat Oct 3 23:31:29 2026 -0700

    skills: add default guidelines fallback to git-commit-message-generator

    AI Tool: opencode

commit 2daaf0aea5130979c61cb3d40f59e8e306c9ed9a
Author: Avichal Rakesh <avichal.rakesh@gmail.com>
Date:   Sat Aug 29 00:26:43 2026 -0700

    waybar, hypridle: migrate hyprctl dispatch commands to lua syntax

    AI Tool: opencode

commit bb1cadf7a257c175033a2339188e3abe6023a1be
Author: Avichal Rakesh <avichal.rakesh@gmail.com>
Date:   Fri Aug 28 23:22:29 2026 -0700

    hyprland: thicken border and dim inactive windows

    AI Tool: opencode

commit d3c6e6674041b4771f3d73b18a60f698a322ef1a
Author: Avichal Rakesh <avichal.rakesh@gmail.com>
Date:   Fri Aug 28 22:59:53 2026 -0700

    hyprland: fix move monitor arguments

commit ff7ec4da492232e9b7818341a53cdfef6c7301ab
Author: Avichal Rakesh <avichal.rakesh@gmail.com>
Date:   Fri Aug 28 22:52:53 2026 -0700

    hyprland, system_check: remove wallpaper gradient colors and matugen dependency

    AI Tool: opencode
```

### Expected Agent Output
```text
scripts: update setup script logic

Co-Authored-By: opencode <qwen-3.8-27b@opencode.local>
```

## Example of a good commit message

```text
alacritty: update theme to ayu_dark

Co-Authored-By: opencode <qwen-3.8-27b@opencode.local>
```
