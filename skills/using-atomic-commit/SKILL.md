---
name: using-atomic-commit
description: Enforces fast, 1-line atomic git commits conforming strictly to Conventional Commits v1.0.0 upon completing verified units of work.
---

<EXTREMELY-IMPORTANT>
Whenever a discrete feature, bug fix, refactoring, or documentation task is verified and completed, you MUST execute an atomic git commit conforming strictly to Conventional Commits v1.0.0 immediately.

Do NOT wait for the session to end. Do NOT waste tokens outputting multi-paragraph commit summaries in chat.
</EXTREMELY-IMPORTANT>

## Conventional Commits v1.0.0 Specification

Commit messages MUST strictly follow the format:

`<type>[optional scope]: <description>`

### 1. Structural Types
- `feat`: A new feature (corresponds to SemVer `MINOR`)
- `fix`: A bug fix (corresponds to SemVer `PATCH`)
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `build`: Changes that affect the build system or external dependencies
- `ci`: Changes to CI configuration scripts and workflows
- `chore`: Other changes that don't modify src or test files

### 2. Optional Scope
- A noun describing the affected module/component enclosed in parentheses.
- Examples: `feat(auth): add JWT login endpoint`, `fix(ui): adjust button padding`

### 3. Breaking Changes (`!`)
- Append `!` before the colon for breaking API/schema changes.
- Example: `feat(api)!: change user model primary key schema`

### 4. Format Directives
- **Imperative mood**: Use imperative lower-case description (e.g., `add` not `added`, `fix` not `fixes`).
- **No trailing period**: Do not place a period at the end of the commit summary line.
- **Length**: Keep the summary line under 72 characters.
- **No Chat Waste**: Execute `git commit -m "<type>[scope]: <description>"` directly via terminal without narrative chat text unless requested.
