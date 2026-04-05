#!/bin/bash
# ============================================
# DEPENDENCY INSTALLATION
# ============================================
# Auto-detect OS, install everything needed

set +e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            debian|ubuntu|linuxmint|pop)
                echo "debian"
                ;;
            arch|manjaro|endeavouros)
                echo "arch"
                ;;
            fedora|rhel|centos)
                echo "fedora"
                ;;
            opensuse|sles)
                echo "suse"
                ;;
            *)
                echo "unknown"
                ;;
        esac
    else
        echo "unknown"
    fi
}

install_system_deps() {
    local os=$(detect_os)
    log_info "Installing system dependencies for $os..."
    
    case "$os" in
        debian)
            sudo apt update
            sudo apt install -y git curl wget build-essential cmake gawk luarocks ripgrep fd-find universal-ctags fzf direnv wl-clipboard
            ;;
        arch)
            sudo pacman -S --noconfirm git curl wget base-devel cmake gawk luarocks ripgrep fd universal-ctags fzf direnv wl-clipboard
            ;;
        fedora)
            sudo dnf install -y git curl wget cmake gcc gcc-c++ make gawk luarocks ripgrep fd-find universal-ctags fzf direnv wl-clipboard
            ;;
        suse)
            sudo zypper install -y git curl wget cmake gcc gcc-c++ make gawk luarocks ripgrep fd universal-ctags fzf direnv wl-clipboard
            ;;
        *)
            log_error "Unsupported OS: $os"
            log_error "Please install manually: git, curl, wget, build-essential, cmake, ripgrep, fd, universal-ctags, fzf, direnv, neovim (>= 0.10), wl-clipboard"
            return 1
            ;;
    esac
    log_info "System dependencies installed"
}

NVIM_MIN_VERSION="0.10.0"

# Compare two semver versions, returns 0 if $1 >= $2
version_gte() {
    printf '%s\n%s' "$2" "$1" | sort -V -C
}

install_neovim() {
    local need_install=false

    if command -v nvim >/dev/null 2>&1; then
        local current
        current=$(nvim --version | head -1 | grep -oP 'v\K[0-9]+\.[0-9]+\.[0-9]+')
        if version_gte "$current" "$NVIM_MIN_VERSION"; then
            log_info "Neovim already installed and up to date: v${current}"
            return 0
        else
            log_warn "Neovim v${current} too old (minimum required: v${NVIM_MIN_VERSION})"
            need_install=true
        fi
    else
        need_install=true
    fi

    if [ "$need_install" = true ]; then
        log_info "Installing Neovim from GitHub releases..."
        local arch=$(uname -m)

        case "$arch" in
            x86_64)
                local nvim_archive="nvim-linux-x86_64.tar.gz"
                local nvim_dir="nvim-linux-x86_64"
                ;;
            aarch64|arm64)
                local nvim_archive="nvim-linux-arm64.tar.gz"
                local nvim_dir="nvim-linux-arm64"
                ;;
            *)
                log_error "Unsupported architecture for Neovim: $arch"
                return 1
                ;;
        esac

        local version
        version=$(curl -sL "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4)

        log_info "Downloading Neovim ${version}..."
        wget -q "https://github.com/neovim/neovim/releases/download/${version}/${nvim_archive}" -O "/tmp/${nvim_archive}"
        if [ $? -ne 0 ] || [ ! -s "/tmp/${nvim_archive}" ]; then
            log_warn "Failed to download Neovim"
            return 1
        fi

        tar -xzf "/tmp/${nvim_archive}" -C /tmp
        if [ $? -ne 0 ]; then
            log_warn "Failed to extract Neovim"
            return 1
        fi

        sudo rm -rf /opt/nvim
        sudo mv "/tmp/${nvim_dir}" /opt/nvim
        sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
        rm -f "/tmp/${nvim_archive}"

        log_info "Neovim installed: $(nvim --version | head -1)"
    fi
}

