#!/bin/bash
# ============================================
# CONFIGURATION INSTALLATION
# ============================================
# Copies configs to ~/. and creates backups
# - Files: replaced only if different
# - Directories: merge (preserves existing files)
#
# Usage:
#   ./install-configs.sh           # Install configs
#   ./install-configs.sh --dry-run # Simulate without modifying
#   ./install-configs.sh --no-backup # Without backup
#   ./install-configs.sh --help    # Help
# ============================================

set +e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_skip() { echo -e "${BLUE}[SKIP]${NC} $1"; }

BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
DRY_RUN=false
DO_BACKUP=true
BACKUP_CREATED=false

print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --dry-run    Simulate without modifying files"
    echo "  --no-backup  Do not create a backup"
    echo "  --help       Display this help message"
    echo ""
}

create_backup_dir() {
    if [ "$DO_BACKUP" = false ]; then
        return 0
    fi
    
    if [ "$BACKUP_CREATED" = false ]; then
        mkdir -p "$BACKUP_DIR"
        BACKUP_CREATED=true
        log_info "Backup directory: $BACKUP_DIR"
    fi
}

backup_file() {
    local target="$1"
    
    if [ "$DO_BACKUP" = false ]; then
        return 0
    fi
    
    if [ ! -f "$target" ] && [ ! -d "$target" ]; then
        return 0
    fi
    
    create_backup_dir
    
    local backup_path="$BACKUP_DIR/$(basename "$target")"
    
    if [ -f "$target" ]; then
        cp "$target" "$backup_path"
    elif [ -d "$target" ]; then
        cp -r "$target" "$backup_path"
    fi
}

# Check if two files are identical
files_identical() {
    local file1="$1"
    local file2="$2"
    
    if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
        return 1
    fi
    
    cmp -s "$file1" "$file2"
    return $?
}

# Install a single file (replace only if different)
install_single_file() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    if [ ! -f "$source" ]; then
        log_warn "Missing source: $source"
        return 1
    fi
    
    # If the file exists and is identical, skip it
    if [ -f "$target" ]; then
        if files_identical "$source" "$target"; then
            log_skip "$description (identical)"
            return 0
        fi
        
        # File is different, backup before replacing
        if [ "$DRY_RUN" = true ]; then
            log_info "[DRY-RUN] Replace: $target ($description)"
            return 0
        fi
        
        backup_file "$target"
    fi
    
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY-RUN] Copy: $source → $target ($description)"
        return 0
    fi
    
    local target_dir=$(dirname "$target")
    mkdir -p "$target_dir"
    cp "$source" "$target"
    log_info "Installed: $description"
}

# Install a directory (merge: add/replace files, preserve others)
install_directory() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    if [ ! -d "$source" ]; then
        log_warn "Missing source (directory): $source"
        return 1
    fi
    
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY-RUN] Merge directory: $source → $target ($description)"
        return 0
    fi
    
    # Create target directory if it doesn't exist
    mkdir -p "$target"
    
    # Iterate over source files
    local copied=0
    local skipped=0
    
    # Check if the source directory contains files
    local has_files=false
    for src_file in "$source"/*; do
        [ -e "$src_file" ] && has_files=true && break
    done
    
    if [ "$has_files" = false ]; then
        log_warn "Empty source directory: $source"
        return 0
    fi
    
    for src_file in "$source"/*; do
        [ -e "$src_file" ] || continue
        
        local filename=$(basename "$src_file")
        local tgt_file="$target/$filename"
        
        # Ignore node_modules and other unnecessary directories
        if [ "$filename" = "node_modules" ] || [ "$filename" = "bun.lock" ]; then
            continue
        fi
        
        if [ -f "$src_file" ]; then
            # It's a file
            if [ -f "$tgt_file" ]; then
                if files_identical "$src_file" "$tgt_file"; then
                    ((skipped++))
                    continue
                fi
                # File is different, backup before replacing
                backup_file "$tgt_file"
            fi
            
            cp "$src_file" "$tgt_file"
            ((copied++))
        elif [ -d "$src_file" ]; then
            # It's a subdirectory, recursive call
            install_directory "$src_file" "$tgt_file" "$filename"
        fi
    done
    
    if [ $copied -gt 0 ] || [ $skipped -gt 0 ]; then
        log_info "Installed: $description ($copied copied, $skipped identical)"
    fi
}

# Main installation function
install_file() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    if [ ! -f "$source" ] && [ ! -d "$source" ]; then
        log_warn "Missing source: $source"
        return 1
    fi
    
    if [ -d "$source" ]; then
        install_directory "$source" "$target" "$description"
    else
        install_single_file "$source" "$target" "$description"
    fi
}

install_configs() {
    log_info "Installing configurations..."
    echo ""
    
    log_info "Copying configs to ~/"
    echo ""
    
    install_file "$SCRIPT_DIR/configs/bash/bashrc" "$HOME/.bashrc" "Bash RC"
    install_file "$SCRIPT_DIR/configs/nvim" "$HOME/.config/nvim" "Neovim config (legacy)"
    install_file "$SCRIPT_DIR/configs/nvim-lazyvim" "$HOME/.config/nvim-lazyvim" "LazyVim config (primary)"
    install_file "$SCRIPT_DIR/configs/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf" "Kitty terminal"
    install_file "$SCRIPT_DIR/configs/zellij/config.kdl" "$HOME/.config/zellij/config.kdl" "Zellij config"
    install_file "$SCRIPT_DIR/configs/zellij/layouts" "$HOME/.config/zellij/layouts" "Zellij layouts"
    install_file "$SCRIPT_DIR/configs/zellij/themes" "$HOME/.config/zellij/themes" "Zellij themes"
    install_file "$SCRIPT_DIR/configs/fzf/fzf.bash" "$HOME/.fzf.bash" "FZF bash"
    install_file "$SCRIPT_DIR/configs/opencode" "$HOME/.config/opencode" "Opencode config"
    install_file "$SCRIPT_DIR/configs/starship/starship.toml" "$HOME/.config/starship.toml" "Starship prompt"

    echo ""

    if [ "$BACKUP_CREATED" = true ]; then
        log_info "Backup created in: $BACKUP_DIR"
    fi

    log_info "Note: lazy.nvim auto-bootstraps on first launch (nvim or lvim)"
}

main() {
    for arg in "$@"; do
        case "$arg" in
            --dry-run) DRY_RUN=true ;;
            --no-backup) DO_BACKUP=false ;;
            --help) print_help; exit 0 ;;
            *) log_error "Unknown option: $arg"; print_help; exit 1 ;;
        esac
    done
    
    echo ""
    echo "========================================"
    echo "  CONFIGURATION INSTALLATION"
    echo "========================================"
    echo ""
    echo "Directory: $SCRIPT_DIR"
    [ "$DRY_RUN" = true ] && log_warn "DRY-RUN mode (simulation)"
    [ "$DO_BACKUP" = false ] && log_warn "Backup disabled"
    echo ""
    
    install_configs
    
    echo ""
    echo "========================================"
    echo "  ✅ DONE"
    echo "========================================"
    echo ""
    echo "Next step:"
    echo "  lvim  # LazyVim (primary config)"
    echo "  nvim  # Legacy config"
    echo ""
}

main "$@"
