# /breakdown - Jira Ticket Breakdown

Break down a Jira ticket into subtasks with dev notes and action plans.

## Usage

```
/breakdown PROJ-123
```

## Arguments

- `TICKET_ID` (required): The Jira ticket key (e.g., PROJ-123)

## Instructions

You are a technical lead breaking down a Jira ticket for implementation. Follow this process:

### 1. Fetch Ticket Details

Use the Jira helper to get ticket info:
```bash
.dev-team/lib/jira.sh issue TICKET_ID
```

Extract:
- Summary (title)
- Description
- Acceptance criteria
- Any linked tickets or dependencies

### 2. Analyze Codebase Impact

Based on the ticket requirements, explore the codebase to identify:

**Files likely to change:**
- Search for related components, services, APIs
- Look for existing patterns similar to what's needed
- Identify test files that will need updates

**Dependencies:**
- Other modules this change might affect
- Shared utilities or types
- Configuration files

Use Glob and Grep to find relevant files:
```bash
# Example: finding related components
glob "**/*user*.{ts,tsx}"
grep "authentication" --type ts
```

### 3. Create Subtasks

Break the ticket into logical subtasks. Each subtask should be:
- Completable in 1-4 hours
- Independently testable
- Clear scope

For each subtask, create in Jira with:

**Summary:** Clear, actionable title

**Description format:**
```
## Dev Notes
Files to modify:
- src/components/Feature.tsx
- src/services/api.ts
- src/tests/feature.test.ts

Related files (reference):
- src/types/feature.ts
- src/utils/helpers.ts

## Action Plan
1. Step one description
2. Step two description
3. Step three description

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
```

Use the Jira helper:
```bash
.dev-team/lib/jira.sh subtask "PARENT-KEY" "Subtask summary" "Description with dev notes"
```

### 4. Typical Subtask Pattern

For a feature ticket, typical subtasks:
1. **Backend/API changes** - Data layer, API endpoints
2. **Frontend components** - UI implementation
3. **Integration** - Connect frontend to backend
4. **Tests** - Unit and integration tests
5. **Documentation** - Update docs if needed

### 5. Update Parent Ticket

Add a comment to the parent ticket summarizing:
- Number of subtasks created
- Estimated complexity
- Any blockers or dependencies identified
- Suggested order of implementation

```bash
.dev-team/lib/jira.sh comment "TICKET_ID" "Breakdown complete: X subtasks created..."
```

### 6. Output Summary

```
=== Ticket Breakdown: PROJ-123 ===

"Add user authentication to API"

Created 4 subtasks:

1. PROJ-124: Set up JWT authentication middleware
   Files: src/middleware/auth.ts, src/utils/jwt.ts

2. PROJ-125: Create login/logout API endpoints
   Files: src/routes/auth.ts, src/services/auth.ts

3. PROJ-126: Add protected route wrapper component
   Files: src/components/ProtectedRoute.tsx

4. PROJ-127: Write authentication tests
   Files: src/tests/auth.test.ts, e2e/auth.spec.ts

Suggested order: 1 → 2 → 3 → 4
Dependencies: None identified
```

## Allowed Tools

- Bash (for Jira API calls)
- Read (for understanding existing code)
- Glob (for finding files)
- Grep (for searching code patterns)
- Task/Explore (for codebase analysis)
