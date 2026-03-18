# Git Interop & Workflows

Jujutsu uses Git as a storage backend. It can work with any Git repository.

## Initialization modes

```bash
# new repo with Git backend
jj git init

# colocated: jj and git side by side (.jj/ alongside .git/)
# allows using both jj and git commands on the same repo
jj git init --colocate

# clone a remote
jj git clone <url> [<dest>]
```

## Fetching & pushing

```bash
# fetch from all remotes
jj git fetch

# fetch from a specific remote
jj git fetch --remote origin

# push all tracked bookmarks
jj git push

# push a specific bookmark (auto-tracks if new)
jj git push -b my-feature

# create a bookmark and push in one step
jj git push --named my-feature=@-
```

## Important: post-fetch and post-push behavior

**After `jj git fetch`:** Remote bookmarks update but `@` does NOT move. You
must manually advance your working copy:

```bash
jj git fetch
# rebase your current work onto the updated trunk
jj rebase -b @ -o trunk()
# or start fresh from trunk
jj new trunk()
```

**After `jj git push`:** If the pushed commit was your working copy (`@`), it
becomes immutable and jj auto-creates a new empty commit on top. This is
expected — you're now in a clean `@` with your pushed work at `@-`.

## Working with remotes

```bash
jj git remote add origin <url>
jj git remote remove origin
jj git remote list
```

## Multiple remotes

Configure which remotes to fetch from and push to:

```bash
# fetch from multiple remotes
jj config set --repo git.fetch '["origin", "upstream"]'

# push to a specific remote (single remote only)
jj config set --repo git.push "myfork"
```

## Import / export

In colocated repos, jj automatically imports/exports. In non-colocated repos:

```bash
# import Git refs into jj
jj git import

# export jj bookmarks to Git refs
jj git export
```

## GitHub PR workflow

```bash
# start work on a new feature
jj new trunk()
# ... make changes ...
jj commit -m "Add feature X"
# finished work is at @-, create bookmark there and push
jj bookmark create feature-x -r @-
jj git push -b feature-x

# address review comments (squash into the existing commit)
jj new feature-x
# ... make fixes ...
jj squash
# bookmark already points to the updated commit, just push
jj git push -b feature-x

# alternative: add a follow-up commit
jj new feature-x
# ... make fixes ...
jj commit -m "Address PR comments"
jj bookmark move feature-x --to @-
jj git push -b feature-x
```

**Note:** `jj git push -c <rev>` can auto-generate a bookmark name from the
change ID (e.g. `push-omqpkxqr`). Prefer named bookmarks for clarity.

## Stacked PRs

```bash
# create a chain of commits
jj new trunk()
# ... work on feature A ...
jj commit -m "Feature A"
jj bookmark create feature-a -r @-

# feature B depends on A — @ is already on top of A
# ... work on feature B ...
jj commit -m "Feature B"
jj bookmark create feature-b -r @-

# push both
jj git push -b feature-a -b feature-b
```
