---
name: using-atomic-commit
description: Enforces fast, 1-line atomic git commits immediately upon completing verified units of work without narrative token waste.
---

<EXTREMELY-IMPORTANT>
Whenever a discrete feature, bug fix, refactoring, or documentation task is verified and completed, you MUST execute an atomic git commit immediately.

Do NOT wait for the session to end. Do NOT waste tokens outputting multi-paragraph commit summaries to the user.
</EXTREMELY-IMPORTANT>

## Atomic Commit Rules

1. **Commit Timing**: Commit immediately after a logical unit of work is finished and verified.
2. **One-Line Message Standard**: Use the standard format `type: short description` (under 72 characters).
   - `feat`: New feature or capability
   - `fix`: Bug fix or error resolution
   - `refactor`: Code restructuring without behavior change
   - `docs`: Documentation updates
   - `style`: Formatting, whitespace, UI styling
   - `test`: Adding or updating tests
   - `chore`: Maintenance, dependencies, config edits
3. **No Prose Waste**: Execute `git commit -m "type: short description"` directly via terminal without explaining the commit in chat text unless requested.
