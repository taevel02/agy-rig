#!/usr/bin/env bash

# Codex Environment Setup Script

set -euo pipefail

# ANSI Color Codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
DIM='\033[2m'
BOLD='\033[1m'
NC='\033[0m'

DRY_RUN=false
for arg in "$@"; do
    case $arg in
        --dry-run|-d)
            DRY_RUN=true
            shift
            ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEX_HOME="${HOME}/.codex"
AGENTS_HOME="${HOME}/.agents"

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}[DRY-RUN] Previewing Codex environment setup...${NC}\n"
else
    echo -e "${CYAN}[SETUP] Installing Codex environment...${NC}\n"
fi

# 1. Update Submodules
if [ -d "${SCRIPT_DIR}/plugins" ]; then
    for plugin_dir in "${SCRIPT_DIR}/plugins/"*; do
        if [ -d "${plugin_dir}/.git" ]; then
            plugin_name="$(basename "${plugin_dir}")"
            if [ "$DRY_RUN" = true ]; then
                echo -e "${DIM}[INFO] Would update plugin ${plugin_name} via git pull${NC}\n"
            else
                echo -e "${BLUE}[UPDATE] Pulling ${plugin_name} updates...${NC}"
                git -C "${plugin_dir}" pull --quiet || echo -e "${YELLOW}[WARN] Failed ${plugin_name} git pull${NC}"
                echo ""
            fi
        fi
    done
fi

make_symlink() {
    local src="$1"
    local dst="$2"
    local name
    name="$(basename "$src")"
    local dst_dir
    dst_dir="$(dirname "$dst")"
    local rel_dst="${dst#$HOME/}"

    if [ "$DRY_RUN" = true ]; then
        echo -e "  ${YELLOW}[DRY-RUN]${NC} ${BOLD}${name}${NC}\n     ${DIM}-> ~/${rel_dst}${NC}"
    else
        mkdir -p "${dst_dir}"
        if [ -e "${dst}" ] || [ -L "${dst}" ]; then
            rm -rf "${dst}"
        fi
        ln -sfn "${src}" "${dst}"
        echo -e "  ${GREEN}✓${NC} ${BOLD}${name}${NC}\n     ${DIM}-> ~/${rel_dst}${NC}"
    fi
}

clean_orphans() {
    local dir="$1"
    [ -d "$dir" ] || return 0

    for link in "$dir"/*; do
        if [ -L "$link" ] && [ ! -e "$link" ]; then
            if [ "$DRY_RUN" = true ]; then
                echo -e "  ${YELLOW}[CLEAN DRY-RUN]${NC} Orphaned link: ${link}"
            else
                rm -f "$link"
                echo -e "  ${RED}✗${NC} Removed orphaned link: ${link}"
            fi
        fi
    done
}

# 2. Global Instructions (AGENTS.md)
echo -e "${BOLD}Global Agent Instructions${NC}"
if [ -f "${SCRIPT_DIR}/config/AGENTS.md" ]; then
    make_symlink "${SCRIPT_DIR}/config/AGENTS.md" "${CODEX_HOME}/AGENTS.md"
    make_symlink "${SCRIPT_DIR}/config/AGENTS.md" "${CODEX_HOME}/instructions.md"
fi
echo ""

# 3. Clean up orphaned symlinks
echo -e "${BOLD}Checking Orphaned Symlinks${NC}"
clean_orphans "${AGENTS_HOME}/skills"
clean_orphans "${CODEX_HOME}/skills"
echo ""

# 4. Discover and Install Skills
echo -e "${BOLD}Installing Skills (~/.agents/skills & ~/.codex/skills)${NC}"
SKILL_DIRS=("${SCRIPT_DIR}/skills")
if [ -d "${SCRIPT_DIR}/plugins" ]; then
    for plugin_skills in "${SCRIPT_DIR}/plugins/"*/skills; do
        if [ -d "${plugin_skills}" ]; then
            SKILL_DIRS+=("${plugin_skills}")
        fi
    done
fi

for skill_dir in "${SKILL_DIRS[@]}"; do
    if [ -d "${skill_dir}" ]; then
        for skill_path in "${skill_dir}/"*; do
            if [ -d "${skill_path}" ]; then
                skill_name="$(basename "${skill_path}")"
                make_symlink "${skill_path}" "${AGENTS_HOME}/skills/${skill_name}"
                make_symlink "${skill_path}" "${CODEX_HOME}/skills/${skill_name}"
            fi
        done
    fi
done

echo ""
if [ "$DRY_RUN" = true ]; then
    echo -e "${GREEN}[OK] Dry-run preview complete.${NC}"
else
    echo -e "${GREEN}[OK] Codex environment setup complete.${NC}"
fi
