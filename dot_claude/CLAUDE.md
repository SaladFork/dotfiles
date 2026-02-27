## Protect Your Context

One of the most valuable resources you have is your context window. Be mindful
of reading HUGE files (whether local or remote). Consider when it would be
better to spin up an agent with its isolated context window, prompted with
specific instructions/question(s), to avoid using up your main context.

## Build the Right Thing

- If more information would be pertinent for a request, ambiguities are present,
  or more permissions are needed -- stop and ask (use the AskUserQuestion tool).
  Keep asking until we've covered everything.

## Tools

- Prefer bun/bunx over node/npm/npmx/yarn/pnpm for JavaScript/TypeScript
  execution and packages, except where a project has already established an
  alternative.
  - Use relevant package scripts over bunx when possible (bun run test, bun run
    build).
- Prefer Jujutsu (jj) over git for version control (travere, read, commit).
  Proactively commit (use the skill) after finishing code changes, though
  consider amending/squashing previous commits espeically if actively iterating.
- Use the `gh` CLI for all GitHub-related tasks (issues, PRs, searches, repo
  info, API queries). Prefer `--json` and `--jq` flags to control output and
  minimize context usage. Use `gh api graphql` for complex/nested queries.
- Offer to use the Chrome or Playwright MCPs to verify browser apps are working
  as expected, when relevant. Be sure to clean up screenshots after looking at
  them.
- Always use Context7 MCP when needing library/API documentation, code
  generation, setup, or configuration steps without having to explicitly ask.
