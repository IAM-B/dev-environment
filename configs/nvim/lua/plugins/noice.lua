-- ============================================
-- NOICE - Notifications et UI commandes amelioree
-- ============================================

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        -- Override les handlers LSP pour utiliser noice
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- Recherche en bas (classique)
        command_palette = true,        -- Commandes centrees en popup
        long_message_to_split = true,  -- Messages longs dans un split
        lsp_doc_border = true,         -- Bordure sur la doc LSP
      },
    },
  },
}
