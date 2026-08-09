#!/usr/bin/env bash

# Antigravity Personal Environment Setup Script

set -euo pipefail

# ANSI Color Codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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
TARGET_DIR="${HOME}/.gemini/config"

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}[DRY-RUN] Previewing Antigravity environment setup...${NC}\n"
else
    echo -e "${CYAN}[SETUP] Installing Antigravity environment...${NC}\n"
fi

# Environment File Check (.env)
if [ ! -f "${SCRIPT_DIR}/.env" ] && [ -f "${SCRIPT_DIR}/.env.example" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo -e "${DIM}[INFO] Would create .env from .env.example${NC}\n"
    else
        cp "${SCRIPT_DIR}/.env.example" "${SCRIPT_DIR}/.env"
        echo -e "${BLUE}[CONFIG] Created .env template from .env.example${NC}\n"
    fi
fi

# Auto-update plugin submodules
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

# 1. Core Configurations
echo -e "${BOLD}Core Configurations${NC}"
make_symlink "${SCRIPT_DIR}/config/mcp_config.json" "${TARGET_DIR}/mcp_config.json"
make_symlink "${SCRIPT_DIR}/config/hooks.json" "${TARGET_DIR}/hooks.json"
echo ""

# 2. Hooks & Rules
echo -e "${BOLD}Hooks & Rules${NC}"
make_symlink "${SCRIPT_DIR}/hooks/session-start.sh" "${TARGET_DIR}/hooks/session-start.sh"
make_symlink "${SCRIPT_DIR}/rules/korean-ux.md" "${TARGET_DIR}/rules/korean-ux.md"
echo ""

# 3. Skills (Local & Plugin Upstreams)
echo -e "${BOLD}Skills${NC}"
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
                make_symlink "${skill_path}" "${TARGET_DIR}/skills/$(basename "${skill_path}")"
            fi
        done
    fi
done


echo ""
if [ "$DRY_RUN" = true ]; then
    echo -e "${GREEN}[OK] Dry-run preview complete.${NC}"
else
    echo -e "${GREEN}[OK] Antigravity environment setup complete.${NC}"
fi
