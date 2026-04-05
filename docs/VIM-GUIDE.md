# NEOVIM GUIDE - Complete Usage

> **Note:** This guide covers general Vim usage and the legacy config.
> For LazyVim-specific keybindings and features (primary config),
> see [lazyvim-guide.md](lazyvim-guide.md).

Complete guide to using Neovim as an IDE with all installed plugins.

---

## TABLE OF CONTENTS

1. [Quick start](#1-quick-start)
2. [The 3 Vim modes](#2-the-3-vim-modes)
3. [Essential plugins](#3-essential-plugins)
   - Telescope (fuzzy finder)
   - Neo-tree (file explorer)
   - Harpoon (quick file switching)
   - Mason/native LSP + nvim-cmp (autocompletion)
   - Git (fugitive + gitsigns + quick navigation)
   - Trouble (diagnostics panel)
   - Minimap (mini.map)
   - Snippets (LuaSnip)
   - Advanced editing (ts-comments, nvim-surround, flash.nvim)
   - TODO Comments
   - Search & Replace (grug-far)
   - Debugger (nvim-dap)
   - Sessions (persistence.nvim)
   - Markdown preview
   - Which-key (keymap help)
   - Noice (notifications)
4. [Navigation](#4-navigation)
5. [Editing](#5-editing)
6. [File management](#6-file-management)
7. [Troubleshooting](#7-troubleshooting)
8. [Quick reference](#8-quick-reference)

---

## 1. QUICK START

### Launch Neovim

```bash
# From the terminal
cd /path/to/your/project
nvim .

# Or with Zellij (recommended)
zc  # Launch Zellij with code layout
```

### Interface

```
┌─────────────────────┬──────────┐
│                     │ Terminal │
│     NEOVIM          │ (tests)  │
│    (65%)            ├──────────┤
│                     │ Opencode │
│                     │  (35%)   │
└─────────────────────┴──────────┘
```

Navigation between Zellij panes: `Alt+h/j/k/l`

### Recommended terminal: Kitty

Kitty is configured with a Nerd Font and built-in image support.

### Discover shortcuts: Which-key

Press `<Space>` (leader) and wait 300ms. A popup shows all available shortcuts organized by group. This is the best way to learn your config.

---

## 2. THE 3 VIM MODES

Neovim has 3 modes. **You must know which mode you are in!**

### NORMAL mode (commands)

- Default mode when opening
- Type commands but NOT text
- Cursor: block

### INSERT mode (writing)

- For writing text
- Cursor: line |
- Indicator at bottom: `-- INSERT --`

### VISUAL mode (selection)

- For selecting text
- Text is highlighted
- Indicator at bottom: `-- VISUAL --`

### Switching modes

| Action          | Shortcut                | Description              |
| --------------- | ----------------------- | ------------------------ |
| NORMAL > INSERT | `i`                     | Insert before cursor     |
| NORMAL > INSERT | `a`                     | Append after cursor      |
| NORMAL > INSERT | `o`                     | Open line below          |
| NORMAL > INSERT | `I`                     | Insert at line start     |
| NORMAL > INSERT | `A`                     | Append at line end       |
| NORMAL > INSERT | `O`                     | Open line above          |
| INSERT > NORMAL | `Esc` or `jj` or `jk`  | Exit insert mode         |
| NORMAL > VISUAL | `v`                     | Character selection      |
| NORMAL > VISUAL | `V`                     | Line selection           |
| NORMAL > VISUAL | `Ctrl+v`                | Block selection          |

**TIP**: Type `jj` quickly to exit insert mode (faster than Esc)

---

## 3. ESSENTIAL PLUGINS

### 3.1 Telescope - Fuzzy Finder

Fast file and text search (replaces fzf.vim).

#### Open a file

```
<Space>ff    # Fuzzy Finder (files)
```

**Steps:**

1. Make sure you are in NORMAL mode
2. Type `<Space>ff` (Space then f then f)
3. A window opens with all files
4. Type the name (e.g.: `app.js` or just `app`)
5. Telescope filters automatically
6. Navigation: `Ctrl+j/k`
7. `Enter` to open, `Esc` to cancel

#### Search within files (Live Grep)

```
<Space>fg    # Grep across all files
```

1. Type the word to search for
2. Telescope shows all files containing that word
3. `Enter` to open at that location

#### Other Telescope commands

```
<Space>fb    # List of open buffers
<Space>fh    # File history
<Space>fc    # Command list
<Space>fm    # Keymap list
<Space>ft    # Search TODOs in project
```

---

### 3.2 Neo-tree - File Explorer

Modern file explorer with git status inline (replaces nvim-tree).

#### Open/Close

```
<Space>e     # Open/close Neo-tree
<Space>E     # Locate current file in tree
<Space>ep    # Back to project root (cwd)
```

#### Navigation in Neo-tree

| Action           | Shortcut        | Description                       |
| ---------------- | --------------- | --------------------------------- |
| Open file        | `Enter`         | Opens in the current window       |
| Expand folder    | `Enter`         | Shows files                       |
| Collapse folder  | `Enter`         | Hides files                       |
| Go up            | `-`             | Parent directory                  |
| Refresh          | `R`             | Updates the tree                  |
| Close            | `q`             | Closes Neo-tree                   |
| Help             | `?`             | Shows all shortcuts               |

#### Create/Modify files

```
a             # Add a file or folder (add / at the end for a folder)
d             # Delete
r             # Rename
m             # Move
c             # Copy
p             # Paste
```

#### Features

- **Follows current file**: the tree highlights the file you're editing
- **File watcher**: auto-refreshes when files change on disk
- **Git status inline**: shows modified/staged/untracked status
- **Git symbols**: `+` staged, `~` modified, `?` untracked, `-` deleted, `i` ignored

---

### 3.3 Harpoon - Quick File Switching

Mark your most-used files and switch between them instantly.

```
<Space>ha    # Add current file to harpoon
<Space>hh    # Open harpoon menu
<Space>1     # Jump to harpoon file 1
<Space>2     # Jump to harpoon file 2
<Space>3     # Jump to harpoon file 3
<Space>4     # Jump to harpoon file 4
<Space>5     # Jump to harpoon file 5
```

**Workflow**: Working on a component, its styles, and its tests? Mark all 3 files with `<Space>ha`, then switch with `<Space>1`, `<Space>2`, `<Space>3`. Much faster than Telescope for frequent files.

---

### 3.4 Mason/Native LSP + nvim-cmp - LSP (Language Server Protocol)

Intelligent autocompletion, diagnostics, refactoring.

LSP servers are managed by **Mason** and configured automatically via **mason-lspconfig**.

#### Code navigation

| Shortcut     | Action                   |
| ------------ | ------------------------ |
| `gd`         | Go to definition         |
| `gy`         | Go to type               |
| `gi`         | Go to implementation     |
| `gr`         | View references          |
| `<Space>d`   | Documentation (hover)    |
| `<Space>rn`  | Rename symbol            |

#### Autocompletion (nvim-cmp)

- Completion appears automatically
- `Ctrl+Space`: Force completion
- `Tab`: Select next / jump to next placeholder
- `Shift+Tab`: Previous selection
- `Enter`: Confirm selection

Completion sources (by priority):
1. LSP
2. Snippets (LuaSnip)
3. File paths
4. Current buffer

#### Code actions

```
<Space>ca    # Code action (normal and visual)
```

#### Formatting (conform.nvim)

```
<Space>f     # Format file/selection
```

Auto-formatting on save is enabled (Prettier for JS/TS/CSS/HTML/JSON/YAML/Markdown/Svelte).

#### Diagnostics (errors/warnings)

```
[g            # Previous diagnostic
]g            # Next diagnostic
[G            # Previous error (severe errors only)
]G            # Next error (severe errors only)
<Space>cd     # Diagnostics list (location list)
```

#### Installed LSP servers (via Mason)

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

### 3.5 Trouble - Diagnostics Panel

Better interface for browsing errors, warnings, and TODOs (replaces location list).

```
<Space>xx    # All diagnostics (entire project)
<Space>xd    # Diagnostics (current file only)
<Space>xl    # Location list
<Space>xq    # Quickfix list
<Space>xt    # TODO list
```

Navigate and jump directly to each error. Much more ergonomic than `:lopen`.

---

### 3.6 Git - Fugitive + gitsigns.nvim

#### Fugitive (Git commands)

| Shortcut     | Command       | Description |
| ------------ | ------------- | ----------- |
| `<Space>gs`  | `:Git`        | Git status  |
| `<Space>gd`  | `:Gdiffsplit` | Diff        |
| `<Space>gb`  | `:Git blame`  | Blame       |
| `<Space>gl`  | `:Git log`    | Log         |
| `<Space>gp`  | `:Git push`   | Push        |
| `<Space>gP`  | `:Git pull`   | Pull        |

In the `:Git` (status) window:

- `s` on a file: Stage
- `u` on a file: Unstage
- `cc`: Commit
- `ca`: Commit --amend
- `X`: Checkout (discard changes)
- `Enter` on a file: Open the file

#### Quick navigation in modified files

**Recommended workflow:**

```bash
1. Open git status:
   <Space>gs
   (Enter on the first file)
   ]c to jump to the next change
   [c to go back to the previous one

2. For each file:
   Review the changes (+/~ indicators in the gutter)
   :w if OK
   ]c to move to the next one
```

#### gitsigns.nvim (real-time indicators)

| Shortcut     | Action               |
| ------------ | -------------------- |
| `]c`         | Next change          |
| `[c`         | Previous change      |
| `<Space>hs`  | Stage the hunk       |
| `<Space>hu`  | Undo stage the hunk  |
| `<Space>hp`  | Preview the hunk     |

**Visual indicators in the gutter:**

- `+` : Line added (green)
- `~` : Line modified (orange)
- `-` : Line deleted (red)
- Staged changes appear in muted colors

---

### 3.7 Minimap (minimap.vim)

Code mini-map displayed as a real split on the right side (uses `code-minimap` in Rust).

| Shortcut     | Action                    |
| ------------ | ------------------------- |
| `<Space>mm`  | Toggle (show/hide)        |
| `<Space>mc`  | Close                     |
| `<Space>mr`  | Refresh                   |

Auto-start on code files, hidden in special buffers (Neo-tree, Telescope, etc.). Shows git changes and search results.

---

### 3.8 Snippets (LuaSnip + friendly-snippets)

Reusable code templates.

1. Type the snippet keyword
2. Press `Tab` to expand
3. Use `Ctrl+j` to advance to the next placeholder
4. Use `Ctrl+k` to go back to the previous placeholder

#### Snippet examples

```javascript
// Type "clg" + Tab
console.log(|);

// Type "imp" + Tab
import { | } from '';

// Type "fn" + Tab
function |() {

}
```

Snippets come from **friendly-snippets** (VSCode-compatible collection).

---

### 3.9 Advanced editing (ts-comments + nvim-surround + flash.nvim)

#### ts-comments.nvim - Comment/Uncomment

Treesitter-aware commenting. In JSX/TSX, uses `{/* */}` in JSX and `//` in JavaScript automatically.

| Shortcut  | Action              | Description                                        |
| --------- | ------------------- | -------------------------------------------------- |
| `gcc`     | Comment line        | Toggle comment on the current line                 |
| `gc`      | Comment (visual)    | In visual mode, comments the selection             |
| `gcap`    | Comment paragraph   | Comments the entire block (paragraph)              |

#### nvim-surround - Manage surroundings

Add, change or delete character pairs (parentheses, quotes, etc.).

| Shortcut  | Action                    | Example              |
| --------- | ------------------------- | -------------------- |
| `cs"'`    | Change surround           | `"text"` > `'text'` |
| `cs'"`    | Change surround           | `'text'` > `"text"` |
| `ds"`     | Delete surround           | `"text"` > `text`   |
| `ds(`     | Delete surround           | `(text)` > `text`   |
| `ysiw'`   | Add surround to word      | `text` > `'text'`   |
| `ysiW"`   | Add surround to WORD      | `text` > `"text"`   |
| `yss'`    | Add surround to line      | `text` > `'text'`   |
| `S"`      | Surround selection (visual)| Select + `S"`       |

**HTML tags:**
- `ysiw<div>`: wraps word in `<div>...</div>`
- `dst`: deletes surrounding HTML tag

#### flash.nvim - Quick navigation

Ultra-fast navigation within the file.

| Shortcut  | Action                    | Description                              |
| --------- | ------------------------- | ---------------------------------------- |
| `s`       | Flash                     | Jump to any word (normal/visual)         |
| `S`       | Flash Treesitter          | Selection by Treesitter node             |

**Usage:**

1. In NORMAL mode, type `s`
2. Type the first letters of the target
3. Labels appear on matches
4. Type the label to jump there

---

### 3.10 TODO Comments

Highlights TODO, FIXME, HACK, NOTE, WARNING in your code.

| Shortcut     | Action                   |
| ------------ | ------------------------ |
| `]t`         | Next TODO                |
| `[t`         | Previous TODO            |
| `<Space>ft`  | Search all TODOs (Telescope) |
| `<Space>xt`  | TODOs in Trouble panel   |

---

### 3.11 Search & Replace - grug-far

Search and replace across the entire project (like Ctrl+Shift+H in VS Code).

| Shortcut     | Action                              |
| ------------ | ----------------------------------- |
| `<Space>sr`  | Open search & replace panel         |
| `<Space>sw`  | Search & replace word under cursor  |

Features: regex support, file type filter, preview before applying.

---

### 3.12 Debugger (nvim-dap)

Integrated debugger for JavaScript/TypeScript (like VS Code).

| Shortcut     | Action                              |
| ------------ | ----------------------------------- |
| `<Space>db`  | Toggle breakpoint                   |
| `<Space>dB`  | Conditional breakpoint              |
| `<Space>dc`  | Continue / Launch debug             |
| `<Space>do`  | Step over                           |
| `<Space>di`  | Step into                           |
| `<Space>dO`  | Step out                            |
| `<Space>dr`  | Restart                             |
| `<Space>dt`  | Terminate                           |
| `<Space>du`  | Toggle DAP UI                       |

**Workflow**: Place a breakpoint with `<Space>db`, launch with `<Space>dc`. The UI opens automatically showing variables, call stack, and console.

---

### 3.13 Sessions (persistence.nvim)

Auto-saves your session (open buffers, window layout, cursor positions).

| Shortcut     | Action                              |
| ------------ | ----------------------------------- |
| `<Space>ps`  | Restore session for current dir     |
| `<Space>pS`  | Choose a session to restore         |
| `<Space>pl`  | Restore last session                |
| `<Space>pd`  | Don't save session on exit          |

Session is saved automatically when you quit Neovim.

---

### 3.14 Markdown Preview

| Shortcut     | Action                              |
| ------------ | ----------------------------------- |
| `<Space>mp`  | Toggle markdown preview in browser  |

Opens a live preview that auto-refreshes as you edit.

---

### 3.15 Which-key - Keymap Help

Press `<Space>` and wait 300ms. A popup shows all available shortcuts.

**Groups:**

| Prefix       | Group                  |
| ------------ | ---------------------- |
| `<Space>b`   | Buffers                |
| `<Space>c`   | Code (LSP)             |
| `<Space>d`   | Debug (DAP)            |
| `<Space>f`   | Find (Telescope)       |
| `<Space>g`   | Git                    |
| `<Space>h`   | Harpoon                |
| `<Space>m`   | Minimap / Markdown     |
| `<Space>o`   | Opencode               |
| `<Space>p`   | Persistence (sessions) |
| `<Space>s`   | Search & Replace       |
| `<Space>t`   | Tailwind               |
| `<Space>x`   | Trouble (diagnostics)  |
| `<Space>y`   | Yank path              |

---

### 3.16 Noice - Better UI

Automatically improves Neovim UI:
- Commands appear in a centered popup
- Long messages open in a split
- LSP documentation has borders
- Notifications are more visible

No shortcuts to learn, everything works automatically.

---

## 4. NAVIGATION

### Within the file

| Shortcut   | Action                      |
| ---------- | --------------------------- |
| `h/j/k/l`  | Left/Down/Up/Right          |
| `gg`       | Beginning of file           |
| `G`        | End of file                 |
| `0`        | Beginning of line           |
| `$`        | End of line                 |
| `^`        | First non-blank character   |
| `w`        | Next word                   |
| `b`        | Previous word               |
| `e`        | End of word                 |
| `H`        | Line start (configured)     |
| `L`        | Line end (configured)       |
| `J`        | 5 lines down                |
| `K`        | 5 lines up                  |
| `Ctrl+d`   | Half page down              |
| `Ctrl+u`   | Half page up                |
| `{`        | Previous paragraph          |
| `}`        | Next paragraph              |
| `s`        | Flash (quick jump)          |

### Between windows (splits)

| Shortcut          | Action                            |
| ----------------- | --------------------------------- |
| `<Space>v`        | Vertical split                    |
| `<Space>s`        | Horizontal split                  |
| `<Space>h/j/k/l`  | Go to directional window         |
| `<Space>q`        | Close window                      |
| `<Space>=`        | Equalize windows                  |
| `Ctrl+w w`        | Next window                       |
| `Ctrl+w p`        | Last used window                  |

### Between buffers

| Shortcut     | Action               |
| ------------ | -------------------- |
| `<Space>bl`  | List buffers         |
| `<Space>bn`  | Next buffer          |
| `<Space>bp`  | Previous buffer      |
| `<Space>bd`  | Close buffer         |
| `<Space>fb`  | Telescope buffers    |
| `<Space>1-5` | Harpoon files        |

### Window resizing

| Command               | Action                       |
| --------------------- | ---------------------------- |
| `:res +5`             | Height +5 lines              |
| `:res -5`             | Height -5 lines              |
| `:vert res +10`       | Width +10 columns            |
| `:vert res -10`       | Width -10 columns            |
| `Ctrl+w =`            | Equalize all windows         |
| `Ctrl+w _`            | Maximize height              |

### Neovim / Zellij navigation

The same shortcuts work in Neovim and Zellij (via vim-tmux-navigator):

- `Ctrl+h/j/k/l`: Navigation between panes
- `Alt+h/j/k/l`: Zellij navigation (when Neovim doesn't have focus)

---

## 5. EDITING

### Deletion

| Shortcut  | Action                           |
| --------- | -------------------------------- |
| `x`       | Delete character under cursor    |
| `X`       | Delete character before cursor   |
| `dd`      | Delete line                      |
| `dw`      | Delete to end of word            |
| `d$`      | Delete to end of line            |
| `d0`      | Delete to beginning of line      |
| `D`       | Delete to end of line            |

### Copy/Paste

| Shortcut  | Action                   |
| --------- | ------------------------ |
| `yy`      | Copy (yank) line         |
| `yw`      | Copy word                |
| `y$`      | Copy to end of line      |
| `Y`       | Copy to end of line      |
| `p`       | Paste after              |
| `P`       | Paste before             |

### Undo/Redo

| Shortcut  | Action                     |
| --------- | -------------------------- |
| `u`       | Undo                       |
| `U`       | Redo                       |
| `.`       | Repeat last action         |

### Indentation

| Shortcut     | Action                   |
| ------------ | ------------------------ |
| `>>`         | Indent line              |
| `<<`         | Unindent line            |
| `>` (visual) | Indent selection         |
| `<` (visual) | Unindent selection       |

### Change/Replace text

| Shortcut  | Action                   | Example                                          |
| --------- | ------------------------ | ------------------------------------------------ |
| `r`       | Replace one character    | `rx` replaces the character under cursor with x  |
| `cw`      | Change word              | Changes from cursor to end of word               |
| `ciw`     | Change inner word        | Changes the entire word under cursor             |
| `caw`     | Change around word       | Changes the word + space                         |
| `ci"`     | Change inner `""`        | Changes content between quotes                   |
| `ci(`     | Change inner `()`        | Changes content between parentheses              |
| `ci{`     | Change inner `{}`        | Changes content between braces                   |
| `cit`     | Change inner tag         | Changes content between HTML/XML tags            |

**Practical examples:**

```javascript
// You have: const name = "John";
// Place the cursor on "John", type ci"
// Type Bob
// Result: const name = "Bob";

// You have: console.log(message)
// Type ci(, type "Hello"
// Result: console.log("Hello")
```

### Search and replace

| Command                 | Action                                  |
| ----------------------- | --------------------------------------- |
| `:%s/old/new/g`         | Replace all occurrences in file         |
| `:%s/old/new/gc`        | Replace with confirmation               |
| `:s/old/new/g`          | Replace all on current line             |

**Leader shortcuts:**

```
<Space>r     > Opens :%s//g (ready to type)
<Space>R     > Replaces the word under cursor
<Space>sr    > Search & Replace project-wide (grug-far)
<Space>sw    > Search & Replace word under cursor (grug-far)
```

### Other edits

| Shortcut  | Action         |
| --------- | -------------- |
| `~`       | Toggle case    |

### vim-unimpaired shortcuts

| Shortcut    | Action                          |
| ----------- | ------------------------------- |
| `]q` / `[q` | Next/previous quickfix         |
| `]l` / `[l` | Next/previous location list    |
| `]b` / `[b` | Next/previous buffer           |
| `]e` / `[e` | Move line down/up              |
| `]<Space>`  | Add empty line below           |
| `[<Space>`  | Add empty line above           |

---

## 6. FILE MANAGEMENT

### Save and quit

| Command       | Action                      |
| ------------- | --------------------------- |
| `<Space>w`    | Save                        |
| `<Space>W`    | Save all                    |
| `<Space>x`    | Save and quit               |
| `<Space>Q`    | Quit all (force)            |
| `:w`          | Save                        |
| `:q`          | Quit                        |
| `:wq` or `ZZ` | Save and quit              |
| `:q!`         | Quit without saving         |

### Search

| Command  | Action                                  |
| -------- | --------------------------------------- |
| `/word`  | Search forward                          |
| `?word`  | Search backward                         |
| `n`      | Next result (centered)                  |
| `N`      | Previous result (centered)              |
| `*`      | Search word under cursor (centered)     |
| `#`      | Search word backward (centered)         |
| `<Space><Space>` | Clear search highlight           |

### Copy file path

| Shortcut        | Action                           |
| --------------- | -------------------------------- |
| `<Space>yp`     | Copy absolute path               |
| `<Space>yr`     | Copy relative path               |
| `<Space>yf`     | Copy filename                    |

### Custom commands

| Command           | Action                              |
| ----------------- | ----------------------------------- |
| `:FormatJSON`     | Pretty-print JSON                   |
| `:ClearMarks`     | Delete all marks                    |
| `:Count {pat}`    | Count occurrences                   |
| `:TailwindWrapAll`| Wrap Tailwind classes in all files  |
| `:Lazy`           | Plugin manager (or `<Space>L`)      |

---

## 7. TROUBLESHOOTING

### Plugins not working

```
:Lazy sync        # Sync plugins
:Lazy update      # Update plugins
:Lazy             # View status (or <Space>L)
```

### LSP not working

```bash
# Check Node.js (required for some LSP servers)
node --version

# Open Mason to manage LSP servers
:Mason

# Check LSP status in Neovim
:LspInfo

# Restart the LSP server
:LspRestart
```

### Font issues (incorrect icons)

Install a Nerd Font:
- [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip)
- [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip)

Configure the font in Kitty (`~/.config/kitty/kitty.conf`).

### Common errors

**"I can't type!"**
> You are in NORMAL mode. Press `i` to switch to INSERT mode

**"I can't quit Neovim!"**
> Type `:q!` (quit without saving) or `:wq` (save and quit)

**"Telescope won't open!"**
> Make sure you are in NORMAL mode (press Esc)

**"I'm stuck in Neo-tree!"**
> `q` to close Neo-tree, or `Ctrl+w` then `l` to go right

**"Formatting doesn't work!"**
> Check that Prettier is installed: `npm list -g prettier`

**"I forgot a shortcut!"**
> Press `<Space>` and wait — which-key will show you everything

---

## 8. QUICK REFERENCE

### Shortcuts by plugin

| Plugin           | Shortcut     | Action                            |
| ---------------- | ------------ | --------------------------------- |
| **Telescope**    | `<Space>ff`  | Files                             |
| **Telescope**    | `<Space>fg`  | Grep                              |
| **Telescope**    | `<Space>fb`  | Buffers                           |
| **Telescope**    | `<Space>fh`  | History                           |
| **Telescope**    | `<Space>fc`  | Commands                          |
| **Telescope**    | `<Space>fm`  | Keymaps                           |
| **Telescope**    | `<Space>ft`  | TODOs                             |
| **Neo-tree**     | `<Space>e`   | Toggle                            |
| **Neo-tree**     | `<Space>E`   | Locate file                       |
| **Neo-tree**     | `<Space>ep`  | Back to project root              |
| **Harpoon**      | `<Space>ha`  | Add file                          |
| **Harpoon**      | `<Space>hh`  | Menu                              |
| **Harpoon**      | `<Space>1-5` | Jump to file 1-5                  |
| **LSP**          | `gd`         | Definition                        |
| **LSP**          | `gr`         | References                        |
| **LSP**          | `<Space>rn`  | Rename                            |
| **LSP**          | `<Space>d`   | Doc                               |
| **LSP**          | `<Space>ca`  | Code action                       |
| **conform**      | `<Space>f`   | Format                            |
| **Trouble**      | `<Space>xx`  | Diagnostics (project)             |
| **Trouble**      | `<Space>xd`  | Diagnostics (file)                |
| **Trouble**      | `<Space>xt`  | TODOs                             |
| **Git**          | `<Space>gs`  | Status                            |
| **Git**          | `<Space>gd`  | Diff                              |
| **gitsigns**     | `]c` / `[c`  | Changes                           |
| **gitsigns**     | `<Space>hs`  | Stage hunk                        |
| **gitsigns**     | `<Space>hp`  | Preview hunk                      |
| **mini.map**     | `<Space>mm`  | Toggle minimap                    |
| **grug-far**     | `<Space>sr`  | Search & Replace                  |
| **grug-far**     | `<Space>sw`  | Search word under cursor          |
| **DAP**          | `<Space>db`  | Breakpoint                        |
| **DAP**          | `<Space>dc`  | Continue/launch                   |
| **DAP**          | `<Space>du`  | Toggle UI                         |
| **persistence**  | `<Space>ps`  | Restore session                   |
| **TODO**         | `]t` / `[t`  | Next/Previous TODO                |
| **ts-comments**  | `gcc`        | Comment line                      |
| **ts-comments**  | `gc`         | Comment (visual)                  |
| **Surround**     | `cs"'`       | Change " to '                     |
| **Surround**     | `ds"`        | Delete ""                         |
| **Surround**     | `ysiw'`      | Add '' to word                    |
| **flash**        | `s`          | Quick jump                        |
| **flash**        | `S`          | Treesitter selection              |
| **markdown**     | `<Space>mp`  | Preview                           |
| **which-key**    | `<Space>`    | Show all shortcuts (wait 300ms)   |
| **Lazy**         | `<Space>L`   | Plugin manager                    |

### General shortcuts

```
LEADER = Space

FILES:
  <Space>ff    > Find file (Telescope)
  <Space>fg    > Search text (grep)
  <Space>fb    > Buffers
  <Space>ft    > TODOs
  <Space>e     > Neo-tree
  <Space>ep    > Neo-tree: project root
  <Space>ha    > Harpoon: add file
  <Space>1-5   > Harpoon: jump to file
  <Space>w     > Save
  <Space>x     > Save and quit

NAVIGATION:
  h/j/k/l       > Move
  H/L           > Line start/end
  J/K           > 5 lines down/up
  gg/G          > Beginning/End of file
  w/b           > Next/Previous word
  s             > Flash (quick jump)
  <Space>v      > Vertical split
  <Space>s      > Horizontal split
  <Space>h/j/k/l > Switch window
  <Space>bn/bp  > Next/Previous buffer

EDITING:
  i/a/o         > Insert mode
  jj/jk         > Exit insert
  dd/yy/p       > Cut/Copy/Paste
  u/U           > Undo/Redo
  >>/<<         > Indent
  cw/ciw        > Change word
  ci"           > Change inside quotes
  gcc           > Comment line
  gc            > Comment (visual)
  cs"'          > Change quotes
  ds"           > Delete quotes
  ysiw'         > Add quotes to word

SEARCH/REPLACE:
  /word         > Search
  n/N           > Next/Previous (centered)
  *             > Search word under cursor
  <Space>r      > Replace in file
  <Space>R      > Replace word under cursor
  <Space>sr     > Search & Replace (project)

LSP:
  gd            > Definition
  gr            > References
  <Space>rn     > Rename
  <Space>d      > Documentation
  [g/]g         > Diagnostics
  <Space>ca     > Code action
  <Space>f      > Format

GIT:
  <Space>gs     > Git status
  <Space>gd     > Diff
  ]c/[c         > Next/Previous change
  <Space>hs     > Stage hunk

DIAGNOSTICS:
  <Space>xx     > All diagnostics
  <Space>xd     > File diagnostics
  ]t/[t         > Next/Previous TODO

DEBUG:
  <Space>db     > Breakpoint
  <Space>dc     > Continue/Launch
  <Space>do     > Step over
  <Space>di     > Step into
  <Space>du     > Toggle UI

SESSION:
  <Space>ps     > Restore session
  <Space>pl     > Last session

MISC:
  <Space>mp     > Markdown preview
  <Space>tw     > Tailwind wrap
  <Space>L      > Lazy (plugins)
  <Space>       > Which-key (wait for help)
```

---

**Last updated:** April 2, 2026
**Version:** 5.0

For complete Zellij shortcuts: `cat ~/.config/zellij/SHORTCUTS.md`
