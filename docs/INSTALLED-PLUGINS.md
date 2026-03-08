# INSTALLED PLUGINS AND CONFIGURATIONS

Complete summary of all installed plugins, tools, and configurations.

---

## NEOVIM PLUGINS (lazy.nvim)

### Appearance

| Plugin                  | Description               | Configuration                |
| ----------------------- | ------------------------- | ---------------------------- |
| **dracula.nvim**        | Dracula theme             | `colorscheme dracula`        |
| **lualine.nvim**        | Enhanced status bar       | Dracula theme, automatic     |
| **nvim-web-devicons**   | Icons in Neovim           | Requires Nerd Fonts          |

### Navigation & Files

| Plugin                        | Description                   | Shortcut                 |
| ----------------------------- | ----------------------------- | ------------------------ |
| **nvim-tree.lua**             | File explorer                 | `<Space>e`, `<Space>E`  |
| **telescope.nvim**            | Fuzzy finder                  | `<Space>ff`              |
| **telescope-fzf-native.nvim** | FZF extension for Telescope   | Integrated in Telescope  |
| **plenary.nvim**              | Telescope dependency          | Automatic                |
| **vim-tmux-navigator**        | Neovim↔Zellij navigation     | `Ctrl+h/j/k/l`          |
| **mini.map**                  | Code minimap (pure Lua)       | `<Space>mm`, `<Space>mc` |

### Editing & Productivity

| Plugin              | Description                                       | Shortcut               |
| ------------------- | ------------------------------------------------- | ---------------------- |
| **nvim-surround**   | Manage surroundings (parentheses, quotes...)      | `cs"'`, `ds'`, `ysiw'` |
| **Comment.nvim**    | Comment/uncomment                                 | `gcc`, `gc` (visual)   |
| **vim-repeat**      | Repeat actions                                    | `.`                    |
| **vim-unimpaired**  | Paired shortcuts (`[q`, `]q`, etc.)               | See docs               |
| **nvim-autopairs**  | Auto-close pairs                                  | `()`, `{}`, `[]`       |
| **flash.nvim**      | Quick navigation                                  | `s`, `S`               |

### Git

| Plugin           | Description                   | Shortcut            |
| ---------------- | ----------------------------- | ------------------- |
| **vim-fugitive** | Git in Neovim                 | `<Space>gs`, `:Git` |
| **gitsigns.nvim**| Real-time Git signs           | `]c`, `[c`          |

### LSP, Completion & Formatting

| Plugin                    | Description                      | Shortcut         |
| ------------------------- | -------------------------------- | ---------------- |
| **mason.nvim**            | LSP server manager               | `:Mason`         |
| **mason-lspconfig.nvim**  | Mason + lspconfig integration    | Automatic        |
| **cmp-nvim-lsp**          | LSP source for nvim-cmp          | Automatic        |
| **nvim-cmp**              | Completion engine                | `Tab`, `CR`      |
| **cmp-buffer**            | Buffer source for nvim-cmp       | Automatic        |
| **cmp-path**              | Path source for nvim-cmp         | Automatic        |
| **cmp-cmdline**           | Command line source              | Automatic        |
| **cmp_luasnip**           | Snippet source for nvim-cmp      | Automatic        |
| **conform.nvim**          | Code formatting                  | `<Space>f`       |

### Snippets

| Plugin               | Description                     | Shortcut     |
| -------------------- | ------------------------------- | ------------ |
| **LuaSnip**          | Snippet engine                  | `Tab`        |
| **friendly-snippets** | Snippet collection (VSCode)    | Automatic    |

### Syntax & Other

| Plugin         | Description                         | Configuration          |
| -------------- | ----------------------------------- | ---------------------- |
| **image.nvim** | Image preview (Kitty)               | Markdown, Norg         |
| `syntax/edge.vim` | Edge syntax (AdonisJS) — custom | `*.edge`               |

### Installed LSP servers (via Mason)

- **ts_ls** — TypeScript/JavaScript
- **jsonls** — JSON
- **html** — HTML
- **cssls** — CSS
- **eslint** — ESLint
- **svelte** — Svelte
- **yamlls** — YAML
- **marksman** — Markdown
- **lua_ls** — Lua
- **bashls** — Bash

---

## INSTALLED TOOLS

### Zellij

- **Version**: Latest stable
- **Layout**: `code` (Neovim 65% + Terminal + Opencode)
- **Configuration**: `~/.config/zellij/config.kdl`
- **Shell**: Bash (configured in Zellij)

### Kitty

- **Configuration**: `~/.config/kitty/kitty.conf`
- **Usage**: Terminal with Nerd Fonts and built-in image support
- **image.nvim backend**: Kitty protocol

### fzf

- **Installation**: `~/.fzf`
- **Usage**: Fuzzy search in files and Bash history
- **Shortcuts**: `Ctrl+R` (history)

### ble.sh

- **Installation**: `~/.blesh`
- **Function**: Autosuggestions in Bash (like zsh-autosuggestions)
- **Activation**: On terminal startup
- **Configuration**: In `~/.bashrc`

### lazy.nvim

- **Installation**: Automatic on first Neovim launch
- **Usage**: Neovim plugin manager (replaces vim-plug)
- **Commands**: `:Lazy sync`, `:Lazy update`, `:Lazy`

---

## CONFIGURATIONS

### Configuration Files

