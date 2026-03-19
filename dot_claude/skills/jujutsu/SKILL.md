---
name: jujutsu
description: Use this skill proactively when and anytime Claude needs to interact with version control (git or Jujutsu/jj)
allowed-tools: Bash(jj:*)
---

The current user prefers Jujutsu over Git and it should be used instead wherever
possible.

# Version Control with Jujutsu

## Quick start

```bash
# initialize a new repo (Git-backed)
jj git init
# clone a remote repo
jj git clone https://github.com/user/repo.git
# see the repo log
jj log
# make changes, then commit (describe + new in one step)
jj commit -m "Add feature X"
# finished work is now at @-, push its bookmark
jj git push -b my-feature
```

## Commit message conventions

- First line: concise summary, present tense imperative ("Add", "Fix"), under
  72 characters, capitalized, no trailing period.
- Explain what and why, not how. Be terse but complete.
- Don't bias yourself by previous commit messages, which may be of lower quality.

## Commands

### Working copy & commits

```bash
# describe the current working copy
jj describe -m "message"
# describe a past revision without editing it
jj describe -r <rev> -m "updated message"
# create a new empty commit on top of the working copy
jj new
# create a new commit on top of a specific revision
jj new <rev>
# create a merge commit with multiple parents
jj new <rev1> <rev2>
# create a new commit inserted after/before a specific revision
jj new -A <rev>
jj new -B <rev>
# create a commit elsewhere without leaving the current working copy
jj new --no-edit <rev> -m "message"
# snapshot working copy, set description, and create a new commit on top
jj commit -m "message"
# set a specific revision as the working copy
jj edit <rev>
# move the working copy to the child/parent revision
jj next
jj prev
# navigate a stack while staying in edit mode (edit the target directly)
jj next --edit
jj prev --edit
```

### Viewing history & changes

```bash
# show the revision graph
jj log
# show log with a revset filter
jj log -r '<revset>'
# limit log output to N revisions
jj log -n <limit>
# show log with inline patches
jj log -p
# show log with file-level summary
jj log -s
# show a specific revision's description and diff
jj show <rev>
# show summary of changed files
jj show <rev> -s
# diff the working copy against its parent
jj diff
# diff with git-style output
jj diff --git
# diff summary (file list) or stats
jj diff -s
jj diff --stat
# diff a specific revision
jj diff -r <rev>
# diff between two revisions
jj diff --from <rev1> --to <rev2>
# compare diffs of two revisions (interdiff)
jj interdiff --from <rev1> --to <rev2>
# show the repo status
jj status
```

### Rewriting history

```bash
# squash working copy changes into its parent
jj squash
# squash a specific revision into its parent
jj squash -r <rev>
# interactively squash (select hunks)
jj squash -i
# squash a revision into a specific destination
jj squash --from <rev> --into <dest>
# split a revision into two (interactive)
jj split -r <rev>
# absorb working copy changes into the right commits in the stack
jj absorb
# absorb into a specific set of destination commits
jj absorb --into <revset>
# abandon (discard) a revision
jj abandon <rev>
# duplicate a revision
jj duplicate <rev>
# rebase the whole branch containing a revision onto a new destination
# (default: -b @, i.e. the current branch)
jj rebase -b <rev> -o <destination>
# rebase a revision and its descendants onto a new destination
jj rebase -s <source> -o <destination>
# rebase just one revision (detach from descendants)
jj rebase -r <rev> -o <destination>
# insert a revision after another
jj rebase -r <rev> -A <after>
# insert a revision before another
jj rebase -r <rev> -B <before>
# rebase all independent branches onto updated trunk at once
# (all: prefix confirms intent when revset resolves to multiple revisions)
jj rebase -s 'all:roots(trunk()..@)' -o trunk()
# make sequential revisions into siblings (parallel)
jj parallelize <rev1>::<rev2>
# edit the diff of a revision with a diff editor
jj diffedit -r <rev>
# restore file contents from another revision
jj restore --from <rev> <path>
# apply the reverse of a revision on top of a destination
jj revert -r <rev> --onto <dest>
```

### Bookmarks (analogous to Git branches)

```bash
# list local bookmarks
jj bookmark list
# list all bookmarks including remote targets
jj bookmark list -a
# create a bookmark at the parent (typical after jj commit / jj new)
jj bookmark create <name> -r @-
# create a bookmark at the current working copy
jj bookmark create <name> -r @
# move a bookmark to a different revision
jj bookmark move <name> --to <rev>
# move a bookmark backwards (requires flag)
jj bookmark set <name> -r <rev> --allow-backwards
# rename a bookmark
jj bookmark rename <old> <new>
# delete a bookmark
jj bookmark delete <name>
# set (create or update) a bookmark
jj bookmark set <name> -r <rev>
# track a remote bookmark
jj bookmark track <name>@<remote>
# untrack a remote bookmark
jj bookmark untrack <name>@<remote>
# advance closest bookmark(s) to a target revision (default: closest pushable)
jj bookmark advance
jj bookmark advance --to <rev>
```

### Tags

