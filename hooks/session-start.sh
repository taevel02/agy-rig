#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

read_skill_file() {
    local file="$1"
    local name="$2"
    if [ -f "$file" ]; then
        cat "$file"
    else
        echo "Error: ${name} skill file not found."
    fi
}

escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

using_superpowers_content=$(read_skill_file "${CONFIG_ROOT}/skills/using-superpowers/SKILL.md" "using-superpowers")
using_atomic_commit_content=$(read_skill_file "${CONFIG_ROOT}/skills/using-atomic-commit/SKILL.md" "using-atomic-commit")
caveman_content=$(read_skill_file "${CONFIG_ROOT}/skills/caveman/SKILL.md" "caveman")

using_superpowers_escaped=$(escape_for_json "$using_superpowers_content")
using_atomic_commit_escaped=$(escape_for_json "$using_atomic_commit_content")
caveman_escaped=$(escape_for_json "$caveman_content")

session_context="<EXTREMELY_IMPORTANT>
You have active skills initialized for this session.

**1. Below is the full content of your 'using-superpowers' skill:**
${using_superpowers_escaped}

**2. Below is the full content of your 'using-atomic-commit' skill:**
${using_atomic_commit_escaped}

**3. Below is the full content of your 'caveman' skill (ACTIVE MODE: caveman full):**
${caveman_escaped}

[Active Mode Mandate]
By default, apply the 'caveman full' mode rules from section 3 above to all responses to conserve token budget.
</EXTREMELY_IMPORTANT>"

session_context_escaped=$(escape_for_json "$session_context")

cat <<EOF
{
  "decision": "allow",
  "reason": "Session initialized with superpowers, atomic commit, and caveman full skill embeddings",
  "additionalContext": "$session_context_escaped"
}
EOF
