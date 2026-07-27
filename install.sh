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
    echo -e "${YELLOW}🔍 DRY-RUN PREVIEW: Antigravity Environment Setup${NC}\n"
else
    echo -e "${CYAN}🚀 Installing Antigravity Environment...${NC}\n"
fi

# Auto-update Waza plugin
if [ -d "${SCRIPT_DIR}/plugins/waza/.git" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo -e "${DIM}ℹ Would update Waza plugin via git pull${NC}\n"
    else
        echo -e "${BLUE}🔄 Updating Waza plugin...${NC}"
        git -C "${SCRIPT_DIR}/plugins/waza" pull --quiet || echo -e "${YELLOW}⚠ Failed Waza git pull${NC}"
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
        echo -e "  ${YELLOW}🔍${NC} ${BOLD}${name}${NC}\n     ${DIM}-> ~/${rel_dst}${NC}"
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
echo -e "${BOLD}📦 Core Configurations${NC}"
make_symlink "${SCRIPT_DIR}/config/mcp_config.json" "${TARGET_DIR}/mcp_config.json"
make_symlink "${SCRIPT_DIR}/config/hooks.json" "${TARGET_DIR}/hooks.json"
echo ""

# 2. Hooks & Rules
echo -e "${BOLD}⚙️  Hooks & Rules${NC}"
make_symlink "${SCRIPT_DIR}/hooks/session-start.sh" "${TARGET_DIR}/hooks/session-start.sh"
make_symlink "${SCRIPT_DIR}/rules/korean-ux.md" "${TARGET_DIR}/rules/korean-ux.md"
echo ""

# 3. Plugins
echo -e "${BOLD}🔌 Plugins${NC}"
if [ -d "${SCRIPT_DIR}/plugins/waza" ]; then
    make_symlink "${SCRIPT_DIR}/plugins/waza" "${TARGET_DIR}/plugins/waza"
fi
echo ""

# 4. Skills
echo -e "${BOLD}⚡ Skills${NC}"
if [ -d "${SCRIPT_DIR}/skills" ]; then
    for skill_path in "${SCRIPT_DIR}/skills/"*; do
        if [ -d "${skill_path}" ]; then
            make_symlink "${skill_path}" "${TARGET_DIR}/skills/$(basename "${skill_path}")"
        fi
    done
fi

if [ -d "${SCRIPT_DIR}/plugins/waza/skills" ]; then
    for skill_path in "${SCRIPT_DIR}/plugins/waza/skills/"*; do
        if [ -d "${skill_path}" ]; then
            make_symlink "${skill_path}" "${TARGET_DIR}/skills/$(basename "${skill_path}")"
        fi
    done
fi

echo ""
if [ "$DRY_RUN" = true ]; then
    echo -e "${GREEN}✨ Dry-run preview complete!${NC}"
else
    echo -e "${GREEN}✨ Antigravity environment setup complete!${NC}"
fi
