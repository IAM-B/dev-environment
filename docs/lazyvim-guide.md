# Guide LazyVim - Configuration principale

LazyVim est la configuration Neovim principale du projet. C'est une
distribution preconfigurree avec tout installe et optimise.

**Lancer LazyVim :** `lvim` (configuration principale)
**Config legacy :** `nvim` (ancienne config custom, gardee en reference)
**Workflow Zellij :** `zc` lance automatiquement LazyVim dans le layout code

---

## 1. DIFFERENCES AVEC TA CONFIG

| Concept        | Ta config (nvim)           | LazyVim (lvim)              |
|----------------|----------------------------|-----------------------------|
| Theme          | Dracula                    | TokyoNight                  |
| File explorer  | Neo-tree                   | Neo-tree (meme)             |
| Fuzzy finder   | Telescope                  | snacks.picker (similaire)   |
| Completion     | nvim-cmp                   | blink.cmp (plus moderne)    |
| Commentaires   | ts-comments                | ts-comments (meme)          |
| Surround       | nvim-surround              | mini.surround (different)   |
| Git            | Fugitive + Gitsigns        | Gitsigns + lazygit          |
| Diagnostics    | Trouble                    | Trouble (meme)              |
| Minimap        | minimap.vim                | Pas de minimap              |
| Terminal       | Pas integre (tmux)         | Terminal flottant integre   |
| Session        | persistence.nvim           | persistence.nvim (meme)     |
| Keymaps help   | which-key                  | which-key (meme)            |

**Le plus important :** Les raccourcis sont differents !

---

## 2. PREMIER LANCEMENT

Au premier lancement, LazyVim :
1. Installe tous les plugins automatiquement
2. Installe les parsers Treesitter
3. Affiche un dashboard

### Le Dashboard

Le dashboard s'affiche quand tu ouvres `lvim` sans fichier.
Raccourcis du dashboard :
- `f` : Chercher un fichier
- `g` : Grep (chercher du texte)
- `r` : Fichiers recents
- `c` : Config LazyVim
- `l` : Lazy (plugins)
- `q` : Quitter

---

## 3. NAVIGATION DANS LES FICHIERS

### Chercher un fichier

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>ff`     | Chercher un fichier (racine projet) |
| `<leader>fF`     | Chercher un fichier (dossier courant)|
| `<leader>fr`     | Fichiers recents                    |
| `<leader>fb`     | Buffers ouverts                     |
| `<leader>fg`     | Fichiers git                        |
| `<leader><space>`| Chercher un fichier (racine)        |
| `<leader>,`      | Buffers ouverts                     |
| `<leader>/`      | Grep dans le projet                 |

### Explorateur de fichiers (Neo-tree)

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>e`      | Toggle explorateur (racine)         |
| `<leader>E`      | Toggle explorateur (dossier courant)|
| `<leader>fe`     | Explorateur (picker)                |

### Harpoon (pas inclus par defaut)

LazyVim n'inclut pas Harpoon. Tu dois l'ajouter en "extra" si tu veux.

---

## 4. BUFFERS ET FENETRES

### Buffers (onglets en haut)

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<S-h>`          | Buffer precedent (Shift+h)         |
| `<S-l>`          | Buffer suivant (Shift+l)           |
| `<leader>bb`     | Buffer alternatif (dernier utilise) |
| `<leader>bd`     | Fermer le buffer                    |
| `<leader>bo`     | Fermer tous les autres buffers      |
| `<leader>bj`     | Choisir un buffer (picker)          |
| `<leader>bp`     | Pin/unpin le buffer                 |
| `<leader>bP`     | Fermer les buffers non-pinnes       |

### Fenetres (splits)

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>-`      | Split horizontal                    |
| `<leader>\|`     | Split vertical                      |
| `<leader>wd`     | Fermer la fenetre                   |
| `<leader>wm`     | Zoom/dezoomer la fenetre            |
| `<C-h/j/k/l>`   | Naviguer entre les fenetres         |
| `<C-Up/Down/Left/Right>` | Redimensionner              |

### Tabs

