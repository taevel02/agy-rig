#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Read stdin if available
INPUT_JSON="{}"
if [ ! -t 0 ]; then
    RAW_INPUT="$(cat)"
    if [ -n "${RAW_INPUT// }" ]; then
        INPUT_JSON="$RAW_INPUT"
    fi
fi

INVOCATION_NUM=$(echo "$INPUT_JSON" | jq -r '.invocationNum // 1' 2>/dev/null || echo "1")

read_file() {
    local rel_path="$1"
    local full_path="${CONFIG_ROOT}/${rel_path}"
    if [ -f "$full_path" ]; then
        cat "$full_path"
    else
        echo ""
    fi
}

if [ "$INVOCATION_NUM" -le 1 ]; then
    SUPERPOWERS=$(read_file "skills/using-superpowers/SKILL.md")
    ATOMIC_COMMIT=$(read_file "skills/using-atomic-commit/SKILL.md")
    CAVEMAN=$(read_file "skills/caveman/SKILL.md")

    PROMPT=$(cat <<EOF
<EXTREMELY_IMPORTANT>
[ACTIVE SESSION MANDATE]
1. Korean UX Rule: All user-facing text, explanations, and plans MUST be rendered in Korean (keep code/commands/symbols in English).
2. Git Worktree & Submodule Awareness: Always maintain clean worktrees and handle submodules atomically.
3. Atomic Commits: After completing verified units of work, execute 1-line Conventional Commits immediately.
4. Caveman Mode (Full): Apply terse, token-saving responses.

**Active Skill Embeddings:**

### 1. using-superpowers
${SUPERPOWERS}

### 2. using-atomic-commit
${ATOMIC_COMMIT}

### 3. caveman (ACTIVE MODE: caveman full)
${CAVEMAN}
</EXTREMELY_IMPORTANT>
EOF
)
else
    PROMPT=$(cat <<EOF
<EXTREMELY_IMPORTANT>
[ACTIVE SESSION REMINDER]
- Korean UX: Answer in Korean (technical terms in English).
- Atomic Commits: Commit immediately upon completing verified units of work.
- Caveman Mode: Keep responses concise and token-efficient.
</EXTREMELY_IMPORTANT>
EOF
)
fi

jq -n --arg msg "$PROMPT" '{injectSteps: [{ephemeralMessage: $msg}]}'
