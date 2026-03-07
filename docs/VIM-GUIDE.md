# NEOVIM GUIDE - Complete Usage

Complete guide to using Neovim as an IDE with all installed plugins.

---

## TABLE OF CONTENTS

1. [Quick start](#1-quick-start)
2. [The 3 Vim modes](#2-the-3-vim-modes)
3. [Essential plugins](#3-essential-plugins)
   - Telescope (fuzzy finder)
   - NvimTree (file explorer)
   - Mason/native LSP + nvim-cmp (autocompletion)
   - Git (fugitive + gitsigns + quick navigation)
   - Minimap (mini.map)
   - Snippets (LuaSnip)
   - Advanced editing (Comment.nvim, nvim-surround, flash.nvim)
4. [Navigation](#4-navigation)
5. [Editing](#5-editing)
   - Movement
   - Copy/Paste
   - Search and replace
   - Comment/Surround
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

---

## 2. THE 3 VIM MODES

Neovim has 3 modes. **You must know which mode you are in!**

### NORMAL mode (commands)

- Default mode when opening
- Type commands but NOT text
- Cursor: block ▇

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
| NORMAL → INSERT | `i`                     | Insert before cursor     |
| NORMAL → INSERT | `a`                     | Append after cursor      |
| NORMAL → INSERT | `o`                     | Open line below          |
| NORMAL → INSERT | `I`                     | Insert at line start     |
| NORMAL → INSERT | `A`                     | Append at line end       |
| NORMAL → INSERT | `O`                     | Open line above          |
| INSERT → NORMAL | `Esc` or `jj` or `jk`  | Exit insert mode         |
| NORMAL → VISUAL | `v`                     | Character selection      |
| NORMAL → VISUAL | `V`                     | Line selection           |
| NORMAL → VISUAL | `Ctrl+v`                | Block selection          |

💡 **TIP**: Type `jj` quickly to exit insert mode (faster than Esc)

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
6. Navigation: `Ctrl+j/k` or `↑` `↓`
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
```

---

### 3.2 NvimTree - File Explorer

Built-in file explorer (replaces NERDTree).

#### Open/Close

```
<Space>e     # Open/close NvimTree
<Space>E     # Locate current file
```

#### Navigation in NvimTree

| Action           | Shortcut        | Description                       |
| ---------------- | --------------- | --------------------------------- |
| Open file        | `Enter` or `o`  | Opens in the current window       |
| Open in split    | `<C-x>`         | Horizontal split                  |
| Open in vsplit   | `<C-v>`         | Vertical split                    |
| Expand folder    | `o` or `Enter`  | Shows files                       |
| Collapse folder  | `o` or `Enter`  | Hides files                       |
| Go up            | `-`             | Parent directory                  |
| Refresh          | `R`             | Updates the tree                  |
| Close            | `q`             | Closes NvimTree                   |

#### Create/Modify files

```
a             # Add a file or folder (add / at the end for a folder)
d             # Delete
r             # Rename
```

#### Quick navigation in NvimTree

| Shortcut  | Action          | Description                           |
| --------- | --------------- | ------------------------------------- |
| `/`       | Search          | Type the file/folder name             |
| `P`       | Root            | Go to the tree root                   |
| `p`       | Parent          | Go to the file's parent folder        |
| `-`       | Go up           | Parent becomes root                   |
| `W`       | Collapse all    | Closes all open folders               |
| `E`       | Expand all      | Opens all folders                     |

---

### 3.3 Mason/Native LSP + nvim-cmp - LSP (Language Server Protocol)

Intelligent autocompletion, diagnostics, refactoring (replaces coc.nvim).

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
[g            # Previous error
]g            # Next error
[G            # Previous error (severe errors only)
]G            # Next error (severe errors only)
<Space>cd     # Diagnostics list
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

### 3.4 Git - Fugitive + gitsigns.nvim

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

- `s` on a file → Stage
- `u` on a file → Unstage
- `cc` → Commit
- `Enter` on a file → Open the file
- `o` on a file → Open the file (split)
- `O` on a file → Open the file (vsplit)

#### Quick navigation in modified files

**Problem**: You have modified 15 files and want to quickly review them without searching through the file tree.

**Solution 1: Navigation with gitsigns (recommended)**

```
]c          → Jump to the next change (hunk)
[c          → Jump to the previous change (hunk)
```

These shortcuts let you navigate directly between all hunks (change blocks) in the current buffer.

**Solution 2: Telescope with modified files only**

```
<Space>ff          → Open Telescope
# Type a few letters of the filename
# Only modified files appear at the top (thanks to git)
```

**Solution 3: From the :Git window**

```bash
# Open the status
<Space>gs

# Navigate with j/k to select a file
# Press Enter to open it
# Or 'o' to open in a split
# Or 'O' to open in a vsplit

# Once the file is open:
<Space>gd     → View the diff of modifications
]c / [c       → Jump to next/previous change
```

**Solution 4: List of modified buffers**

```
<Space>fb      → List all buffers (Telescope)
# Modified files are marked with +
# Type to filter
```

**Recommended workflow for quick review:**

```bash
1. Or use :Git then navigate:
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

---

### 3.5 Minimap (mini.map)

Code mini-map (like VS Code), implemented in pure Lua (no Rust dependency).

#### Shortcuts

| Shortcut     | Action                    |
| ------------ | ------------------------- |
| `<Space>mm`  | Toggle (show/hide)        |
| `<Space>mc`  | Close                     |
| `<Space>mr`  | Refresh                   |
| `<Space>mf`  | Toggle focus              |

#### Configuration

- Auto-start: yes (code files only)
- Position: right
- Width: 10 columns
- Git integration: enabled (via gitsigns)

---

### 3.6 Snippets (LuaSnip + friendly-snippets)

Reusable code templates (replaces UltiSnips + vim-snippets).

#### Usage

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

// Type "for" + Tab
for (let i = 0; i < |; i++) {

}
```

Snippets come from **friendly-snippets** (VSCode-compatible collection).

---

### 3.7 Advanced editing (Comment.nvim + nvim-surround + flash.nvim)

#### Comment.nvim - Comment/Uncomment

Quickly comment or uncomment lines of code.

| Shortcut  | Action              | Description                                        |
| --------- | ------------------- | -------------------------------------------------- |
| `gcc`     | Comment line        | Toggle comment on the current line                 |
| `gc`      | Comment (visual)    | In visual mode, comments the selection             |
| `gcap`    | Comment paragraph   | Comments the entire block (paragraph)              |

**Examples:**

```javascript
// Position yourself on a line
// Type gcc
// The line is commented/uncommented

// In visual mode (V to select multiple lines)
// Type gc
// All selected lines are commented
```

#### nvim-surround - Manage surroundings

Add, change or delete character pairs (parentheses, quotes, etc.).

| Shortcut  | Action                    | Example              |
| --------- | ------------------------- | -------------------- |
| `cs"'`    | Change surround           | `"text"` → `'text'` |
| `cs'"`    | Change surround           | `'text'` → `"text"` |
| `cs"(`    | Change surround           | `"text"` → `(text)` |
| `cs({`    | Change surround           | `(text)` → `{text}` |
| `ds"`     | Delete surround           | `"text"` → `text`   |
| `ds(`     | Delete surround           | `(text)` → `text`   |
| `ysiw'`   | Add surround to word      | `text` → `'text'`   |
| `ysiW"`   | Add surround to WORD      | `text` → `"text"`   |
| `yss'`    | Add surround to line      | `text` → `'text'`   |

**In visual mode:**

- Select text
- Type `S"` to surround with `"`
- Type `S(` to surround with `(`

**Examples:**

```javascript
// You have: "hello world"
// Place the cursor anywhere on the line
// Type cs"'
// Result: 'hello world'

// You have: text
// Type ysiw'
// Result: 'text'

// You have: if (condition) { ... }
// Type ds(
// Result: if condition { ... }
```

#### flash.nvim - Quick navigation

Ultra-fast navigation within the file (replaces vim-easymotion).

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

### Window resizing

| Command               | Action                       |
| --------------------- | ---------------------------- |
| `:res +5`             | Height +5 lines              |
| `:res -5`             | Height -5 lines              |
| `:vert res +10`       | Width +10 columns            |
| `:vert res -10`       | Width -10 columns            |
| `:resize 20`          | Fixed height to 20           |
| `:vertical resize 80` | Fixed width to 80            |
| `Ctrl+w =`            | Equalize all windows         |
| `Ctrl+w _`            | Maximize height              |
| `Ctrl+w \|`           | Maximize width               |

### Neovim ↔ Zellij navigation

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
| `Ctrl+r`  | Redo                       |
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
| `R`       | Replace mode             | Replaces all characters until Esc                |
| `cw`      | Change word              | Changes from cursor to end of word               |
| `ciw`     | Change inner word        | Changes the entire word under cursor             |
| `caw`     | Change around word       | Changes the word + space                         |
| `ci"`     | Change inner `""`        | Changes content between quotes                   |
| `ci(`     | Change inner `()`        | Changes content between parentheses              |
| `ci{`     | Change inner `{}`        | Changes content between braces                   |
| `ci[`     | Change inner `[]`        | Changes content between brackets                 |
| `ci<`     | Change inner `<>`        | Changes content between angle brackets           |
| `cit`     | Change inner tag         | Changes content between HTML/XML tags            |

**Practical examples:**

```javascript
// You have: const name = "John";
// Place the cursor on "John"
// Type ci"
// Type Bob
// Result: const name = "Bob";

// You have: function test()
// Place the cursor on "test"
// Type ciw
// Type newName
// Result: function newName()

// You have: console.log(message)
// Type ci(
// Type "Hello"
// Result: console.log("Hello")
```

### Search and replace (substitution)

Replace text in the entire file or a selection.

| Command                 | Action                                  | Description                                            |
| ----------------------- | --------------------------------------- | ------------------------------------------------------ |
| `:%s/old/new/`          | Replace first occurrence per line       | On each line, replaces the first occurrence             |
| `:%s/old/new/g`         | Replace all occurrences                 | Replaces ALL occurrences in the file                    |
| `:%s/old/new/gc`        | Replace with confirmation               | Asks for confirmation for each replacement              |
| `:s/old/new/`           | Replace on current line                 | Only the first occurrence on the current line           |
| `:s/old/new/g`          | Replace all on line                     | All occurrences on the current line                     |

**Leader shortcuts:**

```
<Space>r     → Opens :%s//g (ready to type old and new)
<Space>R     → Replaces the word under cursor (:s/<word>//g)
```

**Practical examples:**

```javascript
// Replace "var" with "const" in the entire file
:%s/var/const/g

// Replace all occurrences of "foo" with "bar" with confirmation
:%s/foo/bar/gc

// Replace on the current line only
:s/old/new/g

// Use regular expressions
:%s/\d\+/NUMBER/g    // Replaces all numbers with "NUMBER"

// Replace with the word under cursor
// Place the cursor on "getUser"
// Type <Space>R
// Type "fetchUser"
// Result: replaces all occurrences of "getUser" with "fetchUser"
```

**Tips:**

- Use `&` to repeat the last substitution on another line
- Use `:%s//~/g` to reuse the previous pattern
- Add `i` at the end to ignore case: `:%s/foo/bar/gi`

### Other edits

| Shortcut  | Action         |
| --------- | -------------- |
| `~`       | Toggle case    |
| `J`       | Join lines     |

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
| `:wqa`        | Save all and quit           |

### Search

| Command  | Action                                  |
| -------- | --------------------------------------- |
| `/word`  | Search forward                          |
| `?word`  | Search backward                         |
| `n`      | Next result                             |
| `N`      | Previous result                         |
| `*`      | Search word under cursor (forward)      |
| `#`      | Search word under cursor (backward)     |
| `:noh`   | Disable highlight                       |

### File operations

| Command       | Action                 |
| ------------- | ---------------------- |
| `:e file`     | Edit a file            |
| `:saveas name`| Save as                |

### Copy file path

| Shortcut        | Action                           | Example                            |
| --------------- | -------------------------------- | ---------------------------------- |
| `<Space>yp`     | Copy absolute path               | `/home/user/project/app/file.ts`   |
| `<Space>yr`     | Copy relative path               | `app/file.ts`                      |
| `<Space>yf`     | Copy filename                    | `file.ts`                          |
| `:CopyPath`     | Copy absolute path (command)     |                                    |
| `:CopyRelPath`  | Copy relative path (command)     |                                    |
| `:CopyFileName` | Copy filename (command)          |                                    |

---

## 7. TROUBLESHOOTING

### Plugins not working

#### Reinstall / sync plugins

```
:Lazy sync
```

#### Update plugins

```
:Lazy update
```

#### View plugin status

```
:Lazy
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
→ You are in NORMAL mode. Press `i` to switch to INSERT mode

**"I can't quit Neovim!"**
→ Type `:q!` (quit without saving) or `:wq` (save and quit)

**"Telescope won't open!"**
→ Make sure you are in NORMAL mode (press Esc)
→ Check `<Space>ff` (space then f then f)

**"I'm stuck in NvimTree!"**
→ `q` to close NvimTree
→ Or `Ctrl+w` then `l` to go right

**"Formatting doesn't work!"**
→ Check that Prettier is installed: `npm list -g prettier`
→ Or install it: `npm install -g prettier`

**"I'm looking for a command!"**
→ `:help windows` → Help on windows
→ `:help window-resize` → Resizing
→ `:help split` → Split command
→ `<Space>fc` → Search commands (Telescope)

---

## 8. QUICK REFERENCE

### Shortcuts by plugin

| Plugin         | Shortcut     | Action                            |
| -------------- | ------------ | --------------------------------- |
| **Telescope**  | `<Space>ff`  | Files                             |
| **Telescope**  | `<Space>fg`  | Grep                              |
| **Telescope**  | `<Space>fb`  | Buffers                           |
| **Telescope**  | `<Space>fh`  | History                           |
| **Telescope**  | `<Space>fc`  | Commands                          |
| **Telescope**  | `<Space>fm`  | Keymaps                           |
| **NvimTree**   | `<Space>e`   | Toggle                            |
| **NvimTree**   | `<Space>E`   | Locate file                       |
| **LSP**        | `gd`         | Definition                        |
| **LSP**        | `gr`         | References                        |
| **LSP**        | `<Space>rn`  | Rename                            |
| **LSP**        | `<Space>d`   | Doc                               |
| **LSP**        | `<Space>ca`  | Code action                       |
| **conform**    | `<Space>f`   | Format                            |
| **Git**        | `<Space>gs`  | Status                            |
| **Git**        | `<Space>gd`  | Diff                              |
| **gitsigns**   | `]c` / `[c`  | Changes                           |
| **gitsigns**   | `<Space>hs`  | Stage hunk                        |
| **gitsigns**   | `<Space>hp`  | Preview hunk                      |
| **mini.map**   | `<Space>mm`  | Toggle minimap                    |
| **Comment**    | `gcc`        | Comment line                      |
| **Comment**    | `gc`         | Comment (visual)                  |
| **Surround**   | `cs"'`       | Change " to '                     |
| **Surround**   | `ds"`        | Delete ""                         |
| **Surround**   | `ysiw'`      | Add '' to word                    |
| **flash**      | `s`          | Quick jump                        |
| **flash**      | `S`          | Treesitter selection              |

### General shortcuts

```
LEADER = Space

FILES:
  <Space>ff    → Open file (Telescope)
  <Space>fg    → Search text
  <Space>fb    → Buffers
  <Space>e     → NvimTree
  <Space>w     → Save
  <Space>x     → Save and quit

NAVIGATION:
  h/j/k/l       → Move
  gg/G          → Beginning/End of file
  0/$           → Beginning/End of line
  w/b           → Next/Previous word
  s             → Flash (quick jump)
  <Space>v      → Vertical split
  <Space>s      → Horizontal split
  <Space>h/j/k/l → Switch window
  <Space>bn/bp  → Next/Previous buffer

EDITING:
  i/a/o         → Insert mode
  jj/jk         → Exit insert
  dd/yy/p       → Cut/Copy/Paste
  u/U           → Undo/Redo
  >>/<<         → Indent
  cw/ciw        → Change word
  ci"           → Change inside quotes
  gcc           → Comment line
  gc            → Comment (visual)
  cs"'          → Change quotes
  ds"           → Delete quotes
  ysiw'         → Add quotes to word

SEARCH/REPLACE:
  /word         → Search
  n/N           → Next/Previous
  *             → Search word under cursor
  <Space>r      → Replace (:%s//g)
  <Space>R      → Replace word under cursor
  :%s/a/b/g     → Replace all in file
  :%s/a/b/gc    → Replace with confirmation

LSP:
  gd            → Definition
  gr            → References
  <Space>rn     → Rename
  <Space>d      → Documentation
  [g/]g         → Errors
  <Space>ca     → Code action
  <Space>f      → Format

GIT:
  <Space>gs     → Git status
  <Space>gd     → Diff
  ]c/[c         → Next/Previous change
  <Space>hs     → Stage change
  <Space>hu     → Undo stage
```

---

**Last updated:** March 3, 2026
**Version:** 4.0

For complete Zellij shortcuts: `cat ~/.config/zellij/SHORTCUTS.md`
