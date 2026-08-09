# AGY Rig

**AGY Rig** is an automated, modular configuration repository for Google Antigravity (AGY) CLI. It provides custom session lifecycle hooks, token-saving terse response modes, Korean UX enforcement, MCP server integrations, and upstream engineering skills.

---

## Features

- **Automated Symlink Setup (`install.sh`)**: One-command installation linking configs & individual skills to `~/.gemini/config/` with `--dry-run` preview support.
- **Smart Session Initialization (`hooks/session-start.sh`)**:
  - **Caveman Full Mode**: Default terse, token-efficient communication.
  - **Korean UX Enforcement**: Mandatory Korean responses for AI output while preserving technical symbols/code in English.
  - **Atomic Commit Enforcement**: Automatic loading of `using-atomic-commit` skill for fast 1-line commits.
- **Upstream Integrations**: Git Submodules tracking `tw93/Waza` and `coreyhaines31/marketingskills` with individual skill symlinking and automatic `git pull` updates on install.
- **Configured MCP Servers**:
  - `chrome-devtools`: `chrome-devtools-mcp`
  - `context7`: `ctx7`
  - `playwright`: `@playwright/mcp@latest`

---

## Installation

### Preview Setup (Dry-Run)
Inspect what symlinks will be created without modifying the filesystem:
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

| Command / Skill | Source | Purpose |
| :--- | :--- | :--- |
| `/think` | Waza | Pre-build planning, architecture design & decision validation |
| `/check` | Waza | Code review, diff inspection, release gates & project audit |
| `/hunt` | Waza | Root cause diagnosis, bug fix & regression investigation |
| `/ui` | Waza | UI/UX design, visual polish & component styling |
| `/write` | Waza | Technical documentation, release notes & copywriting |
| `/learn` | Waza | Deep research, synthesizing material & compiling sources |
| `/read` | Waza | Extracting web URLs & reading PDF documents |
| `/health` | Waza | Engineering health audit & config drift check |
| Marketing Skills (50+) | MarketingSkills | Comprehensive growth & marketing skills (copywriting, seo-audit, launch, ads, etc.) |
| `/caveman` | Local | Switch communication intensity (`lite`, `full`, `ultra`) |
| `/simplify` | Local | Refactor code for clarity without altering behavior |
| `/using-superpowers` | Local | Meta-skill enforcing skill invocation before action |
| `/using-atomic-commit` | Local | Enforces 1-line atomic commits conforming to Conventional Commits v1.0.0 |


---

## License

This project is licensed under the [MIT License](LICENSE).
