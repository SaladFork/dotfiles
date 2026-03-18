#!/bin/bash
INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name')
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [[ "$TOOL" == "Bash" && "$CMD" =~ ^jj\  ]]; then
  if [[ "$CMD" =~ ^jj\ git\ push ]]; then
    echo '{"decision":"deny","reason":"jj git push requires manual approval"}'
  else
    echo '{"decision":"approve","reason":"Safe jj command"}'
  fi
fi
