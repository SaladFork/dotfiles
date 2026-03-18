# Revsets Reference

Revsets are a functional language for selecting sets of revisions. Most `jj`
commands accept `-r <revset>`.

## Symbols

| Symbol | Meaning |
|--------|---------|
| `@` | Working copy commit |
| `@-` | Parent of working copy |
| `<name>@` | Working copy in workspace `<name>` |
| `<name>@<remote>` | Remote-tracking bookmark/tag |
| `root()` | The root commit |
| `visible_heads()` | Heads of all visible commits |

A full or unique-prefix commit ID or change ID can be used as a symbol.

## Operators (strongest to weakest binding)

| Operator | Meaning |
|----------|---------|
| `x-` | Parents of `x` |
| `x+` | Children of `x` |
| `::x` | Ancestors of `x` (inclusive) |
| `x::` | Descendants of `x` (inclusive) |
| `x::y` | Descendants of `x` that are ancestors of `y` |
| `x..y` | Ancestors of `y` that are not ancestors of `x` |
| `..x` | Ancestors of `x` excluding root |
| `x..` | Non-ancestors of `x` |
| `~x` | Complement (not in `x`) |
| `x & y` | Intersection |
| `x ~ y` | Difference (in `x` but not `y`) |
| `x \| y` | Union |

**Note:** `(A | B)..` is `A.. & B..`, NOT `A.. | B..`.

## Functions

### Filtering

```
mine()                  # authored by current user
author(<pattern>)       # match author name/email
committer(<pattern>)    # match committer
description(<pattern>)  # match commit description
empty()                 # empty revisions (no diff)
merges()                # merge commits (2+ parents)
conflicts()             # revisions with conflicts
```

### Graph traversal

```
heads(<set>)            # childless revisions in set
roots(<set>)            # parentless revisions in set
ancestors(<x>)          # same as ::<x>
ancestors(<x>, <depth>) # ancestors limited to depth
descendants(<x>)        # same as <x>::
descendants(<x>, <depth>) # descendants limited to depth
connected(<set>)        # set plus all commits between
reachable(<src>, <domain>) # BFS reachable from src within domain
```

### Bookmarks & refs

```
bookmarks()             # revisions with local bookmarks
bookmarks(<pattern>)    # bookmarks matching a pattern
remote_bookmarks()      # revisions with remote bookmarks
tags()                  # revisions with tags
trunk()                 # the trunk/main bookmark
```

### Other

```
all()                   # all visible commits
present(<x>)            # x if it exists, else empty set
at_operation(<op>, <x>) # evaluate x at a previous operation
coalesce(<x>, <y>, ...) # first non-empty set
```

## Common patterns

```bash
# my unpushed work
jj log -r 'mine() & ~remote_bookmarks()'

# bookmarks I haven't pushed
jj log -r 'bookmarks() & ~remote_bookmarks()'

# recent work on the current stack
jj log -r '::@ & ~trunk()'

# everything between trunk and here
jj log -r 'trunk()..@'

# find commits mentioning something
jj log -r 'description("fix")'

# all merge commits
jj log -r 'merges()'

# commits with unresolved conflicts
jj log -r 'conflicts()'
```
