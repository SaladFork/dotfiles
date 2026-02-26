---
description: Review outstanding changes and update Jujutsu VCS
allowed-tools: Bash(jj commit:*), Bash(jj describe:*), Bash(jj status:*), Bash(jj new:*), Bash(jj log:*), Bash(jj squash:*), Bash(jj diff:*), Bash(jj show:*), Bash(jj split:*), Bash(jj rebase:*)
model: sonnet
---

## Context

- Current status:
  !`jj status`
- Current diff (working copy, @, against parent):
  !`jj diff --git`
- Recent revisions:
  !`jj log -n 4 -T builtin_log_oneline -r ..@`

## Task

Analyze the diff to determine how to best break it up into logical atomic
commits. Then, create new commits or update existing commits (by squashing and
describing to update the message) as appropriate.

Follow commit message best practices, including:

- The first line of a commit should be a concise summary of the change written
  as a command in the present tense imperative mood ("Add", "Fix"), under 72
  characters, starting with a capital letter. Do not end it with a period.
- The commit message should explain what and why rather than how. Avoid fluff.
  Be terse but complete. The commit message should be helpful to future readers.

Don't bias yourself by previous commit messages, which may be of lower quality.

Feel free to make changes to any commits that are considered local history, and
not yet shared with others.

After finishing, use `jj new` (or similar) to end up with a clean workspace on
top of the last commit.

### Guidelines for Splitting Commits

When analyzing the diff, consider splitting commits based on these criteria:

1. **Different concerns**: Changes to unrelated parts of the codebase
2. **Different types of changes**: Mixing features, fixes, refactoring, etc.
3. **File patterns**: Changes to different types of files (e.g., source code vs
   documentation)
4. **Logical grouping**: Changes that would be easier to understand or review
   separately
5. **Size**: Very large changes that would be clearer if broken down
