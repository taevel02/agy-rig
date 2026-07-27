#!/usr/bin/env bash

# Antigravity Personal Environment Setup Script
# Configures symlinks from agy-rig repository to ~/.gemini/config/

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

echo "=========================================="
echo " Antigravity Environment Setup"
echo " Repo Dir  : ${SCRIPT_DIR}"
echo " Target Dir: ${TARGET_DIR}"
if [ "$DRY_RUN" = true ]; then
    echo " MODE      : DRY-RUN (Preview Only)"
else
    echo " MODE      : INSTALLATION"
fi
echo "=========================================="

make_symlink() {
    local src="$1"
    local dst="$2"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] Ensure directory: ${dst_dir}"
        echo "[DRY-RUN] Create symlink : ${dst} -> ${src}"
    else
        mkdir -p "${dst_dir}"
        if [ -e "${dst}" ] || [ -L "${dst}" ]; then
            rm -rf "${dst}"
        fi
        ln -sfn "${src}" "${dst}"
        echo "[SUCCESS] Linked ${dst} -> ${src}"
    fi
}

# 1. Base Config Files
make_symlink "${SCRIPT_DIR}/config/mcp_config.json" "${TARGET_DIR}/mcp_config.json"
make_symlink "${SCRIPT_DIR}/config/hooks.json" "${TARGET_DIR}/hooks.json"
make_symlink "${SCRIPT_DIR}/config/GEMINI.md" "${TARGET_DIR}/GEMINI.md"

# 2. Hooks
make_symlink "${SCRIPT_DIR}/hooks/session-start.sh" "${TARGET_DIR}/hooks/session-start.sh"

# 3. Rules
make_symlink "${SCRIPT_DIR}/rules/korean-ux.md" "${TARGET_DIR}/rules/korean-ux.md"

# 4. Plugins
make_symlink "${SCRIPT_DIR}/plugins/waza" "${TARGET_DIR}/plugins/waza"

# 5. Built-in Skills (All under skills/)
if [ -d "${SCRIPT_DIR}/skills/simplify" ]; then
    make_symlink "${SCRIPT_DIR}/skills/simplify" "${TARGET_DIR}/skills/simplify"
fi

if [ -d "${SCRIPT_DIR}/skills/caveman" ]; then
    make_symlink "${SCRIPT_DIR}/skills/caveman" "${TARGET_DIR}/skills/caveman"
fi

if [ -d "${SCRIPT_DIR}/skills/using-superpowers" ]; then
    make_symlink "${SCRIPT_DIR}/skills/using-superpowers" "${TARGET_DIR}/skills/using-superpowers"
fi

echo ""
if [ "$DRY_RUN" = true ]; then
    echo "Dry-run complete. No changes were made."
else
    echo "Installation complete. Antigravity environment is configured!"
fi