| Touche              | Action                           |
|---------------------|----------------------------------|
| `<leader><tab><tab>`| Nouveau tab                      |
| `<leader><tab>d`    | Fermer le tab                    |
| `<leader><tab>]`    | Tab suivant                      |
| `<leader><tab>[`    | Tab precedent                    |
| `<leader><tab>o`    | Fermer les autres tabs           |

---

## 5. EDITION

### Mouvements

| Touche           | Action                              |
|------------------|-------------------------------------|
| `h/j/k/l`       | Gauche/Bas/Haut/Droite              |
| `w/b/e`          | Mot suivant/precedent/fin           |
| `gg/G`           | Debut/fin du fichier                |
| `0/$`            | Debut/fin de ligne                  |
| `<C-d>/<C-u>`   | Demi-page bas/haut                  |
| `s`              | Flash jump (comme ta config)        |
| `S`              | Flash Treesitter                    |
| `<A-j>/<A-k>`   | Deplacer la ligne bas/haut          |

> **Attention :** Pas de `H/L` pour debut/fin de ligne,
> pas de `J/K` pour 5 lignes. Ce sont les comportements Vim par defaut.

### Sauvegarder / Quitter

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<C-s>`          | Sauvegarder (tous les modes)        |
| `<leader>qq`     | Quitter tout                        |

> **Pas de** `<leader>w`, `<leader>x`, `<leader>Q` comme dans ta config.

### Commentaires

| Touche    | Action                              |
|-----------|-------------------------------------|
| `gcc`     | Commenter/decommenter la ligne      |
| `gc`      | Commenter une selection (visuel)    |
| `gco`     | Ajouter un commentaire en dessous   |
| `gcO`     | Ajouter un commentaire au dessus    |

### Surround (mini.surround - different de nvim-surround !)

| Touche    | Action                    | Exemple                    |
|-----------|---------------------------|----------------------------|
| `gsa`     | Ajouter surround          | `gsaiw"` : mot -> "mot"   |
| `gsd`     | Supprimer surround        | `gsd"` : "mot" -> mot     |
| `gsr`     | Remplacer surround        | `gsr"'` : "mot" -> 'mot'  |

> **Attention :** C'est `gsa`/`gsd`/`gsr` et PAS `ys`/`ds`/`cs` !

### Copier / Coller

| Touche           | Action                              |
|------------------|-------------------------------------|
| `y`              | Copier                              |
| `p` / `P`        | Coller apres/avant                  |
| `<leader>p`      | Historique du presse-papier         |
| `<p` / `>p`      | Coller et indenter gauche/droite    |

### Undo / Redo

| Touche           | Action                              |
|------------------|-------------------------------------|
| `u`              | Annuler                             |
| `<C-r>`          | Refaire                             |
| `<leader>su`     | Arbre d'undo (visuel)               |

> **Attention :** Pas de `U` pour redo comme dans ta config.

---

## 6. LSP - Code Intelligence

### Navigation dans le code

| Touche           | Action                              |
|------------------|-------------------------------------|
| `gd`             | Aller a la definition               |
| `gr`             | Voir les references                 |
| `gI`             | Aller a l'implementation            |
| `gy`             | Aller au type                       |
| `gD`             | Aller a la declaration              |
| `K`              | Documentation hover                 |
| `gK`             | Aide signature                      |

