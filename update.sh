#!/bin/bash
# ============================================
# CONFIGURATION UPDATE (secondary machines)
# ============================================
# Pulls latest configs from remote and applies them.
# Designed to run via cron on machines that only receive updates.
#
# Usage:
#   ./update.sh           # Pull + apply configs
#   ./update.sh --dry-run # Show what would change without applying
#
# Cron example:
#   0 12 * * * /bin/bash /path/to/dev-environment/update.sh >> ~/.local/log/update-configs.log 2>&1
# ============================================

set -e

# Ensure PATH is set for cron environment
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $(date '+%d/%m/%Y %H:%M') - $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $(date '+%d/%m/%Y %H:%M') - $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $(date '+%d/%m/%Y %H:%M') - $1"; }

DRY_RUN=false

for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=true ;;
    esac
done

echo ""
echo "========================================"
echo "  CONFIG UPDATE"
echo "========================================"
echo ""

cd "$REPO_DIR"

# Step 1: Pull latest changes
log_info "Pulling latest changes..."

BEFORE=$(git rev-parse HEAD)

if ! git pull --ff-only 2>&1; then
    log_error "git pull failed (diverged history?). Run 'git pull' manually."
    exit 1
fi

AFTER=$(git rev-parse HEAD)

if [ "$BEFORE" = "$AFTER" ]; then
    log_info "Already up to date. No changes to apply."
    exit 0
fi

# Show what changed
CHANGES=$(git log --oneline "$BEFORE".."$AFTER")
log_info "New commits:"
echo "$CHANGES"
echo ""

# Step 2: Apply configs
if [ "$DRY_RUN" = true ]; then
    log_info "Dry-run mode: showing what would change..."
    bash "$REPO_DIR/install-configs.sh" --dry-run --no-backup
else
    log_info "Applying updated configs..."
    bash "$REPO_DIR/install-configs.sh" --no-backup
fi

echo ""
log_info "Update complete."
echo ""
