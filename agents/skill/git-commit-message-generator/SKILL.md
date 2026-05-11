---
name: git-commit-message-generator
description: Generates a git commit message that follows the repository's strict guidelines.
---
## Instructions

When you need to generate a git commit message, follow these steps:

1.  **Analyze the staged changes**:
    - Run `git --no-pager status` to see what is currently staged.
    - Run `git --no-pager diff --cached` to understand the specific changes being committed.

2.  **Reference the guidelines**:
    - **MANDATORY**: You must check `AGENTS.md` and follow any instructions within it to the letter to ensure strict compliance with the repository's standards.

3.  **Draft the message following this pattern**:
    - Follow the pattern identified from recent commits.

4.  **Ensure adherence to rules**:
    - **Atomic Changes**: Ensure the message reflects only one logical change. Do not bundle unrelated modifications.
    - **Completeness**: The commit message must cover the entire diff, regardless of whether you created the changes or not.
    - **Pattern Mimicry**: You must use `git log -n 5` to inspect the last 5 commit messages and deduce the pattern. It is critical that you mimic this pattern exactly when drafting the new message.
    - **CRITICAL (AI Attribution)**: If you (the agent) are generating the commit, you MUST propose an empty line followed by `AI Tool: <Your Agent Name>` at the end of the commit message.

5.  **Present to User**:
    - Propose the drafted commit message to the user for confirmation before executing the `git commit` command.

## Example of pattern detection

### Input: `git log -n 5` output
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
