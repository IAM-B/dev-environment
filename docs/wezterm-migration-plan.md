# Plan de migration Kitty + Zellij → WezTerm

**Objectif principal :** support natif du Kitty graphics protocol pour voir
les images inline dans LazyVim (snacks.image), ce qui est bloque actuellement
par Zellij.

**Raison secondaire :** simplifier le stack (terminal + multiplexer en un).

---

## Setup actuel a remplacer

- **Kitty** — terminal (config TokyoNight, opacity 1.0, font)
- **Zellij 0.43.1** — multiplexer (layouts code/dev/agents, session naming,
  theme tokyonight, keybindings custom Ctrl+p/t/n/g)
- **Fonctions bash** `zc`/`zd`/`za` — lancent Zellij avec layout + nom de session
- **Banner** TokyoNight dans `.bashrc` (figlet + sed ANSI)
- **Starship** prompt (compatible, pas a modifier)
- **LazyVim** (compatible, pas a modifier)

---

## Phase 1 — Preparation (30 min)

- Installer WezTerm : `pacman -S wezterm` (ou AUR selon la distro)
- Lire les concepts cles WezTerm :
  - **Workspaces** ≈ sessions Zellij
  - **Tabs** ≈ tabs Zellij
  - **Panes** ≈ panes Zellij
  - **Domains** — local vs multiplexer server
- Creer `~/.config/wezterm/wezterm.lua` vide pour tests
- **Garder Kitty + Zellij installes en parallele** pendant la migration

## Phase 2 — Config de base (1h)

- Font + TokyoNight (WezTerm a un thème `tokyonight` integre via
  `color_scheme = "Tokyo Night"`)
- Reporter depuis `kitty.conf` :
  - `font_family` et `font_size`
  - `window_padding`
  - `background_opacity` (si voulu)
  - `enable_tab_bar`, `hide_tab_bar_if_only_one_tab`
  - Cursor style
  - Bell disabled
- **Copy behavior** : `copy_on_select = true` (equivalent Zellij)
- **Clipboard** : `copy_clipboard` → integration systeme via `wezterm.action.CopyTo`
- Test : lancer `wezterm` et verifier le rendu visuel

## Phase 3 — Migration du multiplexer (2-3h, le plus gros morceau)

### 3.1 Layouts
Reproduire les layouts Zellij en Lua :
- **`code`** : 65% LazyVim + 35% Claude Code (split vertical)
- **`dev`** : layout dev (a definir)
- **`agents`** : layout agents (a definir)

Approche : fonctions Lua qui creent les splits et lancent les commandes
```lua
-- Exemple pseudo-code
local function launch_code_layout(window, pane)
  local editor = pane:split({ direction = 'Right', size = 0.35 })
  editor:send_text('claude --resume\n')
  pane:send_text('lvim\n')
end
```

### 3.2 Session naming
- Pattern `code-DIRNAME-HHMM` → fonction Lua qui cree un workspace nomme
- Utiliser `wezterm.mux.spawn_window` avec `workspace = name`

### 3.3 Keybindings
Equivalents WezTerm pour chaque mode Zellij :
- `Ctrl+p` (pane mode) → gardé ou remplacé par directs `Ctrl+h/j/k/l`
- `Ctrl+t` (tab mode) → idem
- `Ctrl+n` (resize mode) → WezTerm a `ActivateKeyTable`
- `Ctrl+g` (lock mode) → equivalent `LeaderKey` ou mode custom
- `Ctrl+q` (quit) → `QuitApplication`
- Navigation directe `Ctrl+h/j/k/l` dans les panes

### 3.4 Status bar
- Configurer via `wezterm.on('update-right-status', ...)`
- Afficher : workspace name, nombre de panes, heure
- Couleurs TokyoNight

## Phase 4 — Shell integration (30 min)

Mettre a jour `~/.bashrc` :
- `zc()` → `wezterm cli spawn --workspace "code-${PWD##*/}-$(date +%H%M)"`
  + lancement auto du layout
- `zd()` → idem pour dev
- `za()` → idem pour agents
- **Banner TokyoNight** : aucune modif (les sequences ANSI marchent partout)
- **Starship** : aucune modif necessaire

## Phase 5 — Tests (1h)

Tests critiques a valider :
- [ ] **Images** : `lvim image.png` affiche l'image inline (objectif principal)
- [ ] LazyVim : tous les keybindings fonctionnent
- [ ] LazyVim : couleurs TokyoNight rendu correct
- [ ] LazyVim : performance OK (pas de lag)
- [ ] Session persistence (workspaces WezTerm)
- [ ] Claude Code dans un pane a cote : pas de probleme de rendu
- [ ] Copy/paste via souris
- [ ] Copy/paste via clavier
- [ ] Scroll dans l'historique
- [ ] Fermeture propre des panes/workspaces

## Phase 6 — Cleanup & docs (1h)

- **Archiver** (pas supprimer) :
  - `~/.config/kitty/` → renommer en `kitty.bak/` ou garder
  - `~/.config/zellij/` → renommer en `zellij.bak/`
- **Mettre a jour les scripts** :
  - `install-configs.sh` : ajouter wezterm, retirer zellij (garder kitty en fallback ?)
  - `install-deps.sh` : remplacer zellij par wezterm
  - `install.sh` : update si besoin
- **Mettre a jour la doc** :
  - `README-vim-zellij-oc.md` → renommer `README-vim-wezterm.md` ou garder + section migration
  - `lazyvim-guide.md` : section keybindings si changement
  - Nouveau fichier `wezterm-guide.md` (similaire au guide actuel)

---

## Points d'attention

- WezTerm utilise **Lua** partout (plus puissant que le KDL de Zellij mais
  courbe d'apprentissage)
- Les workspaces WezTerm sont **locaux par defaut** — pour la persistance
  type Zellij au reboot, il faut le **multiplexer server**
  (`wezterm-mux-server`). A evaluer si besoin
- Les keybindings actuels (`Ctrl+h/j/k/l`) sont facilement reportables
- **Risque principal** : perdre du temps a reproduire exactement les layouts
  Zellij. Solution : commencer simple puis iterer
- Le Kitty graphics protocol marche **nativement** dans WezTerm — c'est la
  raison d'etre de la migration

---

## Estimation totale : ~5-6h sur un weekend

Migration progressive recommandee : faire phases 1-3 en une session, tester,
puis phase 4-6 en une autre session.

---

## Ressources

- [WezTerm docs](https://wezterm.org/)
- [Config Lua reference](https://wezterm.org/config/lua/general.html)
- [Keybindings](https://wezterm.org/config/keys.html)
- [Workspaces](https://wezterm.org/recipes/workspaces.html)
- [Tokyo Night theme](https://wezterm.org/colorschemes/t/index.html#tokyo-night)
