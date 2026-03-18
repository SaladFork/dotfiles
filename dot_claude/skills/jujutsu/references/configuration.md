# Configuration

```bash
# list all config values
jj config list

# get a specific config value
jj config get <key>

# set a config value (user-level)
jj config set --user <key> <value>

# set a config value (repo-level)
jj config set --repo <key> <value>

# edit a config file in an editor
jj config edit --user
jj config edit --repo

# show config file paths
jj config path --user
jj config path --repo

# unset a config value
jj config unset --user <key>
jj config unset --repo <key>
```

## Scope precedence

Repo config overrides user config. Use `--repo` for project-specific settings,
`--user` for personal defaults.

## Multiple remotes

```bash
# fetch from multiple remotes
jj config set --repo git.fetch '["origin", "upstream"]'

# push to a specific remote (single remote only)
jj config set --repo git.push "myfork"
```
