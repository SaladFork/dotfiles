---
name: commit
description: Use this skill proactively when and anytime Claude needs to interact with version control (git or Jujutsu/jj), the user asks to "commit", or to record changes. Also use when wrapping up a task that involved code changes.
---

## Context

- Current status:
  !`jj status`
- Recent revisions:
  !`jj log -T builtin_log_compact -r 'closest_bookmark(@)::@'`

## Task

Analyze the current changes to determine how to best break them up into logical
atomic commits. Then, create new commits or update existing commits as
appropriate.

Follow commit message best practices, including:

- The first line of a commit should be a concise summary of the change written
  as a command in the present tense imperative mood ("Add", "Fix"), under 72
  characters, starting with a capital letter. Do not end it with a period.
- The commit message should explain what and why rather than how. Avoid fluff.
  Be terse but complete. The commit message should be helpful to future readers.

Don't bias yourself by previous commit messages, which may be of lower quality.

Feel free to modify any revisions in local history. Consider if changes should
be squashed into a previous commit rather than creating a new one.

After finishing, use `jj new` (or similar) to end up with a clean workspace on
top of the last commit. Be sure to do this before moving on to any other tasks.

### Guidelines for Splitting Commits

When analyzing the diff, consider splitting commits based on these criteria:

1. **Different concerns**: Changes to unrelated parts of the codebase
2. **Different types of changes**: Mixing features, fixes, refactoring, etc.
3. **File patterns**: Changes to different types of files (e.g., source code vs
   documentation)
4. **Logical grouping**: Changes that would be easier to understand or review
   separately
5. **Size**: Very large changes that would be clearer if broken down

## Jujutsu Tips

- You can squash multiple revisions at once.
- You can operate on any revision in the graph, not just the current one. For
  example, you can run `jj describe` on an older commit to update its
  message (`-m`), and then `jj squash` to combine it with its parent. Use `-r`
  to specify the revision.
- For a familiar, git-like diff, use `jj diff --git`

### Safety net

- `jj undo` will undo the last (or any) operation, as long as nothing was pushed.
- `jj op restore <op‑id>` — time‑travel repo back to any previous operation (and
  still `jj undo` later). Everything is undoable; when in doubt, run `jj op log`
  followed by `jj undo`.

### Automation tips

- Pass `--no-editor` on describe, split, etc., in headless scripts.
- You can pass `-T` (`--template`) to customize the output format, and the
  `json()` global function for machine-readable JSON.
