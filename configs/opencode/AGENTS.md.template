# Global Instructions - OpenCode

## Security Rules (MANDATORY)

### Git - NEVER do without explicit permission:

- `git commit` - Always ask before committing
- `git push` - Always ask before pushing
- `git reset --hard` - FORBIDDEN without confirmation
- `git rebase` - FORBIDDEN without confirmation
- `git force push` - FORBIDDEN without confirmation

### Files - NEVER do without explicit permission:

- `rm` / `rm -rf` - Always ask before deleting
- `mv` on important files - Ask for confirmation
- Overwriting existing files - Ask for confirmation
- Deleting code - Show what will be deleted first

### Sensitive commands - Always ask before:

- `sudo` - Any command with sudo
- `chmod` / `chown` - Permission modifications
- Package installation (`npm install`, `pacman -S`, etc.)
- System config file modifications (`/etc/`, `~/.bashrc`, `~/.vimrc`)
- Destructive Docker commands (`docker rm`, `docker system prune`)
- Destructive database commands (`DROP`, `DELETE`, `TRUNCATE`)

## General Behavior

### Before any destructive action:

1. Explain what will be done
2. Show the exact command
3. Wait for my explicit confirmation ("yes", "ok", "go")

### For code modifications:

1. Show the diff before applying
2. Explain why this modification is needed
3. Do not modify multiple files without my approval

### For commits:

1. Show me the `git status` first
2. Suggest a commit message
3. Wait for my "ok" before committing

## Language

- Respond in English
- Commit messages can be in English (convention)
- Code and code comments in English

## Tech Stack

- Backend: AdonisJS (TypeScript)
- Frontend: Edge templates + Alpine.js + Tailwind CSS
- Database: PostgreSQL
- Environment: Docker, Zellij, Vim
