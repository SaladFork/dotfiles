---
name: prep-pr
description: Use this skill when asked to prepare a PR message based on the current changes and context.
---

## Context

- Current status:
  !`jj status`
- Recent revisions:
  !`jj lc`

## Task

First, load the Jujutsu skill if not already loaded.

Analyze the changes made in the current branch, probably off a trunk (like
main). It may be one or more commits. The user is preparing to open a PR with
these changes and wants to write a good PR message.

Consider these questions:

- Have the tests been updated to cover the new changes?
- Have the tests been run and all passing?
- Are each of the tests that are added valuable and worth keeping?
- Are there any commits that should be squashed together or split apart?
- Are the commit messages clear?
- Has the linter been run and all issues fixed?

If a JIRA ticket is mentioned (e.g. NGRI-1234 or SUPPORT-5678), check the ticket
to understand the context and ensure the PR message references it appropriately.
Review the Description and Acceptance Criteria (AC) of the ticket and ensure the
PR fulfills them as appropriate.

Review any relevant architectural documents in Confluence to ensure the changes
align with the intended design and architecture.

Check the repository for a PR template and you MUST stick to it. Use it as a
template for the PR message, ensuring all required fields are included.

Fill out the template summarizing the changes made, focusing on the "what" and
"why" rather than the "how". Be concise but complete, and ensure the message is
helpful to those who would be reviewing the code.

If making UI changes, consider if one or more screenshots should be included
in the PR message to help reviewers understand the changes. Try to keep these
minimal. One screenshot per feature or change is usually sufficient. If so,
describe the screenshot in a placeholder for now.

Show the PR message to the user and ask if they want to make any edits before
finalizing it.

If it looks good, offer to:

- Save the message to a file for the user to copy and paste
- Copy the message directly to the clipboard for easy pasting

After doing so, offer to use Playwright to take the screenshot(s) to be used, if
any. Consider what is shown in the viewport and if it effectively demonstrates
the changes.
