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
    - **MANDATORY**: You must check `AGENTS.md` and follow any instructions within it to the letter to ensure strict compliance with the repository's standards.

3.  **Identify the format, then draft the message**:
    - Use `git --no-pager log -n 5` to inspect the last 5 commit messages and deduce the dominant pattern. It is critical that you mimic this pattern exactly when drafting the new message.
    - **Precedence**: If `AGENTS.md` specifies a commit message format, it takes precedence over the pattern in recent commits.
    - **Fallback**: If no clear or strong pattern can be deduced (e.g. the history is empty, inconsistent, or mixes multiple styles), do not guess or invent a format. Default to the guidelines at <https://chris.beams.io/git-commit> — an overview is provided in the [Default Guidelines](#default-guidelines) section below.

4.  **Ensure adherence to rules**:
    - **Atomic Changes**: Ensure the message reflects only one logical change. Do not bundle unrelated modifications.
    - **Completeness**: The commit message must cover the entire diff, regardless of whether you created the changes or not.
    - **CRITICAL (AI Attribution)**: If you (the agent) are generating the commit, you MUST propose an empty line followed by `AI Tool: <Your Agent Name>` at the end of the commit message.

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

Note: the mandatory AI attribution rule still applies when using these default guidelines — append an empty line followed by `AI Tool: <Your Agent Name>` at the end of the message.

## Example of pattern detection

### Input: `git --no-pager log -n 5` output
```text
feat(ui): add new button to homepage
fix(core): resolve memory leak in process handler
feat(auth): implement oauth2 support
docs(readme): update installation instructions
refactor(parser): optimize regex performance
```

### Expected Agent Output
```text
feat(config): update setup script logic

AI Tool: opencode
```

## Example of a good commit message

```text
alacritty: update theme to ayu_dark

AI Tool: opencode
```
