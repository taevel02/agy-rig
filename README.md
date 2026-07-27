# AGY Rig: Personal Antigravity Development Environment

**AGY Rig** is an automated, modular configuration repository for Google Antigravity (AGY) CLI. It provides custom session lifecycle hooks, token-saving terse response modes, Korean UX enforcement, MCP server integrations, and upstream engineering skills (Waza, Caveman, Simplify, Superpowers).

---

## Key Features

- **Automated Symlink Setup (`install.sh`)**: One-command installation linking configs to `~/.gemini/config/` with full `--dry-run` preview support.
- **Smart Session Initialization (`hooks/session-start.sh`)**:
  - **Caveman Full Mode**: Default terse, token-efficient communication.
  - **Korean UX Enforcement**: Mandatory Korean responses for AI output while preserving technical symbols/code in English.
  - **Atomic Commit Standard**: Guidance for 1-line concise git commits.
  - **Git Worktree Preference**: Best-practice workflow for isolated task execution.
- **Upstream Waza Integration (`plugins/waza`)**: Git Submodule tracking `tw93/Waza` with automatic `git pull` updates on install.
- **Configured MCP Servers (`config/mcp_config.json`)**:
  - `chrome-devtools`: `chrome-devtools-mcp`
  - `context7`: `ctx7`
  - `playwright`: `@playwright/mcp@latest`

---

## Directory Architecture

```text
agy-rig/
├── install.sh                  # Setup script with --dry-run support
├── README.md                   # Environment documentation & reference
├── config/
│   ├── mcp_config.json         # MCP server configuration
│   └── hooks.json              # Lifecycle hook definitions
├── hooks/
│   └── session-start.sh        # PreInvocation session hook script
├── rules/
│   └── korean-ux.md            # Korean UX rule definition
├── plugins/
│   └── waza/                   # Upstream Waza skills git submodule
└── skills/
    ├── caveman/                # Terse communication skill (juliusbrussee/caveman)
    ├── simplify/               # Code refactoring & simplification skill
    └── using-superpowers/      # Meta-skill for skill discovery & anti-rationalization
```

---

## Available Skills Reference

| Command / Skill | Source | Purpose |
| :--- | :--- | :--- |
| `/waza:think` | Waza | Pre-build planning, architecture design & decision validation |
| `/waza:check` | Waza | Code review, diff inspection, release gates & project audit |
| `/waza:hunt` | Waza | Root cause diagnosis, bug fix & regression investigation |
| `/waza:ui` | Waza | UI/UX design, visual polish & component styling |
| `/waza:write` | Waza | Technical documentation, release notes & copywriting |
| `/waza:learn` | Waza | Deep research, synthesizing material & compiling sources |
| `/waza:read` | Waza | Extracting web URLs & reading PDF documents |
| `/waza:health` | Waza | Engineering health audit & config drift check |
| `/caveman` | Local | Switch communication intensity (`lite`, `full`, `ultra`) |
| `simplify` | Local | Refactor code for clarity without altering behavior |
| `using-superpowers` | Local | Meta-skill enforcing skill invocation before action |

---

## Installation & Usage

### 1. Preview Installation (Dry-Run)
Inspect what symlinks will be created without modifying the filesystem:
```bash
./install.sh --dry-run
```

### 2. Execute Installation
Apply configuration symlinks to `~/.gemini/config/`:
```bash
./install.sh
```

### 3. Update Environment & Skills
Pull latest Waza updates and re-apply configuration:
```bash
./install.sh
```

---

## License

MIT License
