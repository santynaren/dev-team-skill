# /setup - Environment & Access Verification

Verify project configuration, Jira/GitHub access, and detect tech stack.

## When to Use

Run this skill first when:
- Setting up dev-team on a new project
- Troubleshooting access issues
- Onboarding a new team member

## Instructions

You are a setup assistant for the dev-team workflow. Perform these checks:

### 1. Configuration Files

Check if `.dev-team/config.json` exists:
- If missing, guide user to create it from `.dev-team/config.example.json`
- Validate it has `jira.baseUrl` and `jira.projectKey`

Check if `.dev-team/team.json` exists:
- If missing, guide user to create it from `.dev-team/team.example.json`
- Validate it has lead and members array

### 2. Environment Variables

Check required env vars are set:
```bash
echo "JIRA_EMAIL: ${JIRA_EMAIL:+set}"
echo "JIRA_API_TOKEN: ${JIRA_API_TOKEN:+set}"
```

If not set, instruct user:
```
export JIRA_EMAIL="your.email@company.com"
export JIRA_API_TOKEN="your_api_token"
```

### 3. Jira API Access

Test Jira connection:
```bash
.dev-team/lib/jira.sh test
```

If this fails, verify:
- API token is valid (generate at https://id.atlassian.com/manage-profile/security/api-tokens)
- Email matches Atlassian account
- baseUrl in config.json is correct

### 4. GitHub CLI Access

Check `gh` CLI authentication:
```bash
gh auth status
```

If not authenticated:
```bash
gh auth login
```

### 5. Tech Stack Detection

Analyze project to detect:

**Package managers & runtimes:**
- `package.json` → Node.js (check for npm/yarn/pnpm/bun)
- `pyproject.toml` or `requirements.txt` → Python
- `go.mod` → Go
- `Cargo.toml` → Rust

**Frameworks (from package.json dependencies):**
- react, next, vue, angular, svelte
- express, fastify, nest, hono
- django, fastapi, flask

**Test frameworks:**
- jest, vitest, mocha, playwright, cypress
- pytest, unittest

**Build tools:**
- webpack, vite, esbuild, turbo
- make, cargo, go build

### 6. Report Summary

Output a summary:
```
=== Dev-Team Setup Status ===

Configuration:
  ✓ config.json found
  ✓ team.json found (4 members)

Access:
  ✓ Jira API connected as "Your Name"
  ✓ GitHub CLI authenticated as @username

Tech Stack Detected:
  Runtime: Node.js 20 (bun)
  Framework: Next.js 14, React 18
  Testing: Playwright, Jest
  Build: Turbo

Ready to use /breakdown, /sprint, /implement, /validate
```

## Allowed Tools

- Bash (for running checks)
- Read (for config files)
- Glob (for detecting project files)
