#!/bin/bash
# ============================================
# INSTALLATION SCRIPT - Neovim IDE + Zellij
# ============================================
# Version: 4.0
# Last updated: March 2026
#
# Usage:
#   ./install.sh              # Install everything
#   ./install.sh --with-kitty # Also install Kitty terminal
#   ./install.sh --skip-deps  # Skip dependencies
#   ./install.sh --skip-configs # Skip configs
#   ./install.sh --skip-nvim  # Skip Neovim plugins
#   ./install.sh --force      # Reinstall everything
#   ./install.sh --help       # Help
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
log_step() { echo -e "${BLUE}[STEP]${NC} $1"; }

INSTALLED_ITEMS=""
add_installed() { INSTALLED_ITEMS="$INSTALLED_ITEMS\n  ✓ $1"; }

print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --skip-deps    Skip dependency installation"
    echo "  --skip-configs Skip configuration installation"
    echo "  --skip-nvim    Skip Neovim plugin installation"
    echo "  --with-kitty   Also install Kitty terminal (GPU-accelerated)"
    echo "  --force        Force reinstallation of all components"
    echo "  --help         Display this help message"
    echo ""
}

check_nvim() {
    if ! command -v nvim >/dev/null 2>&1; then
        log_error "Neovim is not installed. Install it first or use --skip-nvim."
        return 1
    fi
    return 0
}

install_nvim_plugins() {
    log_info "Bootstrapping lazy.nvim and installing Neovim plugins..."
    log_info "This may take a few minutes..."

    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    add_installed "Plugins Neovim (lazy.nvim)"
}

install_fzf() {
    if [ ! -d ~/.fzf ] || [ "$force" = true ]; then
        log_info "Installing fzf..."
        rm -rf ~/.fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        # Install binary only (no shell config overwrite)
        # This downloads the fzf binary to ~/.fzf/bin/ and generates
        # the shell scripts in ~/.fzf/shell/ (key-bindings, completion)
        ~/.fzf/install --bin
        add_installed "fzf (git)"
    else
        log_info "fzf already installed"
    fi
}

install_blesh() {
    if [ ! -f ~/.blesh/out/ble.sh ]; then
        log_info "Installing ble.sh..."
        rm -rf ~/.blesh
        git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git ~/.blesh
        cd ~/.blesh
        make
        cd "$SCRIPT_DIR"
        add_installed "ble.sh"
    elif [ "$force" = true ]; then
        log_info "Recompiling ble.sh..."
        cd ~/.blesh
        git pull
        make
        cd "$SCRIPT_DIR"
        add_installed "ble.sh (recompiled)"
    else
        log_info "ble.sh already installed"
    fi
}

install_cron() {
    local cron_cmd="/bin/bash $SCRIPT_DIR/update.sh >> $HOME/.local/log/update-configs.log 2>&1"
    local cron_entry="0 12 * * * $cron_cmd"

    # Check if cron job already exists
    if crontab -l 2>/dev/null | grep -qF "update.sh"; then
        log_info "Auto-update cron job already installed"
        return 0
    fi

    # Create log directory
    mkdir -p "$HOME/.local/log"

    # Add cron job (preserve existing entries)
    (crontab -l 2>/dev/null; echo "$cron_entry") | crontab -
    log_info "Cron job installed: daily at 12:00 (update.sh)"
    log_info "Logs: ~/.local/log/update-configs.log"
    add_installed "Auto-update cron job"
}

configure_zellij() {
    log_info "Configuring Zellij..."
    if [ -f ~/.config/zellij/config.kdl ]; then
        sed -i 's|default_shell "/bin/zsh"|default_shell "/bin/bash"|g' ~/.config/zellij/config.kdl 2>/dev/null || true
        add_installed "Zellij configured"
    fi
}

print_summary() {
    echo ""
    echo "========================================"
    echo "  INSTALLATION COMPLETE"
    echo "========================================"

    if [ -n "$INSTALLED_ITEMS" ]; then
        echo ""
        echo "Installed items:"
        echo -e "$INSTALLED_ITEMS"
    fi

    echo ""
    echo "NEXT STEPS:"
    echo ""
    echo "1. Reload your shell:"
    echo "   source ~/.bashrc"
    echo ""
    echo "2. Close and reopen your terminal (for ble.sh)"
    echo ""
    echo "3. Test:"
    echo "   nvim      # Editor (Neovim)"
    echo "   zellij    # Multiplexer"
    echo "   opencode  # AI Assistant"
    echo ""
    echo "4. Documentation:"
    echo "   $SCRIPT_DIR/docs/VIM-GUIDE.md"
    echo "   $SCRIPT_DIR/docs/BASH-SHORTCUTS.md"
    echo ""
    echo "========================================"
}

main() {
    local skip_deps=false
    local skip_configs=false
    local skip_nvim=false
    local with_kitty=false
    local force=false

    for arg in "$@"; do
        case "$arg" in
            --skip-deps) skip_deps=true ;;
            --skip-configs) skip_configs=true ;;
            --skip-nvim) skip_nvim=true ;;
            --skip-vim) skip_nvim=true ;;  # Backward compatibility
            --with-kitty) with_kitty=true ;;
            --force) force=true ;;
            --help) print_help; exit 0 ;;
            *) log_error "Unknown option: $arg"; print_help; exit 1 ;;
        esac
    done

    echo ""
    echo "========================================"
    echo "  INSTALLATION NEOVIM IDE + ZELLIJ"
    echo "  Version 4.0 - March 2026"
    echo "========================================"
    echo ""
    echo "Path: $SCRIPT_DIR"
    echo ""

    # Step 1: System dependencies
    log_step "1/6 - System dependencies"
    if [ "$skip_deps" = false ]; then
        local deps_args=""
        [ "$with_kitty" = true ] && deps_args="--with-kitty"
        bash "$SCRIPT_DIR/install-deps.sh" $deps_args
        add_installed "System dependencies"
    else
        log_info "Dependencies skipped"
    fi

    # Step 2: Configurations
    echo ""
    log_step "2/6 - Configuration files"
    if [ "$skip_configs" = false ]; then
        bash "$SCRIPT_DIR/install-configs.sh"
        add_installed "Configuration files"
    else
        log_info "Configurations skipped"
    fi

    # Step 3: Neovim plugins
    echo ""
    log_step "3/6 - Plugins Neovim"
    if [ "$skip_nvim" = false ]; then
        if check_nvim; then
            install_nvim_plugins
        fi
    else
        log_info "Neovim plugins skipped"
    fi

    # Step 4: Additional tools
    echo ""
    log_step "4/6 - Additional tools"
    install_fzf
    install_blesh
    configure_zellij

    # Step 5: Auto-update cron job
    echo ""
    log_step "5/6 - Auto-update cron job"
    install_cron

    # Step 6: Summary
    echo ""
    log_step "6/6 - Summary"
    print_summary
}

main "$@"
