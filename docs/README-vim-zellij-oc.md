# Technical Documentation - LazyVim + Zellij + Opencode

Architecture and technical configuration documentation for the development environment.

---

## Overview

Complete configuration for a JavaScript/TypeScript development environment:
- **LazyVim** (`lvim`): Primary Neovim IDE (distribution preconfigured, 24 extras)
- **Neovim** (`nvim`): Legacy custom config (47 plugins, kept for reference)
- **Zellij**: Terminal multiplexer with layouts
- **Opencode**: Integrated AI assistant
- **Kitty**: GPU-accelerated terminal with Nerd Fonts and image support

### "code" Layout (`zc`)

Sessions are named `code-DIRNAME-HHMM` (e.g. `code-myproject-1430`).

```
+---------------------+----------+
|                     |          |
|     LAZYVIM         |  CLAUDE  |
|      (65%)          |  CODE    |
|                     |  (35%)   |
+---------------------+----------+
```

LazyVim se lance automatiquement dans le pane principal.

---

## Configuration File Structure

### Installed Files

| Source (repo) | Destination | Description |
|--------------|-------------|-------------|
| `configs/bash/bashrc` | `~/.bashrc` | Bash configuration |
| `configs/nvim-lazyvim/` | `~/.config/nvim-lazyvim/` | **LazyVim config (primary)** |
| `configs/nvim/` | `~/.config/nvim/` | Legacy Neovim config |
| `configs/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` | Kitty configuration |
| `configs/zellij/config.kdl` | `~/.config/zellij/config.kdl` | Zellij configuration |
| `configs/zellij/layouts/code.kdl` | `~/.config/zellij/layouts/code.kdl` | Code layout (launches LazyVim + Claude Code) |
| `configs/zellij/layouts/dev.kdl` | `~/.config/zellij/layouts/dev.kdl` | Dev layout |
| `configs/zellij/layouts/agents.kdl` | `~/.config/zellij/layouts/agents.kdl` | Agents layout (4x Claude) |
| `configs/starship/starship.toml` | `~/.config/starship.toml` | Starship prompt |
| `configs/fzf/fzf.bash` | `~/.fzf.bash` | fzf configuration |
| `configs/opencode/package.json` | `~/.opencode/package.json` | Opencode configuration |

### Created Directories

```
~/.config/nvim-lazyvim/           # PRIMARY CONFIG (LazyVim)
├── init.lua                      # Entry point
├── lazyvim.json                  # Enabled extras (24)
├── stylua.toml                   # Lua formatter
├── lua/config/                   # Options, keymaps, autocmds, lazy.lua
└── lua/plugins/                  # Custom plugins (lang, minimap)

~/.config/nvim/                   # LEGACY CONFIG (custom)
├── init.lua              # Entry point (leader key, lazy.nvim)
├── lua/
│   ├── core/             # Options, keymaps, autocmds
│   └── plugins/          # Configuration for each plugin (17 files)
├── syntax/
│   └── edge.vim          # Edge syntax (AdonisJS)
├── queries/              # Treesitter query overrides
└── lazy-lock.json        # Plugin version lock

~/.local/state/nvim/
├── backup/               # Backup files
└── undo/                 # Persistent undo

~/.config/kitty/
└── kitty.conf            # Kitty configuration

~/.config/zellij/
├── config.kdl            # Configuration
└── layouts/              # Custom layouts

~/.blesh/
└── out/ble.sh            # ble.sh compiled

~/.fzf/                   # fzf

~/.nvm/                   # Node Version Manager

~/.opencode/              # Opencode
```

---

## Architecture

### Main Components

#### 1. LazyVim (Primary Editor) — 24 extras

- **Distribution**: LazyVim (by folke) — pre-configured Neovim IDE
- **Launch**: `lvim` or via Zellij `zc`
- **Completion**: blink.cmp (modern, fast)
- **Navigation**: snacks.picker / Telescope, Neo-tree, Harpoon2
- **Git**: gitsigns.nvim + lazygit (full TUI)
- **Appearance**: TokyoNight, lualine.nvim, bufferline.nvim
- **Editing**: mini.surround, ts-comments.nvim, flash.nvim
- **Debugging**: nvim-dap (via extras)
- **Diagnostics**: trouble.nvim, todo-comments.nvim
- **UI**: noice.nvim, which-key.nvim
- **Languages**: TypeScript, Svelte, Python, Tailwind, Docker, YAML, JSON, Markdown
- **Custom plugins**: minimap.vim, Svelte lang support

