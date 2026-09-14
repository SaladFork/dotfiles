## Build the Right Thing

- If more information would be pertinent for a request, ambiguities are present,
  or more permissions are needed -- stop and ask. Keep asking until we've
  covered everything. For each question, provide your recommended answer. Ask
  questions one at a time, waiting for feedback on each question before
  continuing. If a question can be answered by exploring the codebase, explore
  the codebase instead.
- When designing, walk down each branch of the design tree, resolving
  dependencies between decisions one-by-one.
- Consider the broader impact of changes made. Refactor code to make difficult
  changes easy rather than forcing them through with hacky code.
- When writing tests, test the requirements not the implementation. Don't write
  tests for what the type system guarantees.

## Tools

- Prefer bun/bunx over node/npm/npmx/yarn/pnpm for JavaScript/TypeScript
  execution and packages, except where a project has already established an
  alternative.
  - Use relevant package scripts over bunx when possible
    (bun run test, bun run build, bun run lint, bun run typecheck).
- Prefer Jujutsu (`jj`) over git for version control (traverse, read, commit).
  Proactively commit (use the skill) early and often when making code changes,
  and consider amending/squashing previous commits especially if actively
  iterating. If you find yourself in a headless git state -- you should
  probably be using jj.
- Use the `gh` CLI for all GitHub-related tasks (issues, PRs, searches, repo
  info, API queries). Prefer `--json` and `--jq` flags to control output and
  minimize context usage. Use `gh api graphql` for complex/nested queries.
  Prefer it over calling Fetch with a github.com URL. Never push, post, or
  comment without explicit user permission.
- Offer to use the Playwright CLI to verify browser apps are working as
  expected, when relevant.
  - Backups: Playwright MCP, Chrome
- Always use Context7 MCP when needing library/API documentation, code
  generation, setup, or configuration steps without having to explicitly ask.
- When running servers that listen on a local port, prefer running them with
  [portless](https://github.com/vercel-labs/portless) for stable named
  .localhost URLs. Run it with, e.g., `portless run vite` so it can inject the
  port in, and detect + add workspace name into the URL.
