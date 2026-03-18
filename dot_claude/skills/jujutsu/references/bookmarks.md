# Bookmarks & Remotes

Bookmarks are Jujutsu's equivalent of Git branches. They are named pointers to
revisions.

**Important:** Unlike Git branches, bookmarks do NOT auto-advance when you
create new commits. Update them right before pushing, not during local work.

## Managing bookmarks

```bash
# list all bookmarks
jj bookmark list

# list bookmarks matching a pattern
jj bookmark list <pattern>

# create a bookmark at a revision (typically @- after jj commit)
jj bookmark create <name> -r <rev>
jj bookmark create feature-x -r @-

# set (create or update) a bookmark
jj bookmark set <name> -r <rev>

# move a bookmark to a new target
jj bookmark move <name> --to <rev>

# move a bookmark backwards or sideways (requires flag)
jj bookmark set <name> -r <rev> --allow-backwards
jj bookmark move <name> --to <rev> --allow-backwards

# rename a bookmark
jj bookmark rename <old> <new>

# delete a bookmark (propagates deletion on next push)
jj bookmark delete <name>

# forget a bookmark (does not propagate deletion to remote)
jj bookmark forget <name>

# advance the closest bookmark to a target revision
jj bookmark advance <name>
```

## Tracking remote bookmarks

```bash
# start tracking a remote bookmark
jj bookmark track <name>@<remote>

# stop tracking
jj bookmark untrack <name>@<remote>
```

When you track a remote bookmark, pushing/pulling keeps the local and remote
bookmarks in sync.

## Bookmark conflicts

Bookmarks can become conflicted (shown as `main??` in `jj log`) when
concurrent operations update the same bookmark.

```bash
# resolve by moving the bookmark to the desired target
jj bookmark move main --to <rev>

# or merge the conflicted targets
jj new 'all:main'
```

Remote bookmark conflicts resolve on the next `jj git fetch`.

## Common revset patterns with bookmarks

```bash
# all bookmarked revisions
jj log -r 'bookmarks()'

# my local-only bookmarks (not yet pushed)
jj log -r 'bookmarks() & ~remote_bookmarks()'

# remote bookmarks for my work
jj log -r 'remote_bookmarks() & mine()'
```
