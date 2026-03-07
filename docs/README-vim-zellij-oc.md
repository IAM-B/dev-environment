# Technical Documentation - Neovim IDE + Zellij + Opencode

Architecture and technical configuration documentation for the development environment.

---

## Overview

Complete configuration for a JavaScript/TypeScript development environment:
- **Neovim 0.11+**: IDE editor (native LSP, autocompletion, linting, formatting)
- **Zellij**: Terminal multiplexer with layouts
- **Opencode**: Integrated AI assistant
- **Kitty**: Terminal with Nerd Fonts and image support

### "code" Layout

```
┌─────────────────────┬──────────┐
│                     │ Terminal │
│     NEOVIM          │ (tests)  │
│    (65%)            ├──────────┤
│                     │ Opencode │
│                     │  (35%)   │
└─────────────────────┴──────────┘
```

---

## Configuration File Structure

### Installed Files

| Source (repo) | Destination | Description |
|--------------|-------------|-------------|
| `configs/bash/bashrc` | `~/.bashrc` | Bash configuration |
| `configs/nvim/` | `~/.config/nvim/` | Neovim configuration (init.lua + lua/) |
| `configs/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` | Kitty configuration |
| `configs/zellij/config.kdl` | `~/.config/zellij/config.kdl` | Zellij configuration |
| `configs/zellij/layouts/code.kdl` | `~/.config/zellij/layouts/code.kdl` | Code layout |
| `configs/zellij/layouts/dev.kdl` | `~/.config/zellij/layouts/dev.kdl` | Dev layout |
| `configs/fzf/fzf.bash` | `~/.fzf.bash` | fzf configuration |
| `configs/opencode/package.json` | `~/.opencode/package.json` | Opencode configuration |

### Created Directories

```
~/.config/nvim/
├── init.lua              # Entry point (leader key, lazy.nvim)
├── lua/
│   ├── core/             # Options, keymaps, autocmds
│   └── plugins/          # Configuration for each plugin
├── syntax/
│   └── edge.vim          # Edge syntax (AdonisJS)
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

#### 1. Neovim (Editor)
- **Plugin manager**: lazy.nvim
- **LSP**: mason.nvim + mason-lspconfig + nvim-lspconfig (native)
- **Completion**: nvim-cmp (LSP, snippets, buffer, path)
- **Formatting**: conform.nvim (Prettier)
- **Navigation**: Telescope, NvimTree
- **Git**: fugitive, gitsigns.nvim
- **Appearance**: Dracula (dracula.nvim), lualine.nvim
- **Snippets**: LuaSnip + friendly-snippets
- **Editing**: nvim-surround, Comment.nvim, nvim-autopairs, flash.nvim
- **Minimap**: mini.map (pure Lua)

#### 2. Zellij (Multiplexer)
- **Configuration**: `config.kdl`
- **Layouts**: `code.kdl`, `dev.kdl`
- **Theme**: Dracula
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
| [VIM-GUIDE.md](VIM-GUIDE.md) | **Everything about Neovim**: modes, plugins (Telescope, NvimTree, LSP, Git, snippets), navigation, troubleshooting |
| [BASH-SHORTCUTS.md](BASH-SHORTCUTS.md) | Bash keyboard shortcuts and command line |
| [INSTALLED-PLUGINS.md](INSTALLED-PLUGINS.md) | Complete list of plugins, aliases, and functions |
| [README.md](../README.md) | Overview and quick installation |

---

## Customization

### Modify Zellij layouts

Edit `~/.config/zellij/layouts/code.kdl`:

```kdl
layout {
    tab name="code" {
        pane split_direction="vertical" {
            pane size="70%" { focus true }
            pane size="30%" { command "opencode" }
        }
    }
}
```

### Add Neovim plugins

1. Create or edit a file in `~/.config/nvim/lua/plugins/`
2. Add the lazy.nvim spec:
   ```lua
   return {
     "author-name/plugin-name",
     config = function()
       require("plugin-name").setup({})
     end,
   }
   ```
3. In Neovim: `:Lazy sync`

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

# See VIM-GUIDE.md for detailed troubleshooting
```

### Plugins not loading

```bash
# Sync plugins
:Lazy sync

# View plugin status
:Lazy

# Update plugins
:Lazy update
```

---

## Credits

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Zellij](https://zellij.dev/)
- [Dracula Theme](https://draculatheme.com/)

---

**Last updated:** March 3, 2026
