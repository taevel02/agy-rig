# AGENTS.md

Repository guidelines for agents working on `agy-rig`.

## Core Context

`agy-rig` is a modular configuration repository for Antigravity (AGY) CLI. It provisions rules, hooks, custom skills, submodules (`plugins/`), and symlinks to `~/.gemini/config/`.

## Workflows & Verification

### 1. Configuration & Symlink Management
- **Script**: `install.sh` handles symlinking and submodule initialization.
- **Verification**: Run `./install.sh --dry-run` before applying symlink or structure changes.

### 2. Custom Skills, Rules & Hooks
- **Skills**: Add local skills in `skills/`. Upstream skills sit in `plugins/waza` and `plugins/marketingskills` (submodules).
- **Hooks**: `hooks/session-start.sh` handles `PreInvocation` events, injecting session policies.
- **Verification**: Validate shell scripts using `bash -n <script.sh>` after editing.

### 3. Commit Protocol
- **Atomic Commits**: Create 1-line Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`) upon completing verified units of work (`using-atomic-commit`).
