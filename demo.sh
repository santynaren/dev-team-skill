#!/bin/bash
# Demo script - shows what the dev-team skills output looks like
# Run with: .dev-team/demo.sh

set -e
cd "$(dirname "$0")/.."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m' # No Color

# Enable mock mode
export JIRA_MOCK=1

clear
echo ""
echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BLUE}║             🚀 dev-team Skills Demo                          ║${NC}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

sleep 1

# ============================================================
# SKILL 0: /setup
# ============================================================
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${CYAN}  /setup - Environment Verification${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 0.5

echo -e "${DIM}Checking configuration...${NC}"
sleep 0.3
echo ""

echo -e "${BOLD}=== Dev-Team Setup Status ===${NC}"
echo ""
echo -e "${BOLD}Configuration:${NC}"
echo -e "  ${GREEN}✓${NC} config.json found"
echo -e "  ${GREEN}✓${NC} team.json found (4 members)"
echo ""

sleep 0.5
echo -e "${BOLD}Access:${NC}"
echo -e "  ${GREEN}✓${NC} Jira API connected as ${CYAN}\"Demo Developer\"${NC} [MOCK MODE]"
echo -e "  ${GREEN}✓${NC} GitHub CLI authenticated as ${CYAN}@demo-dev${NC}"
echo ""

sleep 0.5
echo -e "${BOLD}Tech Stack Detected:${NC}"
echo -e "  Runtime:   ${CYAN}Node.js 20 (bun)${NC}"
echo -e "  Framework: ${CYAN}Next.js 14, React 18${NC}"
echo -e "  Testing:   ${CYAN}Playwright, Jest${NC}"
echo -e "  Build:     ${CYAN}Turbo${NC}"
echo ""

echo -e "${GREEN}Ready to use /breakdown, /sprint, /implement, /validate${NC}"
echo ""

read -p "Press Enter to see /breakdown demo..."
echo ""

# ============================================================
# SKILL 1: /breakdown
# ============================================================
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${CYAN}  /breakdown DEMO-100 - Ticket Breakdown${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 0.5

echo -e "${DIM}Fetching ticket DEMO-100...${NC}"
sleep 0.5
echo -e "${DIM}Analyzing codebase for affected files...${NC}"
sleep 0.5
echo -e "${DIM}Creating subtasks in Jira...${NC}"
sleep 0.5
echo ""

echo -e "${BOLD}=== Ticket Breakdown: DEMO-100 ===${NC}"
echo ""
echo -e "${YELLOW}\"Add user authentication to the API\"${NC}"
echo ""
echo -e "${BOLD}Created 4 subtasks:${NC}"
echo ""

echo -e "  ${CYAN}1.${NC} ${BOLD}DEMO-101:${NC} Set up JWT authentication middleware"
echo -e "     ${DIM}Files: src/middleware/auth.ts, src/utils/jwt.ts${NC}"
echo ""
echo -e "  ${CYAN}2.${NC} ${BOLD}DEMO-102:${NC} Create login/logout API endpoints"
echo -e "     ${DIM}Files: src/routes/auth.ts, src/services/auth.service.ts${NC}"
echo ""
echo -e "  ${CYAN}3.${NC} ${BOLD}DEMO-103:${NC} Add protected route wrapper component"
echo -e "     ${DIM}Files: src/components/ProtectedRoute.tsx, src/hooks/useAuth.ts${NC}"
echo ""
echo -e "  ${CYAN}4.${NC} ${BOLD}DEMO-104:${NC} Write authentication tests"
echo -e "     ${DIM}Files: src/tests/auth.test.ts, e2e/auth.spec.ts${NC}"
echo ""

echo -e "${BOLD}Suggested order:${NC} 1 → 2 → 3 → 4"
echo -e "${BOLD}Dependencies:${NC} None identified"
echo ""

read -p "Press Enter to see /sprint demo..."
echo ""

# ============================================================
# SKILL 2: /sprint
# ============================================================
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${CYAN}  /sprint - Team Coordination${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 0.5

echo -e "${DIM}Fetching team workload...${NC}"
sleep 0.5
echo -e "${DIM}Checking for conflicts...${NC}"
sleep 0.3
echo ""

echo -e "${BOLD}=== Sprint Status ===${NC}"
echo ""
echo -e "${BOLD}Team Workload:${NC}"
echo ""
echo "┌──────────────┬────────────┬────────────────────────────────────┬────────────┐"
echo "│ Member       │ Role       │ Current Task                       │ Status     │"
echo "├──────────────┼────────────┼────────────────────────────────────┼────────────┤"
echo -e "│ Alice Chen   │ ${CYAN}Lead${NC}       │ DEMO-101: JWT middleware           │ ${GREEN}Done${NC}       │"
echo -e "│ Bob Martinez │ Developer  │ DEMO-102: Login endpoints          │ ${YELLOW}Coding${NC}     │"
echo -e "│ Carol Singh  │ Developer  │ DEMO-103: Protected routes         │ ${DIM}Waiting${NC}    │"
echo -e "│ Dan Kim      │ Developer  │ DEMO-104: Auth tests               │ ${DIM}Ready${NC}      │"
echo "└──────────────┴────────────┴────────────────────────────────────┴────────────┘"
echo ""

echo -e "${BOLD}Merge Queue:${NC}"
echo -e "  ${GREEN}1.${NC} Alice's PR #42 - ${GREEN}Ready to merge${NC}"
echo -e "  ${YELLOW}2.${NC} Bob's PR #43 - ${YELLOW}Needs review${NC} (blocks Carol)"
echo ""

echo -e "${BOLD}Conflicts:${NC} ${GREEN}None detected${NC}"
echo ""

echo -e "${BOLD}Recommendations:${NC}"
echo -e "  • Merge Alice's PR first"
echo -e "  • Bob's work blocks Carol - prioritize review"
echo -e "  • Dan can start auth tests after Bob merges"
echo ""

read -p "Press Enter to see /implement demo..."
echo ""

# ============================================================
# SKILL 3: /implement
# ============================================================
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${CYAN}  /implement DEMO-102 - Execute Implementation${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 0.5

echo -e "${DIM}Fetching subtask DEMO-102...${NC}"
sleep 0.3
echo -e "${DIM}Creating feature branch...${NC}"
sleep 0.3
echo -e "${DIM}Implementing changes...${NC}"
sleep 0.5
echo ""

echo -e "${BOLD}=== Implementation Complete: DEMO-102 ===${NC}"
echo ""
echo -e "${BOLD}Branch:${NC} feature/DEMO-102-login-endpoints"
echo -e "${BOLD}Commits:${NC} 3"
echo ""
echo -e "${BOLD}Files changed:${NC}"
echo -e "  ${GREEN}A${NC} src/routes/auth.ts"
echo -e "  ${GREEN}A${NC} src/services/auth.service.ts"
echo -e "  ${GREEN}A${NC} src/validators/auth.validator.ts"
echo -e "  ${YELLOW}M${NC} src/app.ts"
echo ""
echo -e "${BOLD}PR:${NC} ${CYAN}#43${NC} (https://github.com/demo-team/demo-app/pull/43)"
echo ""
echo -e "${BOLD}Tests:${NC} ${GREEN}✓ All passing${NC}"
echo ""
echo -e "${DIM}Next: Request review or run ${NC}/validate DEMO-102"
echo ""

read -p "Press Enter to see /validate demo..."
echo ""

# ============================================================
# SKILL 4: /validate
# ============================================================
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${CYAN}  /validate DEMO-102 - Test & Verify${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 0.5

echo -e "${DIM}Running existing tests...${NC}"
sleep 0.3
echo -e "${DIM}Analyzing coverage gaps...${NC}"
sleep 0.3
echo -e "${DIM}Adding e2e tests...${NC}"
sleep 0.3
echo -e "${DIM}Verifying PR checks...${NC}"
sleep 0.3
echo ""

echo -e "${BOLD}=== Validation: DEMO-102 ===${NC}"
echo ""
echo -e "${BOLD}PR:${NC} #43 (feature/DEMO-102-login-endpoints)"
echo ""
echo -e "${BOLD}Test Results:${NC}"
echo -e "  Unit tests:    ${GREEN}✓ 45/45 passing${NC}"
echo -e "  E2E tests:     ${GREEN}✓ 12/12 passing${NC}"
echo -e "  Coverage:      ${GREEN}87% (+5%)${NC}"
echo ""
echo -e "${BOLD}PR Checks:${NC}"
echo -e "  ${GREEN}✓${NC} build"
echo -e "  ${GREEN}✓${NC} lint"
echo -e "  ${GREEN}✓${NC} typecheck"
echo -e "  ${GREEN}✓${NC} test"
echo ""
echo -e "${BOLD}New E2E Tests Added:${NC}"
echo -e "  ${CYAN}e2e/auth.spec.ts${NC}"
echo -e "    ${GREEN}✓${NC} user can log in with valid credentials"
echo -e "    ${GREEN}✓${NC} shows error for invalid credentials"
echo -e "    ${GREEN}✓${NC} logout clears session"
echo ""
echo -e "${BOLD}Acceptance Criteria:${NC}"
echo -e "  ${GREEN}✓${NC} POST /api/auth/login accepts email and password"
echo -e "  ${GREEN}✓${NC} Returns JWT token on successful authentication"
echo -e "  ${GREEN}✓${NC} POST /api/auth/logout invalidates the token"
echo -e "  ${GREEN}✓${NC} Protected routes return 401 without valid token"
echo ""
echo -e "${BOLD}Status: ${GREEN}READY FOR MERGE${NC}"
echo ""
echo -e "${DIM}Jira updated with validation results.${NC}"
echo ""

echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BLUE}║                    Demo Complete!                            ║${NC}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "To use these skills in Claude Code, run:"
echo -e "  ${CYAN}/setup${NC}              - Check environment"
echo -e "  ${CYAN}/breakdown DEMO-100${NC} - Break down a ticket"
echo -e "  ${CYAN}/sprint${NC}             - See team status"
echo -e "  ${CYAN}/implement DEMO-102${NC} - Implement a subtask"
echo -e "  ${CYAN}/validate DEMO-102${NC}  - Test & verify"
echo ""
