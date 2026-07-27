#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

superpowers_file="${CONFIG_ROOT}/skills/using-superpowers/SKILL.md"
if [ -f "$superpowers_file" ]; then
    using_superpowers_content=$(cat "$superpowers_file")
else
    using_superpowers_content="Error: using-superpowers skill file not found."
fi

atomic_commit_file="${CONFIG_ROOT}/skills/using-atomic-commit/SKILL.md"
if [ -f "$atomic_commit_file" ]; then
    using_atomic_commit_content=$(cat "$atomic_commit_file")
else
    using_atomic_commit_content="Error: using-atomic-commit skill file not found."
fi

caveman_file="${CONFIG_ROOT}/skills/caveman/SKILL.md"
if [ -f "$caveman_file" ]; then
    caveman_content=$(cat "$caveman_file")
else
    caveman_content="Error: caveman skill file not found."
fi

escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

using_superpowers_escaped=$(escape_for_json "$using_superpowers_content")
using_atomic_commit_escaped=$(escape_for_json "$using_atomic_commit_content")
caveman_escaped=$(escape_for_json "$caveman_content")

session_context="<EXTREMELY_IMPORTANT>
You have active skills for session initialization.

**1. Below is the full content of your 'using-superpowers' skill:**
${using_superpowers_escaped}

**2. Below is the full content of your 'using-atomic-commit' skill:**
${using_atomic_commit_escaped}

**3. Below is the full content of your 'caveman' skill (ACTIVE MODE: caveman full):**
${caveman_escaped}

[Session Operational Directives]
1. UX & Language Rule:
   - All user-facing text, status updates, plans, and explanations MUST be written in Korean (한국어).
   - Keep code, CLI commands, file paths, raw logs, and git commit keywords in English verbatim.

2. Caveman Full Mode Mandate:
   - Apply 'caveman full' mode rules from section 3 above to ALL responses by default to conserve token budget.
</EXTREMELY_IMPORTANT>"

session_context_escaped=$(escape_for_json "$session_context")

cat <<EOF
{
  "decision": "allow",
  "reason": "Session initialized with superpowers, atomic commit, caveman full skill embedding, and Korean UX",
  "additionalContext": "$session_context_escaped"
}
EOF
