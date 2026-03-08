<h1 align="center">
  dev-environment
</h1>

<p align="center">
  <b>A portable, one-command Linux development environment built around Neovim, Zellij, and AI-assisted coding.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.11+-57A143?style=flat-square&logo=neovim&logoColor=white" alt="Neovim">
  <img src="https://img.shields.io/badge/Zellij-terminal_multiplexer-blue?style=flat-square" alt="Zellij">
  <img src="https://img.shields.io/badge/Lua-config-2C2D72?style=flat-square&logo=lua&logoColor=white" alt="Lua">
  <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white" alt="Bash">
  <img src="https://img.shields.io/badge/Platform-Linux-FCC624?style=flat-square&logo=linux&logoColor=black" alt="Linux">
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=flat-square" alt="License">
</p>

---

## Demo

<!-- Replace the placeholder below with your actual GIF -->
<p align="center">
  <img src="assets/demo.webp" alt="Demo: launching the dev environment with zc" width="800">
</p>

> `cd your/project && zc` — one command to launch a full IDE workspace with Neovim, a terminal, and an AI assistant side by side.

---

## What Is This?

This is a **fully portable development environment** that can be deployed on any Linux machine with a single `git clone` + `./install.sh`. It sets up:

| Component | Role |
|-----------|------|
| **Neovim 0.11+** | IDE-grade editor with native LSP, autocompletion, formatting, and 29 plugins |
| **Zellij** | Terminal multiplexer with pre-built layouts |
| **Opencode** | AI coding assistant integrated into the workflow |
| **Kitty** | GPU-accelerated terminal with Nerd Fonts & image support |
| **Bash + ble.sh** | Shell with autosuggestions, fzf history, and 30+ aliases |

### The `zc` Workspace

Running `cd /path/to/project` and `zc` launches a purpose-built Zellij layout:

```
┌──────────────────────┬────────────┐
│                      │  Terminal  │
│       NEOVIM         │  (tests,   │
│       (65%)          │   git...)  │
│                      ├────────────┤
│                      │  Opencode  │
│                      │   (AI)     │
└──────────────────────┴────────────┘
```

### The `zd` Workspace

Running `cd /path/to/project` and `zd` launches a simpler layout for general-purpose terminal work:

```
┌──────────────────────┬────────────┐
│                      │            │
│      Terminal        │  Terminal  │
│       (50%)          │   (50%)    │
│                      ├────────────┤
│                      │  Terminal  │
│                      │            │
└──────────────────────┴────────────┘
```

## Quick Start

```bash
# Clone the repository
git clone https://github.com/iamb/dev-environment.git ~/dev-environment
cd ~/dev-environment

# Run the full installation
./install.sh
```

Installation takes ~5-10 minutes and supports **Debian/Ubuntu**, **Arch/Manjaro**, **Fedora**, and **openSUSE** (x86_64 & ARM64).

### Selective Install

```bash
./install.sh --with-kitty     # Also install Kitty terminal (GPU-accelerated)
./install.sh --skip-deps      # Skip system dependencies
./install.sh --skip-configs   # Skip config file deployment
./install.sh --skip-nvim      # Skip Neovim plugin installation
./install.sh --force          # Force reinstall everything
./install-deps.sh --verify    # Verify all dependencies are installed
```

> **Note:** Kitty is not installed by default — useful when deploying on a remote server via SSH where you don't need a local terminal emulator. Add `--with-kitty` when setting up a local workstation.

## What Gets Installed

### Neovim — IDE Features

- **Native LSP** with 10 language servers auto-installed via Mason (TypeScript, JavaScript, JSON, CSS, HTML, Svelte, YAML, Markdown, Lua, Bash)
- **Smart autocompletion** via nvim-cmp (4 sources: LSP, snippets, paths, buffer)
- **Auto-formatting on save** via Prettier (conform.nvim) for JS/TS/CSS/HTML/JSON/YAML/Markdown/Svelte
- **Fuzzy finder** (Telescope + fzf-native) for files, grep, buffers, commands
- **File explorer** (NvimTree) with Git status indicators
- **Git integration** (Fugitive + Gitsigns) — inline blame, hunk navigation, stage/reset
- **Code minimap** (mini.map) with Git diff highlighting
- **Flash navigation** for instant cursor jumps
- **Seamless Neovim ↔ Zellij pane navigation** via `Ctrl+h/j/k/l`
- **Custom Edge template syntax** for AdonisJS development
- **Tailwind CSS class wrapping** — auto-wraps long `class="..."` to 80 columns on save
- **Dracula theme** across all components

### Shell — Productivity

- **ble.sh** autosuggestions (zsh-like experience in Bash)
- **fzf** history search (`Ctrl+R`)
- **30+ aliases**: Zellij sessions, Git shortcuts, npm/yarn, navigation
- **Utility functions**: `mkcd`, `extract` (universal archive), `fv` (fzf+nvim), `code` (directory-aware workspace), `img` (inline image display)

