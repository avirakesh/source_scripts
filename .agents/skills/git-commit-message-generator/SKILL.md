---
name: git-commit-message-generator
description: Generates a git commit message that follows the repository's strict guidelines.
---
## Instructions

When you need to generate a git commit message, follow these steps:

1.  **Analyze the staged changes**:
    - Run `git status` to see what is currently staged.
    - Run `git diff --cached` to understand the specific changes being committed.

2.  **Reference the guidelines**:
    - Always check `AGENTS.md` under the `## Commit Guidelines` section to ensure compliance with the repository's standards.

3.  **Draft the message following this pattern**:
    - `<component/tool>: <short description in lowercase>`
    - *Examples*: `alacritty: update theme to ayu_dark`, `scripts: unify styling with style_helpers`.

4.  **Ensure adherence to rules**:
    - **Atomic Changes**: Ensure the message reflects only one logical change. Do not bundle unrelated modifications.
    - **Clarity**: The description should be concise and lowercase.
    - **AI Attribution**: If you (the agent) are generating the commit, remember to propose an empty line followed by `AI Tool: <Your Agent Name>` at the end of the commit message.

5.  **Present to User**:
    - Propose the drafted commit message to the user for confirmation before executing the `git commit` command.

## Example of a good commit message

```text
alacritty: update theme to ayu_dark

AI Tool: opencode
```
