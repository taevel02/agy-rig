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

# 1. Initialize and Update Submodules
if [ -f "${SCRIPT_DIR}/.gitmodules" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo -e "${DIM}[INFO] Would initialize & update submodules via git submodule update --init --recursive${NC}\n"
    else
        echo -e "${BLUE}[UPDATE] Updating submodules...${NC}"
        git -C "${SCRIPT_DIR}" submodule update --init --recursive --quiet || echo -e "${YELLOW}[WARN] Failed submodule update${NC}"
        echo ""
    fi
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
echo -e "${BOLD}Global Agent Instructions (~/.codex/AGENTS.md)${NC}"
if [ -f "${SCRIPT_DIR}/config/AGENTS.md" ]; then
    make_symlink "${SCRIPT_DIR}/config/AGENTS.md" "${CODEX_HOME}/AGENTS.md"
fi

# Cleanup redundant instructions.md if present
if [ -e "${CODEX_HOME}/instructions.md" ] || [ -L "${CODEX_HOME}/instructions.md" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo -e "  ${YELLOW}[CLEAN DRY-RUN]${NC} Redundant instructions: ${CODEX_HOME}/instructions.md"
    else
        rm -rf "${CODEX_HOME}/instructions.md"
        echo -e "  ${RED}✗${NC} Removed redundant: ${CODEX_HOME}/instructions.md"
    fi
fi
echo ""

# 3. Clean up orphaned symlinks
echo -e "${BOLD}Cleaning Orphaned Paths${NC}"
if [ -d "${CODEX_HOME}/skills" ] && [ ! -L "${CODEX_HOME}/skills" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo -e "  ${YELLOW}[CLEAN DRY-RUN]${NC} Legacy real directory: ${CODEX_HOME}/skills"
    else
        rm -rf "${CODEX_HOME}/skills"
        echo -e "  ${RED}✗${NC} Removed legacy directory: ${CODEX_HOME}/skills"
    fi
fi
clean_orphans "${AGENTS_HOME}/skills"
echo ""

# 4. Discover and Install Skills (~/.agents/skills)
echo -e "${BOLD}Installing Skills (~/.agents/skills)${NC}"
mkdir -p "${AGENTS_HOME}/skills"
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
            fi
        done
    fi
done

# 5. Directory Link for Codex CLI Compatibility
if [ "$DRY_RUN" = true ]; then
    echo -e "\n  ${YELLOW}[DRY-RUN]${NC} Link ~/.codex/skills -> ~/.agents/skills"
else
    ln -sfn "${AGENTS_HOME}/skills" "${CODEX_HOME}/skills"
    echo -e "\n  ${GREEN}✓${NC} ${BOLD}Codex Skills Link${NC}\n     ${DIM}-> ~/.codex/skills -> ~/.agents/skills${NC}"
fi

echo ""
if [ "$DRY_RUN" = true ]; then
    echo -e "${GREEN}[OK] Dry-run preview complete.${NC}"
else
    echo -e "${GREEN}[OK] Codex environment setup complete.${NC}"
fi
