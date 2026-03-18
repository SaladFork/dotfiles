# Conflict Resolution

Jujutsu handles conflicts differently from Git. Conflicts are stored as
first-class objects in the commit graph — a conflicted commit is a valid
commit, not a broken state that blocks all work.

## Viewing conflicts

```bash
# status shows conflicted paths
jj status

# log marks conflicted revisions with a × instead of ○
jj log

# diff shows conflict markers
jj diff -r <conflicted-rev>
```

## Resolving conflicts

### Option 1: Edit conflict markers directly

Conflict markers look like:

```
<<<<<<< Conflict 1 of 1
%%%%%%% Changes from base to side #1
-old line
+side 1 line
+++++++ Contents of side #2
side 2 line
>>>>>>> Conflict 1 of 1 ends
```

Edit the file to the desired state, then squash into the conflicted commit:

```bash
jj new <conflicted-rev>
# edit the file to resolve
jj squash
```

### Option 2: Use an external merge tool

```bash
jj resolve
# or for a specific file
jj resolve <path>
# or for a specific revision
jj resolve -r <rev>
```

### Option 3: Restore one side

```bash
# take the version from a specific revision
jj restore --from <rev> <path>
```

## Conflicts from rebase

When `jj rebase` creates conflicts, resolve them starting from the earliest
conflicted commit:

```bash
# find conflicted commits
jj log -r 'conflicts()'

# resolve the earliest one first
jj new <earliest-conflicted>
# ... resolve ...
jj squash

# descendant conflicts may auto-resolve after fixing the ancestor
```

## Key difference from Git

- Conflicts don't block you. You can continue working, create new commits, and
  resolve later.
- Rebasing through conflicts is automatic — jj carries conflict state forward.
- When you resolve a conflict in an ancestor, descendants are automatically
  rebased and may resolve themselves.
