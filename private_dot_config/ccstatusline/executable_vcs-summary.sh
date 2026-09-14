#!/bin/sh
# VCS summary for ccstatusline.
# jj: <closest-bookmark>/ [⇡N ⇣M] (empty) <description>
# git fallback: <branch>

if jj root --quiet >/dev/null 2>&1; then
  bookmark=$(jj log --no-graph --ignore-working-copy --quiet --color=never \
    -r 'heads(::@ & bookmarks())' -T 'bookmarks' 2>/dev/null)

  ahead=$(jj log --no-graph --ignore-working-copy --quiet --color=never \
    -r '(@:: | ::@) & ~empty() & ~::remote_bookmarks()' -T '"x\n"' 2>/dev/null \
    | wc -l | tr -d ' ')
  behind=$(jj log --no-graph --ignore-working-copy --quiet --color=never \
    -r '@+::remote_bookmarks()' -T '"x\n"' 2>/dev/null \
    | wc -l | tr -d ' ')

  change=$(jj log --no-graph --ignore-working-copy --quiet --color=never -r @ -T '
    separate(" ",
      if(empty, "(empty)"),
      surround("(", ")",
        separate(" ",
          if(diff.files().filter(|f| f.status() == "added"),
            "+" ++ diff.files().filter(|f| f.status() == "added").len()),
          if(diff.files().filter(|f| f.status() == "copied"),
            "&" ++ diff.files().filter(|f| f.status() == "copied").len()),
          if(diff.files().filter(|f| f.status() == "modified"),
            "•" ++ diff.files().filter(|f| f.status() == "modified").len()),
          if(diff.files().filter(|f| f.status() == "removed"),
            "-" ++ diff.files().filter(|f| f.status() == "removed").len()),
          if(diff.files().filter(|f| f.status() == "renamed"),
            "→" ++ diff.files().filter(|f| f.status() == "renamed").len()))),
      if(description.first_line().len() == 0,
        "(no description)",
        if(description.first_line().len() <= 40,
          description.first_line(),
          description.first_line().substr(0, 40) ++ "…")))' 2>/dev/null)

  sync=""
  [ "${ahead:-0}" -gt 0 ] && sync="⇡$ahead"
  [ "${behind:-0}" -gt 0 ] && sync="${sync:+$sync }⇣$behind"

  out=""
  [ -n "$bookmark" ] && out="$bookmark/"
  [ -n "$sync" ] && out="${out:+$out }$sync"
  [ -n "$change" ] && out="${out:+$out }$change"
  printf '%s' "$out"
elif git rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git symbolic-ref --short HEAD 2>/dev/null \
    || git rev-parse --short HEAD 2>/dev/null)
  printf '%s' "$branch"
fi
