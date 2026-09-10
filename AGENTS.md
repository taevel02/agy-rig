# AGENTS.md

Repository guidelines for agents working on this repository (Codex Rig).

## Core Context

Modular configuration repository tailored specifically for Codex CLI. It provisions global instructions, Korean UX, terse communication (caveman), engineering skills (Waza + local core), and automated symlinks to `~/.codex/` and `~/.agents/skills/`.

## Workflows & Verification

### 1. Configuration & Symlink Management
- **Script**: `install.sh` handles symlinking to `~/.codex/` and `~/.agents/skills/` with submodule auto-updates and orphan cleanup.
- **Verification**: Run `./install.sh --dry-run` before applying symlink or structure changes.

### 2. Custom Skills & Instructions
- **Skills**: Local core skills in `skills/` (`caveman`, `simplify`, `using-atomic-commit`, `using-superpowers`). Upstream engineering skills in `plugins/waza` (`think`, `hunt`, `check`, `ui`, `read`, `learn`, `health`, `write`).
- **Global Instructions**: `config/AGENTS.md` deployed to `~/.codex/AGENTS.md`.
- **Verification**: Validate shell scripts using `bash -n <script.sh>` after editing.

### 3. Commit Protocol
- **Atomic Commits**: Create 1-line Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`) upon completing verified units of work (`using-atomic-commit`).
