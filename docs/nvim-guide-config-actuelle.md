# Guide de ma config Neovim - Tout maitriser

> **NOTE : Ce document concerne l'ancienne config Neovim custom (`nvim`).**
> LazyVim est maintenant la configuration principale. Voir [lazyvim-guide.md](lazyvim-guide.md).
> L'ancienne config reste disponible via `nvim` pour reference.

## Structure des fichiers

```
configs/nvim/
  init.lua                    -- Point d'entree (charge tout)
  lua/core/
    options.lua               -- Reglages editeur
    keymaps.lua               -- Raccourcis clavier custom
    autocmds.lua              -- Actions automatiques
  lua/plugins/
    appearance.lua            -- Theme, statusbar, bufferline, icones
    dap.lua                   -- Debugger (breakpoints, step, variables)
    editing.lua               -- Surround, commentaires, autopairs, flash
    git.lua                   -- Fugitive + Gitsigns
    grug-far.lua              -- Search & Replace dans tout le projet
    harpoon.lua               -- Navigation rapide entre fichiers marques
    images.lua                -- Preview images dans markdown
    lsp.lua                   -- Serveurs de langues, completion, formatage
    markdown-preview.lua      -- Preview markdown dans le navigateur
    navigation.lua            -- Neo-tree, Telescope, minimap.vim, tmux
    noice.lua                 -- Notifications et UI amelioree
    persistence.lua           -- Sauvegarde de session
    snippets.lua              -- Snippets LuaSnip
    todo-comments.lua         -- TODOs, FIXME colores et cherchables
    treesitter.lua            -- Coloration syntaxique avancee
    trouble.lua               -- Panel de diagnostics
    which-key.lua             -- Affichage des raccourcis disponibles
  syntax/edge.vim             -- Syntaxe AdonisJS Edge
  queries/css/highlights.scm  -- Couleurs custom CSS
  queries/svelte/highlights.scm
```

---

## 1. LES BASES - Mouvements et edition

### Mouvements custom (core/keymaps.lua)

| Touche        | Action                              | Mode    |
|---------------|-------------------------------------|---------|
| `H`           | Debut de ligne (premier caractere)  | Normal  |
| `L`           | Fin de ligne                        | Normal  |
| `J`           | 5 lignes vers le bas                | Normal  |
| `K`           | 5 lignes vers le haut               | Normal  |
| `n` / `N`     | Match suivant/precedent (centre)    | Normal  |
| `*` / `#`     | Chercher mot sous curseur           | Normal  |
| Fleches       | DESACTIVEES (discipline Vim)        | Tous    |

> **A savoir :** J/K descendent de 1 ligne dans les buffers speciaux
> (fugitive, help, quickfix, neo-tree) pour ne pas sauter du contenu.

### Edition

| Touche        | Action                              | Mode    |
|---------------|-------------------------------------|---------|
| `u`           | Annuler (undo)                      | Normal  |
| `U`           | Refaire (redo)                      | Normal  |
| `Y`           | Copier jusqu'a fin de ligne         | Normal  |
| `<leader>a`   | Selectionner tout le fichier        | Normal  |
| `<leader>r`   | Rechercher/remplacer (ligne)        | Normal  |
| `<leader>R`   | Remplacer le mot sous le curseur    | Normal  |

### Sortir du mode insertion

| Touche        | Action                              |
|---------------|-------------------------------------|
| `jj`          | Retour mode normal                  |
| `jk`          | Retour mode normal                  |
| `<C-s>`       | Sauvegarder depuis insert           |

### Mouvements en mode insertion

| Touche  | Action       |
|---------|-------------|
| `<C-h>` | Aller a gauche  |
| `<C-l>` | Aller a droite  |
| `<C-j>` | Aller en bas    |
| `<C-k>` | Aller en haut   |

---

## 2. FICHIERS ET FENETRES

