#!/bin/bash
# Jira API Helper for dev-team
# Requires: JIRA_EMAIL, JIRA_API_TOKEN, and config.json with jira.baseUrl
# Set JIRA_MOCK=1 to use mock data for testing

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/../config.json"
MOCK_DIR="$SCRIPT_DIR/../mock"

# Check if mock mode is enabled
is_mock() {
    [[ "$JIRA_MOCK" == "1" ]] || [[ "$JIRA_MOCK" == "true" ]]
}

# Load base URL from config
get_base_url() {
    if [[ -f "$CONFIG_FILE" ]]; then
        grep -o '"baseUrl"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | head -1 | sed 's/.*"baseUrl"[[:space:]]*:[[:space:]]*"\([^"]*\)"/\1/'
    else
        echo ""
    fi
}

# Create auth header
get_auth() {
    if is_mock; then
        echo "bW9jazptb2Nr"  # mock:mock in base64
        return
    fi
    if [[ -z "$JIRA_EMAIL" || -z "$JIRA_API_TOKEN" ]]; then
        echo "Error: JIRA_EMAIL and JIRA_API_TOKEN must be set" >&2
        exit 1
    fi
    echo -n "$JIRA_EMAIL:$JIRA_API_TOKEN" | base64
}

# GET request
jira_get() {
    local endpoint="$1"

    if is_mock; then
        mock_get "$endpoint"
        return
    fi

    local base_url=$(get_base_url)
    if [[ -z "$base_url" ]]; then
        echo "Error: Jira base URL not configured in config.json" >&2
        exit 1
    fi

    curl -s -X GET \
        -H "Authorization: Basic $(get_auth)" \
        -H "Content-Type: application/json" \
        "${base_url}/rest/api/3${endpoint}"
}

# POST request
jira_post() {
    local endpoint="$1"
    local data="$2"

    if is_mock; then
        mock_post "$endpoint" "$data"
        return
    fi

    local base_url=$(get_base_url)
    if [[ -z "$base_url" ]]; then
        echo "Error: Jira base URL not configured in config.json" >&2
        exit 1
    fi

    curl -s -X POST \
        -H "Authorization: Basic $(get_auth)" \
        -H "Content-Type: application/json" \
        -d "$data" \
        "${base_url}/rest/api/3${endpoint}"
}

# PUT request
jira_put() {
    local endpoint="$1"
    local data="$2"

    if is_mock; then
        mock_put "$endpoint" "$data"
        return
    fi

    local base_url=$(get_base_url)
    if [[ -z "$base_url" ]]; then
        echo "Error: Jira base URL not configured in config.json" >&2
        exit 1
    fi

    curl -s -X PUT \
        -H "Authorization: Basic $(get_auth)" \
        -H "Content-Type: application/json" \
        -d "$data" \
        "${base_url}/rest/api/3${endpoint}"
}

# Mock GET handler
mock_get() {
    local endpoint="$1"

    case "$endpoint" in
        /myself)
            cat <<'EOF'
{
  "accountId": "mock-user-001",
  "displayName": "Demo Developer",
  "emailAddress": "demo@devteam.local"
}
EOF
            ;;
        /issue/DEMO-100)
            cat "$MOCK_DIR/issues/DEMO-100.json"
            ;;
        /issue/DEMO-101|/issue/DEMO-102|/issue/DEMO-103|/issue/DEMO-104)
            local issue_id="${endpoint##*/}"
            cat "$MOCK_DIR/issues/${issue_id}.json"
            ;;
        /search*)
            cat "$MOCK_DIR/search-results.json"
            ;;
        *)
            echo '{"message": "Mock endpoint not found: '"$endpoint"'"}'
            ;;
    esac
}

