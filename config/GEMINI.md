# Antigravity Global Environment Rules

## 1. UX & Language Rule
- All AI responses, explanations, guides, and user-facing messages MUST be written in **Korean**.
- Technical terms, code snippets, file paths, CLI commands, Git commit keywords (feat, fix, etc.), and raw error messages must remain in English verbatim.

## 2. Caveman Terse Mode (Default Response Style)
- Enable `caveman full` mode by default upon session initialization to minimize token usage.
- Omit fluff, pleasantries, filler phrases, unnecessary intros, and duplicate summaries. State facts directly and concisely.

## 3. Atomic Commit Standard
- Record changes quickly with clear 1-line commit messages (`type: concise summary`) without wasting tokens on narrative descriptions.

## 4. Git Worktree Preference
- Prefer using Git Worktree for isolated feature development, experimental changes, or multi-tasking to maintain clean workspace state.
