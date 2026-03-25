# /validate - Test & Verify Implementation

Run tests, add e2e coverage, verify PR checks, and confirm ready for merge.

## Usage

```
/validate PROJ-124
/validate --full PROJ-124
```

## Arguments

- `SUBTASK_ID` (required): The Jira subtask to validate
- `--full`: Run full validation including e2e test creation

## Instructions

You are a QA engineer validating an implementation before merge.

### 1. Fetch Implementation Context

Get subtask details:
```bash
.dev-team/lib/jira.sh issue SUBTASK_ID
```

Get PR info:
```bash
gh pr list --search "SUBTASK_ID"
gh pr view PR_NUMBER
```

Get changed files:
```bash
gh pr diff PR_NUMBER --name-only
```

### 2. Run Existing Tests

Execute the test suite:

```bash
# Detect test runner
if [ -f "package.json" ]; then
    npm test
    # or: yarn test, pnpm test, bun test
elif [ -f "pyproject.toml" ]; then
    pytest
fi
```

Check for failures:
- If tests fail, identify the cause
- Determine if it's a regression or flaky test
- Report findings

### 3. Analyze Test Coverage

Check if new code has test coverage:

```bash
# Run coverage if available
npm run test:coverage
```

Identify gaps:
- New functions without tests
- New components without tests
- Edge cases not covered

### 4. Add Missing E2E Tests (if --full)

For Playwright projects:

**Analyze what needs e2e testing:**
- New user-facing features
- New API endpoints
- Changed user flows

**Create or update e2e tests:**

Read existing e2e patterns:
```bash
ls e2e/ tests/e2e/ playwright/
```

Write new e2e test following project conventions:

```typescript
// e2e/auth.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Authentication', () => {
  test('user can log in with valid credentials', async ({ page }) => {
    await page.goto('/login');
    await page.fill('[name="email"]', 'test@example.com');
    await page.fill('[name="password"]', 'password123');
    await page.click('button[type="submit"]');

    await expect(page).toHaveURL('/dashboard');
    await expect(page.locator('text=Welcome')).toBeVisible();
  });

  test('shows error for invalid credentials', async ({ page }) => {
    await page.goto('/login');
    await page.fill('[name="email"]', 'wrong@example.com');
    await page.fill('[name="password"]', 'wrongpass');
    await page.click('button[type="submit"]');

    await expect(page.locator('.error')).toContainText('Invalid');
  });
});
```

Run e2e tests:
```bash
npx playwright test
# or: npm run e2e, yarn e2e
```

### 5. Verify PR Checks

Check CI status:
```bash
gh pr checks PR_NUMBER
```

Wait for checks if still running:
```bash
gh pr checks PR_NUMBER --watch
```

Common checks to verify:
- Build passes
- Lint passes
- Unit tests pass
- E2E tests pass
- Type check passes

### 6. Manual Verification Checklist

Review against acceptance criteria from Jira:

```
Acceptance Criteria:
- [ ] User can log in with email/password
- [ ] Invalid credentials show error message
- [ ] Successful login redirects to dashboard
- [ ] JWT token stored in httpOnly cookie
```

### 7. Security Review

Quick security check:
- No secrets in code
- Input validation present
- No SQL/command injection risks
- Authentication/authorization correct

### 8. Update Jira with Results

```bash
.dev-team/lib/jira.sh comment "SUBTASK_ID" "Validation complete ✓

Test Results:
- Unit tests: ✓ 45/45 passing
- E2E tests: ✓ 12/12 passing
- Coverage: 87%

PR Checks:
- Build: ✓
- Lint: ✓
- TypeCheck: ✓

New tests added:
- e2e/auth.spec.ts (2 tests)

Ready for merge."
```

### 9. Output Summary

```
=== Validation: PROJ-124 ===

PR: #42 (feature/PROJ-124-login-endpoint)

Test Results:
  Unit tests:    ✓ 45/45 passing
  E2E tests:     ✓ 12/12 passing
  Coverage:      87% (+5%)

PR Checks:
  ✓ build
  ✓ lint
  ✓ typecheck
  ✓ test

New E2E Tests Added:
  e2e/auth.spec.ts
    ✓ user can log in with valid credentials
    ✓ shows error for invalid credentials

Acceptance Criteria:
  ✓ User can log in with email/password
  ✓ Invalid credentials show error message
  ✓ Successful login redirects to dashboard
  ✓ JWT token stored in httpOnly cookie

Status: READY FOR MERGE

Jira updated with validation results.
```

### 10. If Issues Found

If validation fails:
1. Document specific failures
2. Add comment to PR with findings
3. Update Jira with blocker status
4. Suggest fixes if obvious

```
=== Validation: PROJ-124 ===

Status: ISSUES FOUND

Failures:
  ✗ e2e/auth.spec.ts: login redirect test
    Expected URL: /dashboard
    Actual URL: /login (redirect not working)

  ✗ Coverage dropped: 82% (was 85%)
    Missing coverage: src/services/auth.ts lines 45-52

Recommendation:
  Fix redirect logic in src/routes/auth.ts:23
  Add test for token refresh edge case
```

## Allowed Tools

- All tools
- Bash (tests, git, gh CLI, Jira)
- Read, Edit, Write (for adding tests)
- Glob, Grep (finding test files)