```bash
jj tag list
```

### Git interop

```bash
# initialize a new Git-backed repo
jj git init
# initialize in colocated mode (jj + git side by side)
jj git init --colocate
# clone a remote
jj git clone <url>
# fetch from a remote
jj git fetch
# fetch from a specific remote
jj git fetch --remote <remote>
# push bookmarks to a remote
jj git push
# push a specific bookmark (auto-tracks if new, supports glob patterns)
jj git push -b <name>
# create a bookmark and push in one step
jj git push --named <name>=<rev>
# push a change with an auto-generated bookmark name (e.g. push-omqpkxqr)
jj git push -c <rev>
# push all bookmarks pointing to the given revisions
jj git push -r <revset>
# preview what would be pushed without actually pushing
jj git push --dry-run
# manage remotes
jj git remote add <name> <url>
jj git remote remove <name>
jj git remote list
# import changes from underlying Git repo
jj git import
# export jj changes to underlying Git repo
jj git export
```

### Operations (undo / time-travel)

```bash
# show the operation log
jj op log
# undo the last operation
jj undo
# redo the last undone operation
jj redo
# restore the repo to a previous operation state
jj op restore <op-id>
# revert a specific operation (creates a new operation)
jj op revert <op-id>
# show what changed in an operation
jj op show <op-id>
# diff between two operations
jj op diff --from <op-id> --to <op-id>
```

### File operations

```bash
# list files in a revision
jj file list
# show file contents at a revision
jj file show <path> -r <rev>
# annotate lines with their source revision (blame)
jj file annotate <path>
# search file contents (glob pattern)
jj file search --pattern '<pattern>'
# start tracking a path
jj file track <path>
# stop tracking a path
jj file untrack <path>
# set executable bit
jj file chmod x <path>
```

### Other

```bash
# apply formatter/linter fixes
jj fix
# bisect to find a bad revision
jj bisect
# show how a change has evolved over time
jj evolog
# show the workspace root directory
jj root
```

## Key concepts

### The working copy is a commit

Unlike Git, the working copy in Jujutsu is always a commit (`@`). Changes are
automatically snapshotted. There is no staging area — just describe and create
new commits.

### Change ID vs commit ID

Every commit has two identifiers:

- **Change ID** (letters only, e.g. `omqp`): Stable across rewrites. When you
  amend, rebase, or squash a commit, its change ID stays the same. Use this for
  day-to-day work.
- **Commit ID** (hex, e.g. `3294`): Changes on every rewrite, like a Git hash.
  Use when you need to reference a specific historical snapshot or a hidden
  (rewritten/abandoned) commit.

Prefer change IDs when referring to revisions — they survive rebases and edits.

### Automatic rebasing of descendants

When you modify any commit (via edit, squash, rebase, conflict resolution), all
descendant commits are automatically rebased. This is instant — jj operates on
repository data, not the working copy. No manual cascading fixes needed.

### Bookmarks don't auto-advance

Unlike Git branches, jj bookmarks stay where they were created. They do NOT move
when you create new commits on top. Update bookmarks right before pushing, not
during local work.

### Immutable commits

By default, jj prevents rewriting commits in `trunk()`, `tags()`, and
`untracked_remote_bookmarks()`. This is controlled by the
`immutable_heads()` revset alias.

The user has added `remote_bookmarks()` (commits that have been pushed), but
there may be some cases where it makes sense to modify them anyway, for example
to make changes on a branch that has not yet had a PR opened.

If a command fails because a commit is immutable, you can pass
`--ignore-immutable` as an escape hatch — but only with user approval, as it can
rewrite shared history.

### Revsets

Revsets are a functional language for selecting commits. Most commands accept
`-r <revset>`.

```bash
# symbols
@               # working copy
@-              # parent of working copy
<rev>-          # parents of rev
<rev>+          # children of rev

# ranges
<x>::<y>        # descendants of x that are ancestors of y
<x>..<y>        # ancestors of y that are not ancestors of x
::<x>           # ancestors of x (inclusive)
<x>::            # descendants of x (inclusive)

# set operations
<x> | <y>       # union
<x> & <y>       # intersection
<x> ~ <y>       # difference (in x but not y)
~<x>            # complement (not in x)

# commonly used functions
trunk()         # the trunk/main bookmark
mine()          # revisions authored by the current user
bookmarks()     # revisions with bookmarks
empty()         # empty revisions
conflicts()     # revisions with conflicts
description(<pattern>)  # match commit description
```

See [references/revsets.md](references/revsets.md) for the full function list.

### Templates

Templates customize output formatting. Use `-T <template>` with `jj log`,
`jj show`, etc.

```bash
# output just commit IDs (one per line)
jj log -T 'commit_id ++ "\n"' --no-graph
# custom log format
jj log -T 'change_id.short() ++ " " ++ description.first_line() ++ "\n"'
# machine-readable JSON output via the json() global function
jj log -r @ -T 'json(self)' --no-graph
```

## Workflow conventions

- **NEVER PUSH** without explicit user approval. Once something is pushed, it
  is forever public.
