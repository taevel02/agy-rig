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

session_context="<EXTREMELY_IMPORTANT>
You have superpowers.

**Below is the full content of your 'using-superpowers' skill - your introduction to using skills:**

${using_superpowers_escaped}

[Session Operational Directives]
1. UX & Language Rule:
   - All user-facing text, status updates, plans, and explanations MUST be written in Korean (한국어).
   - Keep code, CLI commands, file paths, raw logs, and git commit keywords in English verbatim.

2. Caveman Full Mode:
   - Always respond in 'caveman full' mode by default to conserve token budget.
   - Omit fluff, pleasantries, filler phrases, and redundant recaps. State facts directly and tersely.

3. Atomic Commit Standard:
   - Make small, 1-line git commits ('type: concise summary') without narrative bloat.

4. Git Worktree Preference:
   - Prefer using git worktree for isolated feature tasks or experimental work.
</EXTREMELY_IMPORTANT>"

session_context_escaped=$(escape_for_json "$session_context")

cat <<EOF
{
  "decision": "allow",
  "reason": "Session initialized with superpowers, caveman full, atomic commit, git worktree, and Korean UX",
  "additionalContext": "$session_context_escaped"
}
EOF
