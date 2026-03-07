# BASH SHORTCUTS

Guide to Bash keyboard shortcuts (navigation, editing, history).

---

## BASIC NAVIGATION

| Shortcut   | Action          | Description                              |
|------------|-----------------|------------------------------------------|
| `Ctrl + A` | Beginning of line | Go to the beginning of the line        |
| `Ctrl + E` | End of line     | Go to the end of the line                |
| `Ctrl + B` | Character left  | Move one character to the left           |
| `Ctrl + F` | Character right | Move one character to the right          |
| `Alt + B`  | Previous word   | Move to the previous word                |
| `Alt + F`  | Next word       | Move to the next word                    |

---

## HISTORY

| Shortcut   | Action                                |
|------------|---------------------------------------|
| `Ctrl + P` | Previous command (↑)                  |
| `Ctrl + N` | Next command (↓)                      |
| `Ctrl + R` | Reverse search in history             |
| `Ctrl + S` | Forward search                        |
| `Ctrl + G` | Cancel history search                 |
| `Alt + <`  | First command in history              |
| `Alt + >`  | Last command in history               |

### Incremental search
```
Ctrl + R → type "git" → shows last command with "git"
Ctrl + R → searches for the previous one with "git"
Ctrl + G → cancels the search
```

---

## TERMINAL CONTROL

| Shortcut   | Action                                    |
|------------|-------------------------------------------|
| `Ctrl + L` | Clear screen                              |
| `Ctrl + C` | Interrupt current command                 |
| `Ctrl + Z` | Suspend command (send to background)      |
| `Ctrl + S` | Freeze display (pause)                    |
| `Ctrl + Q` | Unfreeze display (resume)                 |
| `Ctrl + D` | End of file (EOF) / Disconnect            |

---

## LINE MANIPULATION

| Shortcut               | Action                                             |
|------------------------|----------------------------------------------------|
| `Ctrl + J`             | Execute command (Enter)                            |
| `Ctrl + O`             | Execute and show next command                      |
| `Ctrl + X + Ctrl + E`  | Edit command in $EDITOR                            |
| `Alt + #`              | Comment the line (adds # at the beginning)         |
| `Alt + .`              | Insert last argument from previous command         |
| `Alt + _`              | Same as Alt + .                                    |

---

## ZSH-SPECIFIC (if you switch back to zsh)

| Shortcut         | Action              |
|------------------|---------------------|
| `Ctrl + ←`       | Previous word       |
| `Ctrl + →`       | Next word           |
| `Ctrl + Delete`  | Delete next word    |
| `Ctrl + Backspace` | Delete previous word |

---

## BLE.SH-SPECIFIC (with ble.sh installed)

| Shortcut      | Action                          |
|---------------|---------------------------------|
| `→`           | Accept one word from suggestion |
| `End`         | Accept entire suggestion        |
| `Ctrl + F`    | Accept entire suggestion        |
| `Ctrl + G`    | Cancel suggestion               |
| `Ctrl + Space`| Open completion menu            |

---

## PRACTICAL TIPS

### Quick repeat
```bash
!!          # Execute the last command
!-2         # Execute the second-to-last command
!$          # Last argument of the previous command
!*          # All arguments of the previous command
sudo !!     # Execute the last command with sudo
```

### Quick directory navigation
```bash
cd -        # Return to the previous directory
pushd /dir  # Go to /dir and save the current one
popd        # Return to the saved directory
```

### Common combined shortcuts
```bash
# Delete an entire line
Ctrl + U

# Delete from position to end
Ctrl + K

# Delete the word before the cursor
Ctrl + W

# Undo deletion (paste)
Ctrl + Y

# Go to beginning + delete all
Ctrl + A then Ctrl + K

# Go to end + delete all
Ctrl + E then Ctrl + U
```

---

## VIM MODE
```bash
# Enable vim mode
set -o vi          # Bash
bindkey -v         # Zsh
```

| Shortcut                  | Mode   | Action                                  |
|---------------------------|--------|-----------------------------------------|
| `Esc`                     | -      | Switch to normal mode                   |
| `i`                       | Normal | Switch to insert mode                   |
| `a`                       | Normal | Switch to insert mode (after cursor)    |
| `h`, `j`, `k`, `l`       | Normal | Navigation (←, ↓, ↑, →)                |
| `w`                       | Normal | Next word                               |
| `b`                       | Normal | Previous word                           |
| `0`                       | Normal | Beginning of line                       |
| `$`                       | Normal | End of line                             |
| `dd`                      | Normal | Delete line                             |
| `dw`                      | Normal | Delete word                             |
| `x`                       | Normal | Delete character                        |
| `u`                       | Normal | Undo                                    |
| `Ctrl + R`                | Normal | Redo                                    |

---

## HOW TO REMEMBER?

### Key letters to remember:
- **A** = beginning (start of line)
- **E** = End
- **B** = Backward
- **F** = Forward
- **W** = Word
- **K** = Kill (delete)
- **Y** = Yank (paste)
- **P** = Previous
- **N** = Next
- **R** = Reverse (backward search)

### Ctrl = Character, Alt = Word
- `Ctrl + F/B` = Character by character
- `Alt + F/B` = Word by word

### Ctrl + K = Kill (delete to end)
- Think of "Cut" (cut to the end)

---

## SEE ALSO

- [VIM-GUIDE.md](VIM-GUIDE.md) - Vim shortcuts
- [README-vim-zellij-oc.md](README-vim-zellij-oc.md) - General documentation
- [INSTALLED-PLUGINS.md](INSTALLED-PLUGINS.md) - Complete alias list

---

**Last updated:** February 19, 2026
