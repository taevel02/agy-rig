#!/usr/bin/env bash

# Antigravity Personal Environment Setup Script

set -euo pipefail

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
    echo "[DRY-RUN] Previewing Antigravity environment setup..."
else
    echo "[SETUP] Installing Antigravity environment..."
fi

# Auto-update Waza plugin
if [ -d "${SCRIPT_DIR}/plugins/waza/.git" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] Would pull latest Waza updates via git"
    else
        echo "[UPDATE] Pulling Waza updates..."
        git -C "${SCRIPT_DIR}/plugins/waza" pull --quiet || echo "[WARN] Failed Waza git pull"
    fi
fi

make_symlink() {
    local src="$1"
    local dst="$2"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] Link: ${dst} -> ${src}"
    else
        mkdir -p "${dst_dir}"
        if [ -e "${dst}" ] || [ -L "${dst}" ]; then
            rm -rf "${dst}"
        fi
        ln -sfn "${src}" "${dst}"
        echo "[LINKED] ${dst#$HOME/} -> ${src}"
    fi
}

# Config files
make_symlink "${SCRIPT_DIR}/config/mcp_config.json" "${TARGET_DIR}/mcp_config.json"
make_symlink "${SCRIPT_DIR}/config/hooks.json" "${TARGET_DIR}/hooks.json"

# Hooks & Rules
make_symlink "${SCRIPT_DIR}/hooks/session-start.sh" "${TARGET_DIR}/hooks/session-start.sh"
make_symlink "${SCRIPT_DIR}/rules/korean-ux.md" "${TARGET_DIR}/rules/korean-ux.md"

# Plugins
if [ -d "${SCRIPT_DIR}/plugins/waza" ]; then
    make_symlink "${SCRIPT_DIR}/plugins/waza" "${TARGET_DIR}/plugins/waza"
fi

# Local Skills
if [ -d "${SCRIPT_DIR}/skills" ]; then
    for skill_path in "${SCRIPT_DIR}/skills/"*; do
        if [ -d "${skill_path}" ]; then
            skill_name="$(basename "${skill_path}")"
            make_symlink "${skill_path}" "${TARGET_DIR}/skills/${skill_name}"
        fi
    done
fi

# Waza Skills
if [ -d "${SCRIPT_DIR}/plugins/waza/skills" ]; then
    for skill_path in "${SCRIPT_DIR}/plugins/waza/skills/"*; do
        if [ -d "${skill_path}" ]; then
            skill_name="$(basename "${skill_path}")"
            make_symlink "${skill_path}" "${TARGET_DIR}/skills/${skill_name}"
        fi
    done
fi

echo ""
if [ "$DRY_RUN" = true ]; then
    echo "[OK] Dry-run preview complete."
else
    echo "[OK] Antigravity environment setup complete."
fi