- **Always pass `--git` to `jj diff`, `jj log -p`, `jj show`, and `jj interdiff`.**
  The default diff format is jj-specific. `--git` produces standard unified diff
  output that is far easier to read and work with.
- **Commit early and often.** When finishing a piece of work, commit / squash /
  absorb so `@` returns to clean and finished work is at `@-` (or earlier). This
  means bookmark creation and other such operations target `@-` rather than `@`.
- Feel free to modify any revisions in local history. Consider squashing into a
  previous commit rather than creating a new one.

### Guidelines for splitting commits

Prefer making atomic commits. Consider splitting commits based on:

1. **Different concerns**: Changes to unrelated parts of the codebase
2. **Different types of changes**: Mixing features, fixes, refactoring, etc.
3. **File patterns**: Changes to different types of files (e.g., source vs docs)
4. **Logical grouping**: Changes that are easier to understand separately
5. **Size**: Very large changes that would be clearer if broken down

### The squash workflow (preferred)

The idiomatic jj workflow. Describe your intent first, then iterate.

```bash
# 1. describe what you intend to do
jj describe -m "Add user authentication"

# 2. create an empty commit on top for working
jj new

# 3. make edits to files

# 4. squash changes down into the described parent
jj squash

# repeat 2-4 for incremental work on the same commit
```

This keeps your described commit accumulating changes while `@` stays clean.
Use `jj diff -r @- --git` to review what you've built up.

#### Why this works well

- The commit message exists before the code — forces you to think about intent.
- `@` is always a clean scratch space, so bookmark/push operations target `@-`.
- `jj squash` replaces both Git's staging area and interactive rebase in one
  concept.

### The edit workflow

For when you need to modify an existing commit in a stack.

```bash
# edit a specific commit directly
jj edit <rev>

# make changes — they modify the commit in place

# if you realize you need a prerequisite change:
jj new -B @    # insert a new commit before the current one

# return to the original commit
jj next --edit

# when done, return to the tip
jj new         # or: jj edit <tip-rev>
```

Use `jj next --edit` / `jj prev --edit` to navigate a stack while staying in
edit mode (modifying each commit directly rather than creating new ones on top).

### Multi-branch simultaneous development

Work on multiple independent features simultaneously, using a merge commit as
your workspace.

```bash
# create independent branches from trunk
jj new trunk()
# ... work on feature A ...
jj commit -m "Feature A"
jj bookmark create feature-a -r @-

jj new trunk()
# ... work on feature B ...
jj commit -m "Feature B"
jj bookmark create feature-b -r @-

# merge them into one working view
jj new feature-a feature-b -m "merge: workspace"
jj new    # scratch commit on top

# edits here can be distributed to the right branch with absorb
jj absorb

# when trunk updates, rebase all branches at once
jj git fetch
jj rebase -s 'all:roots(trunk()..@)' -o trunk()
```

The `all:` prefix is a safety mechanism — it confirms your intent when a revset
resolves to multiple revisions. Without it, jj errors to prevent accidental
mass rebases.

## Automation tips

- Always pass `-m` to `jj describe` / `jj commit` so no interactive editor
  opens. For multi-line messages use a heredoc or `--stdin`.
- `jj squash -r <rev>` opens an editor to combine descriptions. Pass `-m` to
  avoid this, or use `--use-destination-message` / `-u` to keep the parent's
  message without prompting.
- **`jj split` with `-m` and file paths is fully non-interactive** — it puts
  the specified files into a new parent commit with the given message, and
  leaves remaining files in the original commit keeping its message:
  ```bash
  # Split <rev>: put a.txt in a new parent commit, leave b.txt in the original.
  jj split -r <rev> -m "Commit for a.txt" -- a.txt
  # For more splits, repeat on the resulting parent commit.
  ```
  Without `-m`, `jj split` opens an interactive editor — always pass `-m` when
  running non-interactively.
- Use `-T` (`--template`) to customize output format.
- You can operate on any revision, not just the working copy. Use `-r <rev>`.

## Safety net

- `jj undo` — undo the last operation (everything is undoable as long as nothing
  was pushed).
- `jj op log` + `jj op restore <op-id>` — time-travel to any previous state.
- When in doubt: `jj op log`, then `jj undo`.

## References

Read these when you need deeper information on a specific topic.

- [references/revsets.md](references/revsets.md) — full revset function list,
  operators, common patterns
- [references/git-interop.md](references/git-interop.md) — GitHub PR workflows,
  fetch/push behavior, multiple remotes
- [references/conflicts.md](references/conflicts.md) — conflict markers,
  resolution strategies, rebase conflicts
- [references/bookmarks.md](references/bookmarks.md) — bookmark CRUD,
  --allow-backwards, tracking, conflicts
- [references/operation-log.md](references/operation-log.md) — op log,
  undo/redo, restore, time-travel
- [references/workspaces.md](references/workspaces.md) — multiple working copies
- [references/configuration.md](references/configuration.md)
- [references/signing.md](references/signing.md)
- [references/sparse-checkout.md](references/sparse-checkout.md)
