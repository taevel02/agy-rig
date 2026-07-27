#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

superpowers_file="${CONFIG_ROOT}/skills/using-superpowers/SKILL.md"
if [ -f "$superpowers_file" ]; then
    using_superpowers_content=$(cat "$superpowers_file")
else
    using_superpowers_content="using-superpowers skill content not found."
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
[세션 자동 활성화 규칙 & 슈퍼파워 가이드]

1. 한국어 UX 및 언어 규칙:
   - 모든 답변, UI 출력, 설명은 예외 없이 '한국어'로 작성하십시오.
   - 단, 코드, CLI 명령어, 파일 경로, Git 커밋 타입(feat, fix 등), 에러 로그는 영문을 유지하십시오.

2. Caveman Full Mode 기본 적용:
   - 기본적으로 'caveman full' 모드로 응답하십시오.
   - 서론/인사말/중복 설명을 생략하고 핵심 단어 및 간결한 문장으로 답변하여 토큰 낭비를 방지하십시오.

3. Atomic Commit (원자적 커밋):
   - 변경 사항은 빠르게 1줄 커밋 메시지(예: feat: add new hook)로 기록하십시오.

4. Git Worktree 선호:
   - 독립적인 작업 단위 작성 시 Git Worktree 사용을 우선 고려하십시오.

5. Using Superpowers 가이드:
${using_superpowers_escaped}
</EXTREMELY_IMPORTANT>"

session_context_escaped=$(escape_for_json "$session_context")

cat <<EOF
{
  "decision": "allow",
  "reason": "Session initialized with caveman full, atomic commit, git worktree, and Korean UX",
  "additionalContext": "$session_context_escaped"
}
EOF
