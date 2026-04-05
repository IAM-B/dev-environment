# Ameliorations Neovim - Roadmap

> **NOTE : Cette roadmap concerne l'ancienne config custom.**
> LazyVim est maintenant la config principale. La plupart des ameliorations
> listees ici sont deja incluses dans LazyVim (indent-blankline, inc-rename, etc.).
> Ce fichier est conserve en archive.

Plugins et ameliorations a considerer pour le futur.
Tout ce qui etait en priorite haute a deja ete installe.

---

## PRIORITE MOYENNE - Confort et qualite de vie

### 1. Indentation visuelle (indent-blankline.nvim)

**Pourquoi :** Voir les niveaux d'indentation aide enormement a lire
du code imbrique (callbacks, conditions, etc.).

**Plugin :** `lukas-reineke/indent-blankline.nvim`

**Ce que ca apporte :**
- Lignes verticales a chaque niveau d'indentation
- Highlight du scope courant
- Aide visuelle pour le code deeply nested

---

### 2. Meilleure experience de rename/refactor (inc-rename.nvim)

**Pourquoi :** `<leader>rn` marche mais l'experience est basique
(juste un input en bas). Il y a mieux.

**Plugin :** `smjonas/inc-rename.nvim`

**Ce que ca apporte :**
- Preview en temps reel du rename dans tout le fichier
- Tu vois les changements AVANT de confirmer
- Bien plus rassurant pour les refactors

---

### 3. Breadcrumb dans la statusline (nvim-navic)

**Pourquoi :** Savoir dans quelle fonction/classe tu es quand tu lis
du code.

**Plugin :** `SmiteshP/nvim-navic`

**Ce que ca apporte :**
- Breadcrumb dans la statusline : `fichier > classe > fonction`
- Contexte immediat sans scroller
- S'integre a ta lualine

---

### 4. Terminal integre (toggleterm.nvim)

**Pourquoi :** Tu utilises tmux pour le terminal, mais un terminal
flottant dans Neovim est plus rapide pour les commandes courtes.

**Plugin :** `akinsho/toggleterm.nvim`

**Ce que ca apporte :**
- Terminal flottant avec un raccourci
- Plusieurs terminaux numerotes
- Lazygit integre dans un terminal flottant

> **Note :** Ca ne remplace pas tmux, ca le complete.

---

## PRIORITE BASSE - Nice to have

### 5. Highlight des couleurs CSS (nvim-colorizer)

**Plugin :** `norcalli/nvim-colorizer.lua`
- Affiche les couleurs CSS inline (`#ff5555` colore en rouge)
- Utile pour le CSS/Tailwind

### 6. Git diff avance (diffview.nvim)

**Plugin :** `sindrets/diffview.nvim`
- Vue diff complete comme dans VS Code
- Historique de fichier
- Merge conflict resolution

### 7. AI dans l'editeur (avante.nvim ou codecompanion.nvim)

**Plugin :** `yetone/avante.nvim` ou `olimorris/codecompanion.nvim`
- Chat avec Claude/GPT dans un split
- Suggestions de code inline
- Refactoring assiste par IA
- Remplacerait/completerait Opencode

### 8. Tests integres (neotest)

**Plugin :** `nvim-neotest/neotest`
- Lancer les tests depuis Neovim
- Voir les resultats inline
- Support Jest, Vitest, etc.

### 9. Gestion de projet (project.nvim)

**Plugin :** `ahmedkhalf/project.nvim`
- Detection automatique de la racine du projet
- Historique des projets recents
- Changement rapide entre projets

---

## DEJA INSTALLE (pour reference)

Les plugins suivants etaient dans la roadmap et ont ete installes :

- [x] which-key.nvim - Aide raccourcis
- [x] trouble.nvim - Panel diagnostics
- [x] harpoon2 - Navigation fichiers marques
- [x] grug-far.nvim - Search & Replace projet
- [x] todo-comments.nvim - TODOs colores
- [x] noice.nvim - Notifications UI
- [x] nvim-dap + UI - Debugger complet
- [x] persistence.nvim - Sauvegarde sessions
- [x] markdown-preview.nvim - Preview markdown
- [x] ts-comments.nvim - Commentaires treesitter (remplace Comment.nvim)
- [x] neo-tree.nvim - Explorateur fichiers (remplace nvim-tree)
- [x] bufferline.nvim - Barre d'onglets (remplace lualine tabline)

---

## CONSEILS GENERAUX

1. **Installe un plugin a la fois.** Apprends-le avant d'en ajouter un
   autre. Sinon tu te retrouves avec 50 plugins que tu ne maitrises pas.

2. **Lis le README de chaque plugin.** Les configs par defaut sont
   souvent suffisantes. Ne copie pas des configs complexes sans comprendre.

3. **Maitrise d'abord les motions Vim.** Aucun plugin ne remplace la
   maitrise de `ciw`, `di(`, `yap`, `ct"`, `f{char}`, etc. C'est ca
   qui te rendra vraiment rapide.

4. **Ta config est maintenant solide.** 47 plugins bien configures,
   tu as tout ce qu'il faut pour etre productif. Concentre-toi sur
   la maitrise avant d'ajouter encore des plugins.

5. **Ressources pour progresser :**
   - `:Tutor` dans Neovim (tutoriel integre)
   - `vimtutor` dans le terminal
   - ThePrimeagen sur YouTube (motions et efficacite Vim)
   - TJ DeVries sur YouTube (plugins et config Neovim)
   - `:help {sujet}` est toujours la meilleure doc
