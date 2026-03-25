# /implement - Execute Code Changes

Implement the changes specified in a Jira subtask.

## Usage

```
/implement PROJ-124
```

## Arguments

- `SUBTASK_ID` (required): The Jira subtask key to implement

## Instructions

You are a developer implementing changes according to the action plan in a Jira subtask.

### 1. Fetch Subtask Details

Get the subtask from Jira:
```bash
.dev-team/lib/jira.sh issue SUBTASK_ID
```

Parse the description to extract:
- **Dev Notes**: Files to modify, related files
- **Action Plan**: Step-by-step implementation
- **Acceptance Criteria**: What must work

### 2. Setup Branch

Check current branch and create feature branch if needed:

```bash
# Current branch
git branch --show-current

# Create feature branch if not on one
git checkout -b feature/SUBTASK_ID
```

Branch naming convention:
- `feature/PROJ-124-short-description`
- `fix/PROJ-124-bug-description`

### 3. Understand Context

Before coding, read the files mentioned in Dev Notes:
- Understand existing patterns
- Note code style conventions
- Identify imports/dependencies needed

### 4. Implement Changes

Follow the action plan step by step:

**For each step:**
1. Read relevant file(s)
2. Make the change using Edit tool
3. Verify no syntax errors
4. Move to next step

**Best practices:**
- Follow existing code patterns in the repo
- Add TypeScript types if the project uses them
- Keep changes focused on the task
- Don't refactor unrelated code

### 5. Update Tests

If the action plan includes tests or test files are in Dev Notes:
- Add/update unit tests for new code
- Ensure existing tests still pass

Run tests:
```bash
# Detect and run appropriate test command
npm test  # or yarn test, pnpm test, bun test
```

### 6. Commit Changes

Create atomic commits with clear messages:

```bash
git add -A
git commit -m "feat(PROJ-124): implement login endpoint

- Add POST /api/auth/login route
- Implement JWT token generation
- Add input validation

Part of PROJ-123"
```

### 7. Push and Create PR

```bash
git push -u origin feature/PROJ-124
```

Create PR using gh CLI:
```bash
gh pr create --title "PROJ-124: Short description" --body "## Summary
Implements login endpoint for authentication feature.

## Changes
- Added login route handler
- JWT token generation utility
- Request validation middleware

## Testing
- Unit tests added
- Manual testing with curl

## Jira
[PROJ-124](https://yourcompany.atlassian.net/browse/PROJ-124)

## Checklist
- [ ] Tests pass
- [ ] No lint errors
- [ ] Ready for review"
```

### 8. Update Jira

Add implementation notes to the subtask:

```bash
.dev-team/lib/jira.sh comment "SUBTASK_ID" "Implementation complete. PR: #XX

Changes made:
- file1.ts: Added X
- file2.ts: Modified Y

Ready for review."
```

### 9. Output Summary

```
=== Implementation Complete: PROJ-124 ===

Branch: feature/PROJ-124-login-endpoint
Commits: 3

Files changed:
  M src/routes/auth.ts
  A src/services/auth.ts
  M src/tests/auth.test.ts

PR: #42 (https://github.com/org/repo/pull/42)

Tests: ✓ All passing

Next: Request review or run /validate PROJ-124
```

## Allowed Tools

- All tools (full implementation capability)
- Bash (git, tests, gh CLI, Jira)
- Read, Edit, Write (code changes)
- Glob, Grep (finding code)
- Task (for complex exploration)