install_nvm() {
    if [ -d "$HOME/.nvm" ]; then
        log_info "nvm already installed"
        return 0
    fi
    
    log_info "Installing nvm..."
    export NVM_DIR="$HOME/.nvm"
    
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
    fi
    
    log_info "nvm installed"
}

install_node() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    
    if command -v node >/dev/null 2>&1; then
        log_info "Node.js already installed: $(node --version)"
        return 0
    fi
    
    log_info "Installing Node.js LTS..."
    nvm install --lts
    nvm alias default lts/*
    nvm use default
    
    log_info "Node.js installed: $(node --version)"
}

install_yarn() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    
    if command -v yarn >/dev/null 2>&1; then
        log_info "Yarn already installed: $(yarn --version)"
        return 0
    fi
    
    log_info "Installing Yarn via corepack..."
    corepack enable
    corepack prepare yarn@stable --activate
    
    log_info "Yarn installed: $(yarn --version)"
}

install_zellij() {
    if command -v zellij >/dev/null 2>&1; then
        log_info "Zellij already installed: $(zellij --version)"
        return 0
    fi
    
    log_info "Installing Zellij..."
    local version
    version=$(curl -sL "https://api.github.com/repos/zellij-org/zellij/releases/latest" | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4 | sed 's/v//')
    local arch=$(uname -m)
    
    case "$arch" in
        x86_64)
            local arch_name="x86_64-unknown-linux-musl"
            ;;
        aarch64|arm64)
            local arch_name="aarch64-unknown-linux-musl"
            ;;
        *)
            log_error "Unsupported architecture: $arch"
            return 1
            ;;
    esac
    
    log_info "Downloading Zellij v${version}..."
    wget -q "https://github.com/zellij-org/zellij/releases/download/v${version}/zellij-${arch_name}.tar.gz" -O /tmp/zellij.tar.gz
    if [ $? -ne 0 ] || [ ! -s /tmp/zellij.tar.gz ]; then
        log_warn "Failed to download Zellij"
        return 1
    fi
    
    tar -xzf /tmp/zellij.tar.gz -C /tmp
    if [ $? -ne 0 ]; then
        log_warn "Failed to extract Zellij"
        return 1
    fi
    
    sudo mv /tmp/zellij /usr/local/bin/ 2>/dev/null
    if [ $? -ne 0 ]; then
        log_warn "Failed to install Zellij (sudo required)"
        rm -rf /tmp/zellij*
        return 1
    fi
    
    rm -rf /tmp/zellij*
    log_info "Zellij installed: $(zellij --version)"
}



install_kitty() {
    if command -v kitty >/dev/null 2>&1; then
        log_info "Kitty already installed: $(kitty --version)"
        return 0
    fi

    log_info "Installing Kitty terminal (GPU-accelerated)..."
    local os=$(detect_os)

    case "$os" in
        debian)
            sudo apt install -y kitty
            ;;
        arch)
            sudo pacman -S --noconfirm kitty
            ;;
        fedora)
            sudo dnf install -y kitty
            ;;
        suse)
            sudo zypper install -y kitty
            ;;
        *)
            # Fallback: official installer from kovidgoyal (works on any Linux)
            log_info "Using official Kitty installer..."
            curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
            mkdir -p ~/.local/bin
            ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
            ln -sf ~/.local/kitty.app/bin/kitten ~/.local/bin/kitten
            ;;
    esac

    if command -v kitty >/dev/null 2>&1; then
        log_info "Kitty installed: $(kitty --version)"
    else
        log_warn "Kitty installation may require adding ~/.local/bin to PATH"
    fi
}

install_opencode() {
    # Check if opencode is already installed (in PATH or in ~/.opencode/bin)
    if command -v opencode >/dev/null 2>&1 || [ -f "$HOME/.opencode/bin/opencode" ]; then
        log_info "Opencode already installed"
        return 0
    fi
    
    log_info "Installing Opencode..."
    
    curl -fsSL https://opencode.ai/install | bash
    if [ $? -ne 0 ]; then
        log_warn "Failed to install Opencode"
        return 1
    fi
    
    log_info "Opencode installed"
}

verify_install() {
    log_info "Verifying installation..."
    
    local missing=""
    
    command -v nvim >/dev/null 2>&1 || missing="$missing neovim"
    command -v git >/dev/null 2>&1 || missing="$missing git"
    command -v node >/dev/null 2>&1 || missing="$missing node"
    command -v yarn >/dev/null 2>&1 || missing="$missing yarn"
    command -v zellij >/dev/null 2>&1 || missing="$missing zellij"
    command -v opencode >/dev/null 2>&1 || [ -f "$HOME/.opencode/bin/opencode" ] || missing="$missing opencode"
    command -v fzf >/dev/null 2>&1 || missing="$missing fzf"
    command -v rg >/dev/null 2>&1 || missing="$missing ripgrep"
    command -v fdfind >/dev/null 2>&1 || command -v fd >/dev/null 2>&1 || missing="$missing fd"
    command -v ctags >/dev/null 2>&1 || missing="$missing ctags"
    
    if [ -n "$missing" ]; then
        log_warn "Missing items:$missing"
        return 1
    fi
    
    log_info "✅ All core dependencies are installed"
    echo ""
    echo "Installed versions:"
    echo "  nvim:    $(nvim --version | head -1)"
    echo "  git:     $(git --version)"
    echo "  node:    $(node --version)"
    echo "  yarn:    $(yarn --version)"
    echo "  zellij:  $(zellij --version)"
    echo "  opencode: $(opencode --version 2>/dev/null || echo 'N/A')"
    echo "  fzf:     $(fzf --version | head -1)"
    echo "  ripgrep: $(rg --version)"
    echo "  fd:      $(command -v fdfind >/dev/null && fdfind --version | cut -d' ' -f2 || fd --version | head -1)"
    echo "  ctags:   $(ctags --version | head -1)"

    # Kitty (optional for SSH/headless setups)
    if command -v kitty >/dev/null 2>&1; then
        echo "  kitty:   $(kitty --version 2>/dev/null)"
    else
        echo "  kitty:   not installed"
    fi
    
    return 0
}

print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --skip-system    Skip system dependency installation"
    echo "  --skip-node      Skip Node.js/Yarn installation"
    echo "  --skip-apps      Skip Zellij/Opencode/Kitty installation"
    echo "  --verify         Only verify the installation"
    echo "  --help           Display this help message"
    echo ""
}

main() {
    local skip_system=false
    local skip_node=false
    local skip_apps=false
    local verify_only=false

    for arg in "$@"; do
        case "$arg" in
            --skip-system) skip_system=true ;;
            --skip-node) skip_node=true ;;
            --skip-apps) skip_apps=true ;;
            --verify) verify_only=true ;;
            --help) print_help; exit 0 ;;
        esac
    done
    
    echo ""
    echo "========================================"
    echo "  DEPENDENCY INSTALLATION"
    echo "========================================"
    echo ""
    
    if [ "$verify_only" = true ]; then
        verify_install
        exit $?
    fi
    
    if [ "$skip_system" = false ]; then
        install_system_deps
    else
        log_info "System installation skipped"
    fi
    
    if [ "$skip_node" = false ]; then
        install_nvm
        install_node
        install_yarn
    else
        log_info "Node.js/Yarn skipped"
    fi
    
    if [ "$skip_apps" = false ]; then
        install_neovim
        install_zellij
        install_opencode

        # Kitty - prompt interactif (skip en mode non-interactif)
        if [ -t 0 ]; then
            if command -v kitty >/dev/null 2>&1; then
                log_info "Kitty already installed: $(kitty --version)"
            else
                echo ""
                read -p "Installer Kitty terminal (GPU-accelerated) ? [o/N] " response
                if [[ "$response" =~ ^[oOyY]$ ]]; then
                    install_kitty
                else
                    log_info "Kitty skipped"
                fi
            fi
        fi
    else
        log_info "Zellij/Opencode/Kitty skipped"
    fi
    
    verify_install
}

main "$@"
