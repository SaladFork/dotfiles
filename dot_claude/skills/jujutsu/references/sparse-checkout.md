# Sparse Checkout

Control which paths from the working-copy commit are present on disk.

```bash
# list current sparse patterns
jj sparse list

# set specific sparse patterns
jj sparse set --add <path> --remove <path>

# include only specific paths (clear everything else first)
jj sparse set --clear --add src/ --add README.md

# reset to include all files
jj sparse reset
```