| File                                | Description                     |
| ----------------------------------- | ------------------------------- |
| `~/.bashrc`                         | Complete Bash configuration     |
| `~/.config/nvim/init.lua`           | Neovim entry point              |
| `~/.config/nvim/lua/core/`          | Options, keymaps, autocmds      |
| `~/.config/nvim/lua/plugins/`       | Plugin configuration            |
| `~/.config/nvim/syntax/edge.vim`    | Custom Edge syntax              |
| `~/.config/kitty/kitty.conf`        | Kitty configuration             |
| `~/.config/zellij/config.kdl`       | Zellij configuration            |
| `~/.config/zellij/layouts/code.kdl` | Custom layout                   |
| `~/.fzf.bash`                       | fzf configuration for Bash      |
| `~/.blesh/out/ble.sh`               | ble.sh compiled                 |

### Important Bash Aliases

```bash
# Vim / Documentation
vimdoc, vimhelp, vimguide, vimshort

# Zellij
zc, zd, za, zl, zk, zka, zr, ze

# Opencode
oc, ocn, ocl, ocs

# Git
gs, ga, gc, gp, gl, gd, gco, gb

# Development (npm)
nr, ni, nid, ns, nt, nb, nd

# Python
py, py2, pip, venv

# Navigation
.., ..., ...., ll, la, l

# Utilities
cls, h, hg, mkdirp, ports, duh, dfh
```

### Bash Functions

```bash
fzf_history()    # Search history with fzf (Ctrl+R)
fv()             # Open file with fzf + nvim
code()           # Launch Zellij with code layout
mkcd()           # Create directory and cd into it
extract()        # Extract any archive
```

### Environment Variables

```bash
EDITOR=nvim
VISUAL=nvim
PATH=$HOME/.opencode/bin:$PATH
HISTSIZE=10000
HISTFILESIZE=10000
```

---

## MAIN SHORTCUTS

### Neovim (Normal Mode)

| Shortcut      | Action                            |
| ------------- | --------------------------------- |
| `Space`       | Leader                            |
| `Space+e`     | NvimTree                          |
| `Space+ep`    | NvimTree: back to project root    |
| `Space+ff`    | Telescope (files)                 |
| `Space+fg`    | Telescope (grep)                  |
| `Space+w`     | Save                              |
| `Space+x`     | Save and quit                     |
| `Space+gs`    | Git status                        |
| `Space+bn/bp` | Next/Previous buffer              |
| `Space+mm`    | Toggle minimap                    |
| `Space+mc`    | Close minimap                     |
| `Space+mr`    | Refresh minimap                   |
| `jj` or `jk`  | Exit insert mode                 |
| `gd`          | Go to definition                  |
| `Space+rn`    | Rename symbol                     |
| `Space+f`     | Format                            |
| `s`           | Flash (quick jump)                |
| `]c` / `[c`   | Next/Previous git change         |

### Zellij

| Shortcut       | Action                    |
| -------------- | ------------------------- |
| `Alt+h/j/k/l`  | Navigation between panes |
| `Ctrl+g`       | Locked mode              |
| `Ctrl+p`       | Pane mode                |
| `Ctrl+t`       | Tab mode                 |
| `Ctrl+o`       | Session mode             |

### Bash

| Shortcut  | Action                     |
| --------- | -------------------------- |
| `Ctrl+R`  | History search (fzf)       |
| `Alt+F`   | Next word                  |
| `Alt+B`   | Previous word              |
| `Ctrl+A`  | Beginning of line          |
| `Ctrl+E`  | End of line                |
| `→`       | Accept ble.sh suggestion   |

---

## CREATED DIRECTORIES

```
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── core/
│   │   ├── keymaps.lua   # Keyboard shortcuts
│   │   ├── options.lua   # Neovim options
│   │   └── autocmds.lua  # Autocommands
│   └── plugins/
│       ├── lsp.lua       # LSP, Mason, nvim-cmp, conform
│       ├── navigation.lua # NvimTree, Telescope, mini.map
│       ├── editing.lua   # Surround, Comment, autopairs, flash
│       ├── git.lua       # Fugitive, gitsigns
│       ├── snippets.lua  # LuaSnip, friendly-snippets
│       ├── appearance.lua # Dracula, lualine, devicons
│       ├── treesitter.lua # Treesitter (Neovim 0.11+ native)
│       └── images.lua    # image.nvim (Kitty)
├── syntax/
│   └── edge.vim          # Edge syntax (AdonisJS)
└── lazy-lock.json        # Plugin version lock

~/.local/state/nvim/
├── backup/               # Backup files
└── undo/                 # Persistent undo

~/.config/kitty/
└── kitty.conf            # Kitty configuration

~/.config/zellij/
├── config.kdl            # Zellij configuration
└── layouts/
    ├── code.kdl          # Code layout
    └── dev.kdl           # Dev layout

~/.blesh/
└── out/
    └── ble.sh            # ble.sh compiled

~/.fzf/                   # fzf installed
```

---

## INSTALLATION VERIFICATION

To verify that everything is installed:

```bash
# Check Neovim plugins
nvim +Lazy

# Check installed LSP servers
nvim +"lua print(vim.inspect(vim.lsp.get_clients()))"

# Check Mason
nvim +Mason

# Check ble.sh
echo $BLE_VERSION

# Check fzf
which fzf
fzf --version
```

---

## DOCUMENTATION

All documentation is in the `docs/` folder:

- `../README.md` - Documentation index (root)
- `VIM-GUIDE.md` - Complete Neovim guide for beginners
- `README-vim-zellij-oc.md` - Technical documentation
- `BASH-SHORTCUTS.md` - Bash keyboard shortcuts
- `INSTALLED-PLUGINS.md` - This file (complete list)

---

**Last updated:** March 3, 2026
**Version:** 4.0