# Mock POST handler
mock_post() {
    local endpoint="$1"
    local data="$2"

    case "$endpoint" in
        /issue)
            # Simulate creating a subtask
            local next_id=$((RANDOM % 100 + 200))
            cat <<EOF
{
  "id": "${next_id}",
  "key": "DEMO-${next_id}",
  "self": "https://mock.atlassian.net/rest/api/3/issue/${next_id}"
}
EOF
            echo "[MOCK] Created subtask DEMO-${next_id}" >&2
            ;;
        /issue/*/comment)
            cat <<EOF
{
  "id": "$((RANDOM % 10000))",
  "created": "$(date -u +%Y-%m-%dT%H:%M:%S.000+0000)"
}
EOF
            echo "[MOCK] Comment added" >&2
            ;;
        *)
            echo '{"message": "Mock POST endpoint not found: '"$endpoint"'"}'
            ;;
    esac
}

# Mock PUT handler
mock_put() {
    local endpoint="$1"
    echo "[MOCK] PUT to $endpoint" >&2
    echo '{"status": "ok"}'
}

# Test connection
jira_test() {
    local result=$(jira_get "/myself")
    if echo "$result" | grep -q '"accountId"'; then
        local name=$(echo "$result" | grep -o '"displayName"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"displayName"[[:space:]]*:[[:space:]]*"\([^"]*\)"/\1/')
        if is_mock; then
            echo "Connected as: $name [MOCK MODE]"
        else
            echo "Connected as: $name"
        fi
        return 0
    else
        echo "Connection failed: $result" >&2
        return 1
    fi
}

# Get issue details
jira_get_issue() {
    local issue_key="$1"
    jira_get "/issue/${issue_key}"
}

# Create subtask
jira_create_subtask() {
    local parent_key="$1"
    local summary="$2"
    local description="$3"
    local project_key=$(echo "$parent_key" | cut -d'-' -f1)

    local data=$(cat <<EOF
{
    "fields": {
        "project": { "key": "$project_key" },
        "parent": { "key": "$parent_key" },
        "summary": "$summary",
        "description": {
            "type": "doc",
            "version": 1,
            "content": [
                {
                    "type": "paragraph",
                    "content": [
                        { "type": "text", "text": "$description" }
                    ]
                }
            ]
        },
        "issuetype": { "name": "Sub-task" }
    }
}
EOF
)
    jira_post "/issue" "$data"
}

# Add comment to issue
jira_add_comment() {
    local issue_key="$1"
    local comment="$2"

    local data=$(cat <<EOF
{
    "body": {
        "type": "doc",
        "version": 1,
        "content": [
            {
                "type": "paragraph",
                "content": [
                    { "type": "text", "text": "$comment" }
                ]
            }
        ]
    }
}
EOF
)
    jira_post "/issue/${issue_key}/comment" "$data"
}

# Get issues assigned to user
jira_get_my_issues() {
    local status="${1:-In Progress}"
    jira_get "/search?jql=assignee=currentUser()%20AND%20status='${status}'&fields=key,summary,status"
}

# Get issues for a specific user by account ID
jira_get_user_issues() {
    local account_id="$1"
    local status="${2:-In Progress}"
    jira_get "/search?jql=assignee='${account_id}'%20AND%20status='${status}'&fields=key,summary,status,assignee"
}

# Export functions for sourcing
export -f jira_get jira_post jira_put jira_test jira_get_issue jira_create_subtask jira_add_comment jira_get_my_issues jira_get_user_issues 2>/dev/null || true

# If run directly, execute command
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    case "$1" in
        test) jira_test ;;
        get) jira_get "$2" ;;
        post) jira_post "$2" "$3" ;;
        put) jira_put "$2" "$3" ;;
        issue) jira_get_issue "$2" ;;
        subtask) jira_create_subtask "$2" "$3" "$4" ;;
        comment) jira_add_comment "$2" "$3" ;;
        my-issues) jira_get_my_issues "$2" ;;
        user-issues) jira_get_user_issues "$2" "$3" ;;
        *)
            echo "Usage: jira.sh {test|get|post|put|issue|subtask|comment|my-issues|user-issues}"
            echo ""
            echo "Set JIRA_MOCK=1 for mock mode (testing without real Jira)"
            ;;
    esac
fi