#### Legacy: Neovim custom config — 47 plugins

Available via `nvim`. See `configs/nvim/` and [nvim-guide-config-actuelle.md](nvim-guide-config-actuelle.md).
- **Sessions**: persistence.nvim
- **Minimap**: minimap.vim (code-minimap, real split)
- **Markdown**: markdown-preview.nvim, image.nvim

#### 2. Zellij (Multiplexer)
- **Configuration**: `config.kdl`
- **Layouts**: `code.kdl`, `dev.kdl`, `agents.kdl`
- **Theme**: TokyoNight
- **Shell**: Bash

#### 3. Bash (Shell)
- **Autosuggestions**: ble.sh
- **FZF**: History and search
- **Aliases**: Zellij, Git, npm, Python

#### 4. Tools
- **Node.js**: via nvm
- **Opencode**: AI assistant
- **Kitty**: Terminal

---

## User Documentation

For daily usage, see the specialized guides:

| Guide | Content |
|-------|---------|
| [lazyvim-guide.md](lazyvim-guide.md) | **Guide LazyVim** : config principale, raccourcis, lazygit, extras (FR) |
| [nvim-guide-config-actuelle.md](nvim-guide-config-actuelle.md) | Guide config Neovim legacy : raccourcis, plugins, workflows (FR) |
| [nvim-ameliorations-futures.md](nvim-ameliorations-futures.md) | Roadmap des ameliorations futures — archive (FR) |
| [VIM-GUIDE.md](VIM-GUIDE.md) | Vim general : modes, navigation, troubleshooting |
| [BASH-SHORTCUTS.md](BASH-SHORTCUTS.md) | Bash keyboard shortcuts and command line |
| [INSTALLED-PLUGINS.md](INSTALLED-PLUGINS.md) | Liste des 47 plugins legacy |
| [README.md](../README.md) | Overview and quick installation |

---

## Customization

### Modify Zellij layouts

Edit `~/.config/zellij/layouts/code.kdl`:

```kdl
layout {
    tab name="code" {
        pane split_direction="vertical" {
            pane size="65%" {
                focus true
                command "lvim"
            }
            pane size="35%" { command "claude" args="--resume" }
        }
    }
}
```

### Add LazyVim plugins

1. Create a file in `~/.config/nvim-lazyvim/lua/plugins/` (e.g. `myplugin.lua`)
2. Add the lazy.nvim spec:
   ```lua
   return {
     "author-name/plugin-name",
     config = function()
       require("plugin-name").setup({})
     end,
   }
   ```
3. In LazyVim: `:Lazy sync` (or `<Space>L` then `S`)
4. For extras: `:LazyExtras` to browse and enable/disable

### Add Bash aliases

Edit `~/.bashrc` and add:
```bash
alias myalias='my command'
```

Then reload:
```bash
source ~/.bashrc
```

---

## General Troubleshooting

### Zellij won't start

```bash
# Check configuration
zellij setup --check

# Regenerate default config
zellij setup
```

### Incorrect fonts (icons)

Install a Nerd Font:
- [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip)
- [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip)

Configure in Kitty: `~/.config/kitty/kitty.conf`

### LSP / Mason issues

```bash
# Check Node.js
node --version

# Open Mason to view/install LSP servers
:Mason

# Check LSP status
:LspInfo

# Restart the LSP server
:LspRestart
```

### Plugins not loading

```bash
# Sync plugins
:Lazy sync

# View plugin status
:Lazy    (or <Space>L)

# Update plugins
:Lazy update
```

---

## Credits

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [Harpoon](https://github.com/ThePrimeagen/harpoon)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [Zellij](https://zellij.dev/)
- [TokyoNight](https://github.com/folke/tokyonight.nvim)
- [LazyVim](https://lazyvim.org/)

---

**Last updated:** April 5, 2026