### Sauvegarder / Quitter

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>w`   | Sauvegarder                         |
| `<leader>W`   | Sauvegarder tout                    |
| `<leader>x`   | Sauvegarder et quitter              |
| `<leader>Q`   | Quitter tout sans sauver            |

### Fenetres (splits)

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>v`   | Split vertical                      |
| `<leader>s`   | Split horizontal                    |
| `<leader>h`   | Focus fenetre gauche                |
| `<leader>j`   | Focus fenetre bas                   |
| `<leader>k`   | Focus fenetre haut                  |
| `<leader>l`   | Focus fenetre droite                |
| `<leader>q`   | Fermer fenetre courante             |
| `<leader>=`   | Egaliser taille des fenetres        |

> **Avec tmux :** `<C-h/j/k/l>` navigue entre les panes tmux ET les
> splits Neovim de maniere transparente grace a vim-tmux-navigator.

### Buffers

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>bn`  | Buffer suivant                      |
| `<leader>bp`  | Buffer precedent                    |
| `<leader>bd`  | Supprimer buffer                    |
| `<leader>bl`  | Lister les buffers                  |

> **Astuce :** Les buffers sont visibles dans la bufferline en haut
> de l'ecran avec icones, diagnostics LSP et bouton fermer.

### Copier le chemin du fichier

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>yp`  | Chemin absolu dans le presse-papier |
| `<leader>yr`  | Chemin relatif                      |
| `<leader>yf`  | Nom du fichier seulement            |

---

## 3. TELESCOPE - Recherche de fichiers et contenu

Telescope est ton outil principal pour trouver des choses rapidement.

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>ff`  | Chercher un fichier par nom         |
| `<leader>fg`  | Chercher du contenu (live grep)     |
| `<leader>fb`  | Chercher dans les buffers ouverts   |
| `<leader>fh`  | Fichiers recemment ouverts          |
| `<leader>fc`  | Commandes disponibles               |
| `<leader>fm`  | Voir tous les raccourcis clavier    |
| `<leader>ft`  | Chercher les TODOs du projet        |

**Dans le popup Telescope :**

| Touche  | Action                        |
|---------|-------------------------------|
| `<C-j>` | Selection suivante            |
| `<C-k>` | Selection precedente          |
| `<Esc>` | Fermer                        |
| `<CR>`  | Ouvrir le fichier selectionne |

> **Astuce :** `<leader>fg` est extremement puissant. Tu peux chercher
> n'importe quel texte dans tout ton projet. Les fichiers dans
> `node_modules/` et `.git/` sont ignores automatiquement.

---

## 4. NEO-TREE - Explorateur de fichiers

Neo-tree remplace nvim-tree avec une meilleure UI, le suivi automatique
du fichier courant et un git status inline.

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>e`   | Ouvrir/fermer l'arbre               |
| `<leader>E`   | Trouver le fichier courant          |
| `<leader>ep`  | Changer la racine du projet         |

**Dans Neo-tree :**

| Touche | Action                         |
|--------|--------------------------------|
| `<CR>` | Ouvrir fichier/dossier         |
| `a`    | Creer un fichier/dossier       |
| `d`    | Supprimer                      |
| `r`    | Renommer                       |
| `c`    | Copier                         |
| `p`    | Coller                         |
| `m`    | Deplacer                       |
| `y`    | Copier le nom                  |
| `H`    | Afficher/masquer fichiers caches |
| `R`    | Rafraichir                     |
| `q`    | Fermer l'arbre                 |
| `?`    | Afficher l'aide des raccourcis |

**Symboles git dans l'arbre :**
- `+` staged, `~` modifie, `?` non suivi, `-` supprime, `i` ignore

> **Fonctionnalites auto :** Neo-tree suit automatiquement le fichier
> que tu edites et s'ouvre au demarrage si tu lances Neovim sans fichier.

---

## 5. HARPOON - Navigation rapide entre fichiers

