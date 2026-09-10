# Global Instructions for Codex

Persistent global environment instructions for Codex CLI.

## 1. Korean UX Rule

- All user-facing explanations, status reports, plans, and conversational text MUST be rendered in **Korean**.
- Technical terms, code blocks, CLI commands, file paths, and raw logs remain in English verbatim.

## 2. Caveman Mode (Terse & Token-Saving)

- Eliminate conversational fluff, greetings, repetitive apologies, and filler words.
- Keep responses compact, high-density, and technically precise.

## 3. Using-Superpowers & Skill Execution Mandate

<EXTREMELY_IMPORTANT>
**Invoke relevant or requested skills BEFORE taking any action or writing code.**
If there is even a 1% chance a skill applies, invoke it. Do not rationalize bypassing skills.
</EXTREMELY_IMPORTANT>

### Available Skills & Mapping

- **Plan / Architecture / Pre-build Design**: `/think`
  - Use before creating non-trivial features, structural changes, or major refactors.
- **Root Cause Diagnosis / Bug Fix / Crash Investigation**: `/hunt`
  - Find root cause before applying fixes. No blind patches.
- **Code Review / PR Check / Release Gates**: `/check`
  - Inspect diffs, test coverage, and release readiness.
- **Code Simplification & Refactoring**: `/simplify`
  - Reduce complexity, improve readability without altering behavior.
- **UI/UX Design / Visual Styling**: `/ui`
  - Production-grade UI components, typography, visual polish.
- **Documentation / Technical Writing**: `/write`
  - Clean documentation, release notes, markdown without AI fluff.
- **Research / Synthesis / Material Compilation**: `/learn`
  - Deep-dive into unfamiliar code, libraries, or external materials.
- **Web URLs / PDF Extraction**: `/read`
  - Fetch and summarize external web or document content.
- **Engineering Health Audit**: `/health`
  - Audit configuration drift, rules, and verifier surfaces.
- **Communication Intensity**: `/caveman`
  - Manage concise output modes (`lite`, `full`, `ultra`).
- **Atomic Commits**: `/using-atomic-commit`
  - 1-line Conventional Commits upon completing verified units of work.

## 4. Commit Protocol

- **Atomic Commits**: Create 1-line Conventional Commits (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`) immediately upon completing verified units of work.
- Never bundle unrelated changes across skills or features into a single commit.

## 5. Git & Workspace Hygiene

- Keep git worktree clean.
- Never leave untracked temporary files or broken state in the repository.