### Key Bindings (Neovim)

| Shortcut | Action |
|----------|--------|
| `Space` | Leader key |
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (ripgrep) |
| `gd` | Go to definition |
| `<leader>rn` | Rename symbol |
| `<leader>f` | Format file |
| `s` | Flash jump |
| `<leader>gs` | Git status (Fugitive) |
| `jj` / `jk` | Exit insert mode |
| `H` / `L` | Beginning / end of line |
| `J` / `K` | 5 lines down / up |

## Project Structure

```
dev-environment/
├── install.sh                  # Main installer (orchestrates everything)
├── install-deps.sh             # System dependencies (Neovim, Node, Zellij...)
├── install-configs.sh          # Config deployment with smart diffing & backups
├── sync-configs.sh             # Reverse sync: machine → repo (for updates)
│
├── configs/
│   ├── nvim/                   # Neovim configuration (Lua)
│   │   ├── init.lua            # Entry point + lazy.nvim bootstrap
│   │   ├── lua/core/           # Options, keymaps, autocmds
│   │   ├── lua/plugins/        # Plugin configs (LSP, navigation, git, etc.)
│   │   └── syntax/edge.vim     # Custom Edge template syntax
│   ├── bash/bashrc             # Shell config (aliases, functions, prompt)
│   ├── kitty/kitty.conf        # Terminal emulator config
│   ├── zellij/                 # Multiplexer config + layouts
│   │   ├── config.kdl
│   │   └── layouts/            # code.kdl (IDE) + dev.kdl (classic split)
│   ├── fzf/fzf.bash            # FZF shell integration
│   └── opencode/               # AI assistant config + AGENTS.md safety rules
│
├── docs/                       # Documentation
│   ├── VIM-GUIDE.md            # Complete Neovim user guide
│   ├── INSTALLED-PLUGINS.md    # Full plugin & tool inventory
│   ├── README-vim-zellij-oc.md # Technical architecture
│   └── BASH-SHORTCUTS.md       # Bash keyboard shortcuts
│
└── assets/                     # Demo GIF
```

## Documentation

| Document | Description |
|----------|-------------|
| **[VIM-GUIDE.md](docs/VIM-GUIDE.md)** | Complete Neovim guide — modes, plugins, keybindings, troubleshooting |
| **[INSTALLED-PLUGINS.md](docs/INSTALLED-PLUGINS.md)** | Full inventory: 29 Neovim plugins, 10 LSP servers, all tools & aliases |
| **[Technical Architecture](docs/README-vim-zellij-oc.md)** | File mapping, architecture overview, customization guide |
| **[BASH-SHORTCUTS.md](docs/BASH-SHORTCUTS.md)** | Bash keyboard shortcuts (navigation, history, editing) |

## Keeping Configs in Sync

The repo includes a two-way sync system. `sync-configs.sh` handles the full cycle automatically:

1. **Applies** repo changes to your machine (`install-configs.sh`)
2. **Captures** local config changes back to the repo
3. **Commits and pushes** if anything changed

```bash
# Full two-way sync (repo ↔ machine)
./sync-configs.sh
./sync-configs.sh --no-push    # Sync without pushing to remote
./sync-configs.sh --dry-run    # Preview what would change

# Deploy only: repo → machine (no git operations)
./install-configs.sh
```

Changed files are backed up automatically before being overwritten. Identical files are skipped.

**Automate with cron** (recommended):

```bash
crontab -e
0 12 * * * /bin/bash /path/to/dev-environment/sync-configs.sh >> ~/.local/log/sync-configs.log 2>&1
```

## Tech Stack This Was Built For

This environment is optimized for full-stack JavaScript/TypeScript development:

- **Backend**: AdonisJS (TypeScript)
- **Frontend**: Edge templates + Alpine.js + Tailwind CSS
- **Database**: PostgreSQL
- **Tooling**: Docker, Zellij, Neovim

But the setup works well for any web development workflow — the LSP servers, formatters, and tooling are easily extensible.

## Troubleshooting

```bash
# Verify all dependencies
./install-deps.sh --verify

# Force reinstall
./install.sh --force

# Sync Neovim plugins
nvim +"Lazy sync"

# Check LSP status (inside Neovim)
:LspInfo
:Mason
```

## Contributing

This is a personal setup, but contributions and ideas are welcome! If you have suggestions to improve this environment — new plugins, better keybindings, shell tricks, or support for additional distros — feel free to:

- **Open an issue** to discuss an idea or report a problem
- **Submit a pull request** with your improvement
- **Star the repo** if you find it useful

Whether you're an experienced Vim user or just getting started with terminal-based development, I'd love to hear how you'd make this setup better.

## License

MIT

---

<p align="center">
  <sub>Last updated: March 2026 · v4.0</sub>
</p>
