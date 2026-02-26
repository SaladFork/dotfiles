## Build the Right Thing

- If more information would be pertinent for a request, ambiguities are present,
  or more permissions are needed -- stop and ask (use the AskUserQuestion tool).
  Keep asking until we've covered everything.

## Tools

- Prefer bun/bunx over node/npm/npmx/yarn/pnpm for JavaScript/TypeScript
  execution and packages, except where a project has already established an
  alternative.
- Prefer Jujutsu (jj) over git for version control (travere, read, commit)
- Offer to use the Chrome or Playwright MCPs to verify browser apps are working
  as expected, when relevant. Be sure to clean up screenshots after looking at
  them.
- Always use Context7 MCP when needing library/API documentation, code
  generation, setup, or configuration steps without having to explicitly ask.
