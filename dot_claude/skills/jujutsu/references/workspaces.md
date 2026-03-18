# Workspaces

Workspaces let you have multiple working copies attached to the same repo. This
is useful for running a build or test in one workspace while continuing to code
in another.

## Managing workspaces

```bash
# add a new workspace at a path
jj workspace add ../my-workspace

# add a workspace starting at a specific revision
jj workspace add ../my-workspace -r <rev>

# list all workspaces
jj workspace list

# forget (remove) a workspace
jj workspace forget <name>

# rename the current workspace
jj workspace rename <new-name>

# update a stale workspace (after another workspace modified the repo)
jj workspace update-stale

# show the root directory of the current workspace
jj workspace root
```

## How workspaces work

- Each workspace has its own working-copy commit (shown as `<name>@` in
  `jj log` when multiple workspaces exist).
- All workspaces share the same repo and operation log.
- Each workspace has its own sparse patterns.
- Changes made in one workspace are immediately visible to others after the
  working copy is snapshotted.

## Referring to other workspaces

Use `<workspace-name>@` in revsets to refer to another workspace's working copy:

```bash
# see what the "build" workspace is working on
jj log -r 'build@'
```

## Common use case: parallel build/test

```bash
# in your main workspace, create a workspace for testing
jj workspace add ../repo-test

# in the test workspace, run your build/tests
cd ../repo-test
jj workspace update-stale
make test

# continue coding in the original workspace
cd ../repo
```
