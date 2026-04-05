return {
  -- Ajouter les parsers Treesitter manquants
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "svelte",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "bash",
        "lua",
        "markdown",
        "markdown_inline",
      },
    },
  },

  -- Ajouter le LSP Svelte
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {},
      },
    },
  },
}
