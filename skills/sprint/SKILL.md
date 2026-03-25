# /sprint - Team Coordination & Planning

Plan work, check team workload, identify conflicts, and schedule merges.

## Usage

```
/sprint
/sprint status
/sprint plan PROJ-123
```

## Arguments

- No args: Show current sprint status
- `status`: Detailed team workload view
- `plan TICKET`: Plan when to work on a specific ticket

## Instructions

You are a sprint coordinator managing a team of 4 (1 lead + 3 devs). Your job is to:
- Show what everyone is working on
- Identify potential merge conflicts
- Suggest optimal timing for work

### 1. Load Team Configuration

Read team members from config:
```bash
cat .dev-team/team.json
```

### 2. Fetch Team Workload

For each team member, get their in-progress tickets:

```bash
# Get issues for each team member by account ID
.dev-team/lib/jira.sh user-issues "ACCOUNT_ID" "In Progress"
```

Also check:
- Tickets in "In Review" status
- Recently completed tickets (last 24h)

### 3. Analyze Active Work

For each in-progress ticket, identify:
- Which files are being modified (from subtask dev notes)
- Current branch name
- PR status if exists

```bash
# Check for open PRs
gh pr list --author USERNAME --state open
```

### 4. Conflict Detection

Compare file lists across team members' work:

**Potential conflicts when:**
- Same file modified by multiple people
- Same module/directory touched
- Dependent changes (A needs B's work)

Output conflict warnings:
```
⚠️  Potential Conflict:
    Alice (PROJ-123): modifying src/services/user.ts
    Bob (PROJ-456): modifying src/services/user.ts

    Recommendation: Alice should merge first (PR is ready)
```

### 5. Sprint Status Output

```
=== Sprint Status ===

Team Workload:
┌─────────┬────────────┬──────────────────────────────┬──────────┐
│ Member  │ Role       │ Current Task                 │ Status   │
├─────────┼────────────┼──────────────────────────────┼──────────┤
│ Alice   │ Lead       │ PROJ-123: Auth middleware    │ In PR    │
│ Bob     │ Developer  │ PROJ-124: Login endpoints    │ Coding   │
│ Carol   │ Developer  │ PROJ-125: Protected routes   │ Blocked  │
│ Dan     │ Developer  │ PROJ-126: Auth tests         │ Ready    │
└─────────┴────────────┴──────────────────────────────┴──────────┘

Merge Queue:
1. Alice's PR #42 - Ready to merge
2. Bob's PR #43 - Needs review (blocks Carol)

Conflicts: None detected

Recommendations:
- Merge Alice's PR first
- Bob's work blocks Carol - prioritize review
- Dan can start auth tests now
```

### 6. Plan Specific Ticket

When given `/sprint plan PROJ-123`:

1. Check who is available (no in-progress work)
2. Check dependencies (does this need other work done first?)
3. Check for file conflicts with ongoing work
4. Suggest assignee and timing

```
=== Plan: PROJ-127 (Add e2e auth tests) ===

Dependencies:
  ✓ PROJ-123 (Auth middleware) - Merged
  ✓ PROJ-124 (Login endpoints) - In PR, merge today
  ○ PROJ-125 (Protected routes) - In progress

Can start: After PROJ-125 merges (Carol's work)

Best assignee: Dan (available, no conflicts)

File conflicts: None with current work

Recommendation:
  Assign to Dan, start tomorrow after Carol merges
```

### 7. Deployment Planning

If asked about deployment timing:

```bash
# Check recent merges to main
git log main --oneline -10

# Check CI status
gh run list --limit 5
```

Suggest deploy windows based on:
- All PRs merged and passing
- No in-progress dependent work
- Team availability for rollback support

## Allowed Tools

- Bash (for Jira API, git, gh CLI)
- Read (for config files, dev notes)
- Glob/Grep (for finding modified files)
