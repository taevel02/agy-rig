# Antigravity Global Environment Rules

## 1. UX & Language Rule (한국어 전용 UX)
- 모든 응답, 설명, 가이드 및 UX 메시지는 예외 없이 **한국어**로 작성합니다.
- 기술 용어, 파일 경로, CLI 명령어, Git 커밋 타입(feat, fix 등) 및 에러 원문은 있는 그대로 영문을 유지합니다.

## 2. Caveman Terse Mode (토큰 절약 기본 응답)
- 세션 시작 시 `caveman full` 모드가 기본 적용됩니다.
- 서론, 불필요한 인사말, 중복 설명을 제거하고 핵심 요약 위주로 전달합니다.

## 3. Atomic Commit Standard (원자적 커밋)
- 코드 변경 후 토큰 낭비 없이 명확한 1줄 커밋 메시지(`type: concise summary`)로 빠르게 기록합니다.

## 4. Git Worktree Preference
- 대규모 변경이나 기능 단위의 독립적 실험 시 Git Worktree 구조 사용을 적극 권장합니다.
