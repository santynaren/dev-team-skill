# dev-team-skill

Claude Code skills for Jira-integrated dev team workflows. Drop this into any project to get `/breakdown`, `/sprint`, `/implement`, and `/validate` slash commands.

## Skills

| Skill | Usage | Description |
|-------|-------|-------------|
| `/setup` | `/setup` | Verify Jira/GitHub access and detect tech stack |
| `/breakdown` | `/breakdown PROJ-123` | Break a Jira ticket into subtasks with dev notes |
| `/sprint` | `/sprint` | Show team workload, merge queue, and conflicts |
| `/implement` | `/implement PROJ-124` | Implement a subtask: branch, code, PR |
| `/validate` | `/validate PROJ-124` | Run tests, check coverage, verify PR checks |

## Setup

### 1. Add to your project

Clone or copy this directory into your project root as `.dev-team`:

```bash
git clone https://github.com/santynaren/dev-team-skill .dev-team
```

### 2. Configure

```bash
cp .dev-team/config.example.json .dev-team/config.json
cp .dev-team/team.example.json .dev-team/team.json
```

Edit `config.json`:
```json
{
  "jira": {
    "baseUrl": "https://yourcompany.atlassian.net",
    "projectKey": "PROJ"
  },
  "github": {
    "repo": "org/repo-name"
  }
}
```

Edit `team.json` with your team members.

### 3. Set environment variables

```bash
export JIRA_EMAIL="your.email@company.com"
export JIRA_API_TOKEN="your_api_token"
```

Get your Jira API token at: https://id.atlassian.com/manage-profile/security/api-tokens

### 4. Verify setup

In Claude Code, run:
```
/setup
```

## Demo

Run the interactive demo to see all skills in action (uses mock Jira data):

```bash
.dev-team/demo.sh
```

## Workflow

```
/setup              # one-time: verify access + detect stack
/breakdown PROJ-100 # break ticket into subtasks
/sprint             # see who's doing what
/implement PROJ-101 # implement a subtask (branch → code → PR)
/validate PROJ-101  # run tests, verify acceptance criteria
```

## Requirements

- [Claude Code](https://claude.ai/code)
- [GitHub CLI](https://cli.github.com/) (`gh`)
- Jira account with API token
- `curl` and `jq`
