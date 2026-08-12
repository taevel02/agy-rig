# AGY Rig

**AGY Rig** is an automated, modular configuration repository for Google Antigravity (AGY) CLI. It provides custom session lifecycle hooks, token-saving terse response modes, Korean UX enforcement, MCP server integrations, and upstream engineering & marketing skills.

---

## Features

- **Automated Symlink Setup (`install.sh`)**: One-command installation linking core configs, rules, hooks, and individual skills to `~/.gemini/config/` with `--dry-run` preview support.
- **Smart Session Lifecycle Hooks (`hooks/session-start.sh`)**:
  - **Antigravity CLI Lifecycle Hook Compliance**: Built on the standard `PreInvocation` event contract using `ephemeralMessage` step injection.
  - **Dynamic Context Injection**: Injects full skill embeddings on `invocationNum == 1` and concise reminders on subsequent steps.
  - **Caveman Full Mode**: Default terse, token-efficient communication.
  - **Korean UX Enforcement**: Mandatory Korean responses for AI output while preserving technical symbols, code, and raw logs in English.
  - **Atomic Commit Enforcement**: Automatic loading of `using-atomic-commit` skill for fast 1-line Conventional Commits v1.0.0.
  - **Git Worktree & Submodule Awareness**: Maintains clean worktrees and handles submodules safely.
- **Upstream Plugin Integrations**: Git Submodules tracking upstream skill repositories with individual skill symlinking and automatic `git pull` updates on install:
  - `tw93/Waza` (`plugins/waza`)
  - `coreyhaines31/marketingskills` (`plugins/marketingskills`)
- **Configured MCP Servers**:
  - `chrome-devtools`: `chrome-devtools-mcp`
  - `context7`: `ctx7`
  - `playwright`: `@playwright/mcp@latest`

---

## Installation

### Preview Setup (Dry-Run)
Inspect what symlinks and plugin updates will be executed without modifying the filesystem:
```bash
./install.sh --dry-run
```

### Apply Configuration
Apply symlinks to `~/.gemini/config/`:
```bash
./install.sh
```

---

## Available Skills

| Category | Skill / Plugin | Purpose |
| :--- | :--- | :--- |
| **Waza Upstream** | `/think` | Pre-build planning, architecture design & decision validation |
| | `/check` | Code review, diff inspection, release gates & project audit |
| | `/hunt` | Root cause diagnosis, bug fix & regression investigation |
| | `/ui` | UI/UX design, visual polish & component styling |
| | `/write` | Technical documentation, release notes & copywriting |
| | `/learn` | Deep research, synthesizing material & compiling sources |
| | `/read` | Extracting web URLs & reading PDF documents |
| | `/health` | Engineering health audit & config drift check |
| **Marketing Skills** | MarketingSkills (50+) | Comprehensive growth & marketing skills (copywriting, seo-audit, launch, ads, cro, pricing, etc.) |
| **Local / Built-in Skills** | `/caveman` | Switch communication intensity (`lite`, `full`, `ultra`) |
| | `/simplify` | Refactor code for clarity without altering behavior |
| | `/using-superpowers` | Meta-skill enforcing skill invocation before action |
| | `/using-atomic-commit` | Enforces 1-line atomic commits conforming to Conventional Commits v1.0.0 |
| | `/writing-for-agents` | Guidelines for writing agent-consumable documents & skills |
| | `/apple-design` | Apple's fluid interface design & motion principles for web |

---

## References & Acknowledgements

- **[tw93/Waza](https://github.com/tw93/Waza)**: Upstream repository for core engineering workflow skills (`/think`, `/check`, `/hunt`, `/ui`, `/write`, `/learn`, `/read`, `/health`).
- **[coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills)**: Upstream repository for growth and marketing skills.
- **[emilkowalski/skills](https://github.com/emilkowalski/skills)**: Source reference for `/using-superpowers`, `/writing-for-agents`, `/caveman`, and `/apple-design` skills.

---

## License

This project is licensed under the [MIT License](LICENSE).