Harpoon te permet de marquer tes fichiers les plus utilises et de
switcher entre eux instantanement sans Telescope.

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>ha`  | Ajouter le fichier courant          |
| `<leader>hh`  | Ouvrir le menu Harpoon              |
| `<leader>1`   | Aller au fichier marque 1           |
| `<leader>2`   | Aller au fichier marque 2           |
| `<leader>3`   | Aller au fichier marque 3           |
| `<leader>4`   | Aller au fichier marque 4           |
| `<leader>5`   | Aller au fichier marque 5           |

> **Workflow typique :** Tu bosses sur 3-4 fichiers en meme temps
> (composant, style, test, route). Marque-les avec `<leader>ha` puis
> switch avec `<leader>1`, `<leader>2`, etc. Beaucoup plus rapide
> que de chercher avec Telescope a chaque fois.

---

## 6. LSP - Ton IDE dans Neovim

Le LSP te donne autocompletion, navigation et diagnostics.
Tes serveurs installes : TypeScript, JSON, HTML, CSS, ESLint, Svelte,
YAML, Markdown, Lua, Bash.

### Navigation dans le code

| Touche        | Action                              |
|---------------|-------------------------------------|
| `gd`          | Aller a la definition               |
| `gy`          | Aller au type de la definition      |
| `gi`          | Aller a l'implementation            |
| `gr`          | Voir les references                 |
| `<leader>d`   | Documentation (hover)               |
| `<leader>rn`  | Renommer un symbole partout         |
| `<leader>ca`  | Actions de code (import, fix, etc.) |

> **Workflow typique :** Tu vois une fonction, `gd` pour voir sa
> definition, `gr` pour voir ou elle est utilisee, `<leader>rn` pour
> la renommer partout d'un coup.

### Diagnostics (erreurs/warnings)

| Touche        | Action                              |
|---------------|-------------------------------------|
| `]g`          | Diagnostic suivant                  |
| `[g`          | Diagnostic precedent                |
| `]G`          | Erreur suivante (severite haute)    |
| `[G`          | Erreur precedente                   |
| `<leader>cd`  | Tous les diagnostics (location list)|

> Les diagnostics s'affichent en texte virtuel a cote de la ligne et
> dans la sign column a gauche. Tries par severite.

### Autocompletion (nvim-cmp)

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<C-Space>`   | Ouvrir le menu de completion        |
| `<Tab>`       | Selectionner suivant / expand snippet |
| `<S-Tab>`     | Selectionner precedent              |
| `<CR>`        | Confirmer la selection              |

**Sources de completion (par priorite) :**
1. LSP (fonctions, variables, types)
2. Snippets (LuaSnip)
3. Chemins de fichiers
4. Mots du buffer courant

### Formatage (conform.nvim + Prettier)

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>f`   | Formater le fichier/selection       |

> **Auto-format :** Le code est formate automatiquement a chaque
> sauvegarde avec Prettier (JS/TS/CSS/HTML/JSON/YAML/Svelte/Markdown).
> Les fichiers `.edge` sont exclus car Prettier casse les `{{ }}`.

---

## 7. TROUBLE - Panel de diagnostics

Trouble remplace la location list par un panel plus ergonomique
pour naviguer entre les erreurs, warnings et TODOs.

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>xx`  | Diagnostics de tout le projet       |
| `<leader>xd`  | Diagnostics du fichier courant      |
| `<leader>xl`  | Location list                       |
| `<leader>xq`  | Quickfix list                       |
| `<leader>xt`  | Liste des TODOs                     |

> **Astuce :** `<leader>xx` te donne une vue globale de toutes les
> erreurs du projet. Tu peux naviguer et sauter directement a chaque
> erreur. Bien plus pratique que `:lopen`.

---

## 8. GIT - Fugitive + Gitsigns

### Commandes Git (Fugitive)

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>gs`  | Git status (split vertical)         |
| `<leader>gd`  | Git diff                            |
| `<leader>gb`  | Git blame (qui a ecrit chaque ligne)|
| `<leader>gl`  | Git log                             |
| `<leader>gp`  | Git push                            |
| `<leader>gP`  | Git pull                            |

**Dans le buffer Fugitive (git status) :**

| Touche | Action                         |
|--------|--------------------------------|
| `s`    | Stager un fichier              |
| `u`    | Unstager un fichier            |
| `=`    | Voir le diff inline            |
| `cc`   | Commiter                       |
| `ca`   | Commit --amend                 |
| `X`    | Checkout (annuler les modifs)  |
| `<CR>` | Ouvrir le fichier              |

### Navigation entre les changements (Gitsigns)

| Touche        | Action                              |
|---------------|-------------------------------------|
| `]c`          | Changement git suivant (hunk)       |
| `[c`          | Changement git precedent            |
| `<leader>hs`  | Stager le hunk sous le curseur      |
| `<leader>hu`  | Annuler le stage du hunk            |
| `<leader>hp`  | Previsualiser le hunk (popup)       |

> **Couleurs dans la gouttiere :**
> Vert = ajoute, Orange = modifie, Rouge = supprime.
> Les changements stages sont en couleurs attenuees.

---

## 9. SEARCH & REPLACE - Grug-far

Grug-far te permet de chercher et remplacer dans tout le projet,
comme le Ctrl+Shift+H de VS Code.

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>sr`  | Ouvrir le panneau Search & Replace  |
| `<leader>sw`  | Search & Replace avec le mot courant|

> **Workflow :** `<leader>sr` ouvre un panneau ou tu tapes ta recherche,
> le remplacement, et tu vois un preview de tous les changements avant
> de les appliquer. Tu peux filtrer par type de fichier ou dossier.
> Support des regex.

---

## 10. EDITION AVANCEE - Plugins d'edition

### nvim-surround - Manipuler les paires

| Commande        | Action                              | Exemple                     |
|-----------------|-------------------------------------|-----------------------------|
| `ys{motion}{c}` | Ajouter des surrounds               | `ysiw"` : mot -> "mot"     |
| `cs{old}{new}`  | Changer les surrounds                | `cs"'` : "mot" -> 'mot'    |
| `ds{c}`         | Supprimer les surrounds              | `ds"` : "mot" -> mot       |
| `S{c}`          | Ajouter surround en mode visuel      | selectionner + `S(`        |

> **Exemples pratiques :**
> - `ysiw<div>` : entoure un mot de `<div>...</div>`
> - `cs'"` : change les single quotes en double quotes
> - `dst` : supprime le tag HTML autour

### ts-comments.nvim - Commentaires

| Touche   | Action                              |
|----------|-------------------------------------|
| `gcc`    | Commenter/decommenter la ligne      |
| `gc`     | Commenter une selection (visuel)    |
| `gcap`   | Commenter un paragraphe             |

> **Avantage :** ts-comments utilise treesitter pour detecter le bon
> type de commentaire. En JSX/TSX, il utilise `{/* */}` dans le JSX
> et `//` dans le JavaScript automatiquement.

### flash.nvim - Deplacement rapide

| Touche | Action                              |
|--------|-------------------------------------|
| `s`    | Flash : tape 2 lettres, choisis un label pour sauter |
| `S`    | Flash Treesitter : sauter a un bloc de code |

> **Comment utiliser flash :** Tape `s`, puis les 2 premieres lettres
> de ta destination. Des labels apparaissent, tape le label pour y
> sauter instantanement. Extremement rapide pour naviguer.

### vim-unimpaired - Raccourcis en crochets

| Touche    | Action                              |
|-----------|-------------------------------------|
| `]q`/`[q` | Quickfix suivant/precedent          |
| `]l`/`[l` | Location list suivant/precedent     |
| `]b`/`[b` | Buffer suivant/precedent            |
| `]f`/`[f` | Fichier suivant/precedent (dossier) |
| `]e`/`[e` | Deplacer ligne haut/bas             |
| `]<Space>`| Ajouter ligne vide apres            |
| `[<Space>`| Ajouter ligne vide avant            |
| `[os`     | Activer le spell check              |
| `]os`     | Desactiver le spell check           |
| `yos`     | Toggle le spell check               |

### TODO Comments - TODOs colores

| Touche        | Action                              |
|---------------|-------------------------------------|
| `]t`          | TODO suivant                        |
| `[t`          | TODO precedent                      |
| `<leader>ft`  | Chercher les TODOs (Telescope)      |

> Les mots TODO, FIXME, HACK, NOTE, WARNING sont automatiquement
> colores dans le code. `<leader>ft` liste tous les TODOs du projet.

### Snippets (LuaSnip)

| Touche  | Action                              |
|---------|-------------------------------------|
| `<C-j>` | Champ suivant dans le snippet       |
| `<C-k>` | Champ precedent dans le snippet     |

> Les snippets viennent de friendly-snippets (format VSCode).
> Tape un prefixe dans la completion (ex: `clg` -> `console.log()`).

---

## 11. DEBUGGER (nvim-dap)

Le debugger integre te permet de poser des breakpoints et inspecter
ton code comme dans VS Code.

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>db`  | Poser/retirer un breakpoint         |
| `<leader>dB`  | Breakpoint conditionnel             |
| `<leader>dc`  | Continuer / Lancer le debug         |
| `<leader>do`  | Step over (ligne suivante)          |
| `<leader>di`  | Step into (entrer dans la fonction) |
| `<leader>dO`  | Step out (sortir de la fonction)    |
| `<leader>dr`  | Restart                             |
| `<leader>dt`  | Terminer le debug                   |
| `<leader>du`  | Ouvrir/fermer l'interface de debug  |

> **Workflow :** Place un breakpoint avec `<leader>db`, lance avec
> `<leader>dc`. L'interface s'ouvre automatiquement et montre les
> variables, la pile d'appels et la console. Navigue avec step over/
> into/out. Configure pour Node.js, JavaScript et TypeScript.

---

## 12. SESSIONS (persistence.nvim)

Persistence sauvegarde automatiquement ta session (buffers ouverts,
layout des fenetres, position du curseur) et la restaure.

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>ps`  | Restaurer la session du dossier     |
| `<leader>pS`  | Choisir une session a restaurer     |
| `<leader>pl`  | Restaurer la derniere session       |
| `<leader>pd`  | Ne pas sauver la session a la sortie|

> **Comment ca marche :** Quand tu quittes Neovim, ta session est
> sauvegardee automatiquement. La prochaine fois que tu ouvres Neovim
> dans le meme dossier, tape `<leader>ps` pour tout retrouver.

---

## 13. MINIMAP (minimap.vim)

La minimap utilise `code-minimap` (Rust) et s'affiche dans un vrai
split a droite, sans tronquer le code.

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>mm`  | Ouvrir/fermer la minimap            |
| `<leader>mc`  | Fermer la minimap                   |
| `<leader>mr`  | Rafraichir la minimap               |

> La minimap montre les changements git (couleurs) et les resultats
> de recherche. Elle se cache automatiquement dans les buffers
> speciaux (neo-tree, Telescope, etc.) et s'ouvre automatiquement
> sur les fichiers de code.

---

## 14. MARKDOWN PREVIEW

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>mp`  | Ouvrir/fermer le preview markdown   |

> Ouvre un apercu en temps reel du fichier markdown dans ton navigateur.
> Les modifications se rafraichissent automatiquement.

---

## 15. NOICE - Notifications et UI

Noice ameliore l'interface de Neovim automatiquement :
- Les commandes s'affichent dans un popup centre
- Les messages longs s'ouvrent dans un split
- La documentation LSP a des bordures
- Les notifications sont plus visibles

> Pas de raccourcis a apprendre, tout fonctionne automatiquement.

---

## 16. WHICH-KEY - Aide aux raccourcis

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>`    | Attends 300ms : popup avec tous les raccourcis |
| `<leader>L`   | Ouvrir le gestionnaire de plugins (Lazy) |

**Groupes affiches dans which-key :**

| Prefixe      | Groupe                 |
|--------------|------------------------|
| `<leader>b`  | Buffers                |
| `<leader>c`  | Code (LSP)             |
| `<leader>d`  | Debug (DAP)            |
| `<leader>f`  | Find (Telescope)       |
| `<leader>g`  | Git                    |
| `<leader>h`  | Harpoon                |
| `<leader>m`  | Minimap / Markdown     |
| `<leader>o`  | Opencode               |
| `<leader>p`  | Persistence (sessions) |
| `<leader>s`  | Search & Replace       |
| `<leader>t`  | Tailwind               |
| `<leader>x`  | Trouble (diagnostics)  |
| `<leader>y`  | Yank path              |

> **Astuce :** Quand tu ne te souviens plus d'un raccourci, tape
> `<leader>` et attends. Which-key te montre tout. C'est ton aide-memoire.

---

## 17. FONCTIONNALITES SPECIALES

### Autocommands (automatique)

- **Restauration du curseur** : Quand tu rouvres un fichier, le curseur
  revient a la derniere position editee
- **Suppression espaces** : Les espaces en fin de ligne sont supprimes
  automatiquement a chaque sauvegarde
- **Wrapping Tailwind** : Les longues listes de classes sont
  automatiquement decoupees sur les fichiers `.edge` et `.html`

### Commandes custom

| Commande           | Action                              |
|--------------------|-------------------------------------|
| `:FormatJSON`      | Formater du JSON brut               |
| `:ClearMarks`      | Supprimer tous les marks            |
| `:Count {pattern}` | Compter les occurrences             |
| `:CopyPath`        | Copier le chemin absolu             |
| `:CopyRelPath`     | Copier le chemin relatif            |
| `:CopyFileName`    | Copier le nom du fichier            |
| `:TailwindWrapAll` | Wrapper les classes de tout le projet |
| `:Lazy`            | Gestionnaire de plugins             |

### Tailwind wrapping

| Touche        | Action                              |
|---------------|-------------------------------------|
| `<leader>tw`  | Wrapper les classes Tailwind        |

> Coupe les longues lignes `class="..."` a 80 caracteres avec
> indentation correcte. Se lance aussi automatiquement au save sur
> `.edge` et `.html`.

---

## 18. OPTIONS IMPORTANTES A CONNAITRE

| Option              | Valeur   | Ce que ca fait                       |
|---------------------|----------|--------------------------------------|
| Numeros relatifs    | Oui      | Facilite les mouvements `5j`, `3k`   |
| Scroll offset       | 8 lignes | Le curseur reste centre              |
| Indentation         | 2 espaces| Standard JS/TS                       |
| Smart case          | Oui      | Recherche insensible sauf si MAJUSCULE |
| Clipboard           | Systeme  | Copier dans Vim = copier dans le systeme |
| Undo persistant     | Oui      | L'historique survit entre les sessions |
| Color column        | 80, 120  | Reperes visuels de largeur de ligne  |
| Auto-write          | Oui      | Sauvegarde auto en changeant de buffer |

---

## 19. LISTE DES PLUGINS (47 au total)

| Plugin               | Role                          | Lazy-load          |
|----------------------|-------------------------------|---------------------|
| lazy.nvim            | Gestionnaire de plugins       | Au demarrage        |
| dracula.nvim         | Theme de couleurs             | Au demarrage        |
| lualine.nvim         | Barre de statut               | Au demarrage        |
| bufferline.nvim      | Barre d'onglets/buffers       | VeryLazy            |
| nvim-web-devicons    | Icones de fichiers            | Au demarrage        |
| neo-tree.nvim        | Explorateur de fichiers       | Au demarrage        |
| nui.nvim             | Composants UI (neo-tree/noice)| Dependance          |
| telescope.nvim       | Recherche fuzzy               | Au demarrage        |
| telescope-fzf-native | Extension fzf pour Telescope  | Dependance          |
| plenary.nvim         | Librairie utilitaire Lua      | Dependance          |
| minimap.vim          | Minimap (split, code-minimap) | Au demarrage        |
| vim-tmux-navigator   | Navigation tmux/neovim        | Au demarrage        |
| harpoon              | Fichiers marques              | Au demarrage        |
| nvim-surround        | Manipulation de paires        | VeryLazy            |
| ts-comments.nvim     | Commentaires (treesitter)     | VeryLazy            |
| nvim-autopairs       | Auto-fermeture paires         | InsertEnter         |
| flash.nvim           | Deplacement rapide            | VeryLazy            |
| vim-repeat           | Repeter les actions plugins   | VeryLazy            |
| vim-unimpaired       | Raccourcis en crochets        | VeryLazy            |
| LuaSnip              | Moteur de snippets            | Au demarrage        |
| friendly-snippets    | Collection de snippets        | Dependance          |
| nvim-treesitter      | Coloration syntaxique         | Au demarrage        |
| mason.nvim           | Installeur de serveurs LSP    | Au demarrage        |
| mason-lspconfig      | Integration Mason + LSP       | Au demarrage        |
| cmp-nvim-lsp         | Source LSP pour completion    | Au demarrage        |
| nvim-cmp             | Moteur de completion          | InsertEnter         |
| cmp-buffer           | Source buffer pour completion  | Dependance          |
| cmp-path             | Source chemins pour completion | Dependance          |
| cmp-cmdline          | Completion ligne de commande  | Dependance          |
| cmp_luasnip          | Source snippets pour cmp      | Dependance          |
| conform.nvim         | Formatage (Prettier)          | BufWritePre         |
| vim-fugitive         | Commandes Git                 | Au demarrage        |
| gitsigns.nvim        | Indicateurs git dans gouttiere| Dependance          |
| nvim-dap             | Debugger                      | Sur raccourci       |
| nvim-dap-ui          | Interface debugger            | Dependance          |
| nvim-dap-virtual-text| Valeurs variables inline      | Dependance          |
| mason-nvim-dap       | Installeur debuggers          | Dependance          |
| nvim-nio             | I/O asynchrone (dap-ui)       | Dependance          |
| trouble.nvim         | Panel diagnostics             | Sur raccourci       |
| todo-comments.nvim   | TODOs colores                 | BufReadPost         |
| grug-far.nvim        | Search & Replace projet       | Sur raccourci       |
| noice.nvim           | UI notifications              | VeryLazy            |
| which-key.nvim       | Aide raccourcis               | VeryLazy            |
| persistence.nvim     | Sauvegarde sessions           | BufReadPre          |
| markdown-preview.nvim| Preview markdown navigateur   | Sur raccourci       |
| image.nvim           | Preview images inline         | Sur type de fichier |
| hererocks            | Dependance image.nvim         | Dependance          |

---

## MEMO RAPIDE - Les raccourcis les plus utiles au quotidien

```
NAVIGUER            FICHIERS            CODE                GIT
H/L  debut/fin      <leader>ff find     gd  definition     <leader>gs status
J/K  5 lignes       <leader>fg grep     gr  references     <leader>gd diff
s    flash jump     <leader>e  arbre    <leader>rn rename   ]c/[c  hunks
<C-hjkl> splits     <leader>fb bufs     <leader>ca action   <leader>hs stage
<leader>1-5 harpoon <leader>fh history  <leader>f  format

EDITER              DIAGNOSTICS         SEARCH/REPLACE      SESSIONS
gcc  commenter      <leader>xx projet   <leader>sr projet   <leader>ps restaurer
cs"' changer ""     <leader>xd fichier  <leader>sw mot      <leader>pl derniere
ysiw" entourer      ]g/[g  naviguer    <leader>R  fichier
]t/[t TODOs         <leader>xt TODOs

SAUVER              DEBUG               DIVERS
<leader>w  save     <leader>db break    <leader>mp markdown preview
<leader>x  save+q   <leader>dc lancer   <leader>tw tailwind wrap
jj/jk  mode norm    <leader>do step     <leader>L  Lazy (plugins)
<leader><space>      <leader>du UI       <leader>   which-key (aide)
  clear highlight
```