> **Attention :** `K` montre la doc (dans ta config c'est 5 lignes up).

### Actions de code

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>ca`     | Code action                         |
| `<leader>cr`     | Renommer                            |
| `<leader>cR`     | Renommer le fichier                 |
| `<leader>cf`     | Formater                            |
| `<leader>co`     | Organiser les imports               |
| `<leader>cl`     | Info LSP                            |
| `<leader>cm`     | Mason (gestionnaire de serveurs)    |

### Diagnostics

| Touche           | Action                              |
|------------------|-------------------------------------|
| `]d` / `[d`      | Diagnostic suivant/precedent       |
| `]e` / `[e`      | Erreur suivante/precedente         |
| `]w` / `[w`      | Warning suivant/precedent          |
| `<leader>cd`     | Diagnostics de la ligne            |
| `<leader>xx`     | Panel diagnostics (Trouble)        |
| `<leader>xX`     | Diagnostics du buffer              |

### Autocompletion (blink.cmp)

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<C-Space>`      | Ouvrir la completion                |
| `<CR>`           | Confirmer                           |
| `<Tab>`          | Selectionner suivant                |
| `<S-Tab>`        | Selectionner precedent              |
| `<C-b>/<C-f>`   | Scroller dans la doc                |

---

## 7. GIT

LazyVim utilise **lazygit** (interface git en terminal) au lieu de Fugitive.

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>gg`     | Ouvrir lazygit                      |
| `<leader>gG`     | Lazygit (dossier courant)           |
| `<leader>gs`     | Git status                          |
| `<leader>gd`     | Diff                                |
| `<leader>gb`     | Blame de la ligne                   |
| `<leader>gf`     | Historique du fichier               |
| `<leader>gl`     | Git log                             |
| `<leader>gB`     | Ouvrir dans le navigateur (GitHub)  |
| `]h` / `[h`      | Hunk suivant/precedent             |

> **Prerequis :** Installe lazygit : `pacman -S lazygit`

---

## 8. SEARCH & REPLACE

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>sr`     | Search & Replace (grug-far)         |
| `<leader>/`      | Grep dans le projet                 |
| `<leader>sg`     | Grep (racine)                       |
| `<leader>sG`     | Grep (dossier courant)              |
| `<leader>sw`     | Chercher le mot sous le curseur     |
| `<leader>sb`     | Chercher dans le buffer             |

---

## 9. TODO COMMENTS

| Touche           | Action                              |
|------------------|-------------------------------------|
| `]t` / `[t`      | TODO suivant/precedent             |
| `<leader>st`     | Liste des TODOs (picker)           |
| `<leader>xt`     | TODOs dans Trouble                  |

---

## 10. TERMINAL

LazyVim a un terminal flottant integre (pas besoin de tmux).

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<C-/>`          | Toggle terminal flottant            |
| `<leader>ft`     | Terminal (flottant)                 |
| `<leader>fT`     | Terminal (racine)                   |

> En mode terminal, `<C-/>` pour revenir a Neovim.

---

## 11. SESSIONS

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>qs`     | Restaurer la session                |
| `<leader>qS`     | Choisir une session                 |
| `<leader>ql`     | Derniere session                    |
| `<leader>qd`     | Ne pas sauver la session            |

---

## 12. TOGGLES (activer/desactiver)

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>us`     | Toggle spell check                  |
| `<leader>uw`     | Toggle word wrap                    |
| `<leader>ul`     | Toggle numeros de ligne             |
| `<leader>uL`     | Toggle numeros relatifs             |
| `<leader>ud`     | Toggle diagnostics                  |
| `<leader>uf`     | Toggle auto-format                  |
| `<leader>ug`     | Toggle indent guides                |
| `<leader>uh`     | Toggle inlay hints                  |
| `<leader>uT`     | Toggle treesitter highlight         |
| `<leader>ub`     | Toggle background sombre/clair      |
| `<leader>uC`     | Changer le colorscheme              |
| `<leader>uz`     | Mode zen                            |

---

## 13. REFACTORING

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>rf`     | Extraire en fonction                |
| `<leader>rF`     | Extraire dans un nouveau fichier    |
| `<leader>rx`     | Extraire en variable                |
| `<leader>ri`     | Inline variable                     |
| `<leader>rp`     | Debug print variable                |
| `<leader>rc`     | Nettoyer les debug prints           |

---

## 14. DEBUGGER (nvim-dap)

Le debugger doit etre active en "extra". Par defaut les raccourcis
sont les memes que dans ta config :

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>db`     | Toggle breakpoint                   |
| `<leader>dB`     | Breakpoint conditionnel             |
| `<leader>dc`     | Continuer / Lancer                  |
| `<leader>di`     | Step into                           |
| `<leader>do`     | Step out                            |
| `<leader>dO`     | Step over                           |
| `<leader>dt`     | Terminer                            |
| `<leader>du`     | Toggle UI                           |
| `<leader>dr`     | Toggle REPL                         |

---

## 15. OUTILS

| Touche           | Action                              |
|------------------|-------------------------------------|
| `<leader>l`      | Lazy (gestionnaire de plugins)      |
| `<leader>L`      | Changelog LazyVim                   |
| `<leader>`       | Which-key (attendre pour voir l'aide)|

---

## 16. WHICH-KEY - GROUPES DE RACCOURCIS

Tape `<leader>` et attends. Voici les groupes :

| Prefixe       | Groupe                    |
|---------------|---------------------------|
| `<leader>b`   | Buffers                   |
| `<leader>c`   | Code (LSP)                |
| `<leader>d`   | Debug                     |
| `<leader>f`   | Fichiers / Find           |
| `<leader>g`   | Git                       |
| `<leader>q`   | Quit / Session            |
| `<leader>r`   | Refactor                  |
| `<leader>s`   | Search                    |
| `<leader>u`   | UI / Toggles              |
| `<leader>w`   | Windows                   |
| `<leader>x`   | Diagnostics / Trouble     |
| `<leader><tab>` | Tabs                    |

---

## 17. PRINCIPALES DIFFERENCES DE RACCOURCIS

Tableau de correspondance entre ta config et LazyVim :

| Action                  | Ta config (nvim)    | LazyVim (lvim)       |
|-------------------------|---------------------|----------------------|
| Sauvegarder             | `<leader>w`         | `<C-s>`              |
| Quitter tout            | `<leader>Q`         | `<leader>qq`         |
| Buffer suivant          | `<leader>bn`        | `<S-l>`              |
| Buffer precedent        | `<leader>bp`        | `<S-h>`              |
| Fermer buffer           | `<leader>bd`        | `<leader>bd`         |
| Split vertical          | `<leader>v`         | `<leader>\|`         |
| Split horizontal        | `<leader>s`         | `<leader>-`          |
| Fermer fenetre          | `<leader>q`         | `<leader>wd`         |
| Explorateur             | `<leader>e`         | `<leader>e`          |
| Chercher fichier        | `<leader>ff`        | `<leader>ff`         |
| Grep                    | `<leader>fg`        | `<leader>/`          |
| Git status              | `<leader>gs`        | `<leader>gs`         |
| Git push                | `<leader>gp`        | Via lazygit           |
| Git blame               | `<leader>gb`        | `<leader>gb`         |
| Renommer                | `<leader>rn`        | `<leader>cr`         |
| Code action             | `<leader>ca`        | `<leader>ca`         |
| Formater                | `<leader>f`         | `<leader>cf`         |
| Documentation hover     | `<leader>d`         | `K`                  |
| 5 lignes bas            | `J`                 | Pas disponible       |
| 5 lignes haut           | `K`                 | Pas disponible       |
| Debut de ligne          | `H`                 | Pas disponible       |
| Fin de ligne            | `L`                 | Pas disponible       |
| Ajouter surround        | `ysiw"`             | `gsaiw"`             |
| Changer surround        | `cs"'`              | `gsr"'`              |
| Supprimer surround      | `ds"`               | `gsd"`               |
| Redo                    | `U`                 | `<C-r>`              |
| Search & Replace        | `<leader>sr`        | `<leader>sr`         |
| Diagnostics             | `<leader>xx`        | `<leader>xx`         |
| TODOs                   | `<leader>ft`        | `<leader>st`         |
| Terminal                | Via tmux             | `<C-/>`              |
| Harpoon                 | `<leader>1-5`       | Pas inclus           |
| Minimap                 | `<leader>mm`        | Pas inclus           |
| Tailwind wrap           | `<leader>tw`        | Pas inclus           |
| Lazy                    | `<leader>L`         | `<leader>l`          |
| Markdown preview        | `<leader>mp`        | Pas inclus           |
| Session restaurer       | `<leader>ps`        | `<leader>qs`         |

---

## 18. AJOUTER DES EXTRAS

LazyVim a des "extras" qui ajoutent des fonctionnalites.
Pour les activer :

```
:LazyExtras
```

Extras recommandes :
- `lang.typescript` — Support TypeScript complet
- `lang.json` — Support JSON avec schemas
- `lang.markdown` — Markdown preview
- `lang.tailwind` — Support Tailwind CSS
- `dap.core` — Debugger
- `test.core` — Tests integres
- `editor.harpoon2` — Harpoon
- `ui.mini-animate` — Animations
- `ai.copilot` / `ai.copilot-chat` — GitHub Copilot

---

## 19. PERSONNALISER LAZYVIM

### Changer le colorscheme

Cree `~/.config/nvim-lazyvim/lua/plugins/colorscheme.lua` :
```lua
return {
  { "Mofiqul/dracula.nvim" },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "dracula" },
  },
}
```

### Ajouter tes raccourcis custom

Edite `~/.config/nvim-lazyvim/lua/config/keymaps.lua` :
```lua
local map = vim.keymap.set

-- Tes raccourcis habituels
map("n", "H", "^", { desc = "Debut de ligne" })
map("n", "L", "$", { desc = "Fin de ligne" })
map("i", "jj", "<Esc>")
map("i", "jk", "<Esc>")
```

### Ajouter un plugin

Cree un fichier dans `~/.config/nvim-lazyvim/lua/plugins/` :
```lua
return {
  "author/plugin-name",
  opts = {},
}
```

---

## 20. CONFIG LEGACY

L'ancienne config custom (47 plugins) reste disponible via la commande `nvim`.
Elle est conservee dans `configs/nvim/` en reference.

LazyVim est maintenant la config principale du projet.

**Fichiers de config :** `configs/nvim-lazyvim/` dans le repo
(deployes vers `~/.config/nvim-lazyvim/` par install-configs.sh).

Pour voir les extras actives : `:LazyExtras` dans lvim
ou ouvrir `configs/nvim-lazyvim/lazyvim.json`.

---

## FICHE RAPIDE - Edge (AdonisJS)

Les fichiers `.edge` sont detectes automatiquement avec coloration syntaxique
TokyoNight (syntaxe Vim classique, treesitter desactive pour Edge).

### Tailwind class wrapping

Prettier casse les expressions `{{ }}` dans Edge, donc un formatter custom
est utilise pour wrapper les longues classes Tailwind (> 80 chars).

```
<leader>tw               Wrapper les classes Tailwind du buffer
:TailwindWrapAll          Wrapper tous les .edge du projet
```

- Auto-wrap au save sur `*.edge` et `*.html`
- Skip les lignes contenant `{{ }}` pour ne pas casser les expressions Edge
- Config : `lua/config/autocmds.lua`

---

## FICHE RAPIDE - Git dans LazyVim

### Lazygit (interface complete)

```
OUVRIR / FERMER
  <leader>gg           Ouvrir lazygit
  q                    Quitter lazygit

NAVIGATION
  1-5                  Panneaux : Status / Files / Branches / Commits / Stash
  h / l                Panneau precedent / suivant
  j / k                Monter / descendre
  ?                    Aide du panneau actif
  x                    Menu contextuel

FICHIERS (panneau 2)
  <space>              Stage / unstage un fichier
  a                    Stage / unstage tout
  <enter>              Voir le diff ligne par ligne
  e                    Ouvrir le fichier dans Neovim
  d                    Discard les changements
  s                    Stash

DANS LE DIFF (apres <enter>)
  <space>              Stage / unstage une ligne
  v                    Selection visuelle (stage partiel)
  a                    Stage / unstage le hunk entier
  <esc>                Retour a la liste

COMMIT
  c                    Commit (taper message + <enter>)
  A                    Amend (ajouter au dernier commit)

BRANCHES (panneau 3)
  <space>              Checkout
  n                    Nouvelle branche
  d                    Supprimer
  r                    Rebase
  M                    Merge
  p                    Push
  P                    Pull

COMMITS (panneau 4)
  <enter>              Voir les fichiers du commit
  r                    Reword (changer le message)
  s                    Squash
  f                    Fixup
  d                    Drop
  <C-j> / <C-k>       Deplacer le commit

STASH (panneau 5)
  <space>              Appliquer
  g                    Pop (appliquer + supprimer)
  d                    Supprimer
```

### Git dans les fichiers (gitsigns)

```
NAVIGUER ENTRE LES CHANGEMENTS
  ]h                   Hunk suivant
  [h                   Hunk precedent

VOIR LES DIFFS
  <leader>ghp          Preview du hunk (popup)
  <leader>gd           Diff complet du fichier (split)
  <leader>ghb          Blame de la ligne

INDICATEURS GOUTTIERE
  Vert                 Ligne ajoutee
  Orange               Ligne modifiee
  Rouge                Ligne supprimee
```
