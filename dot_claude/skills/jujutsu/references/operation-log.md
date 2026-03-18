# Operations & Undo

Every `jj` command that modifies the repo is recorded as an operation. This
gives you a complete undo history — a time machine for your repo.

## Viewing operations

```bash
# show the operation log
jj op log

# show details of a specific operation
jj op show <op-id>

# diff the repo between two operations
jj op diff --from <op-id> --to <op-id>
```

## Undoing and restoring

```bash
# undo the last operation
jj undo

# redo the last undone operation
jj redo

# restore the repo to any previous operation
jj op restore <op-id>

# revert a specific operation (without undoing later ones)
jj op revert <op-id>
```

## Key properties

- **Everything is undoable** as long as nothing was pushed to a remote.
- Operations form a log, not a stack — you can undo any operation, not just the
  most recent.
- `jj op restore` is a time-travel that sets the entire repo state back to a
  previous point.
- After `jj op restore`, you can still `jj undo` to go back.
- Operations can diverge (concurrent `jj` commands). Jujutsu automatically
  merges divergent operations.

## Cleaning up

```bash
# abandon old operations to save space
jj op abandon <op-id>
```

## Automation tip

Use `--at-op <op-id>` on any `jj` command to run it against a specific
operation state without modifying the current working copy:

```bash
jj --at-op=<op-id> log
jj --at-op=<op-id> status
```
