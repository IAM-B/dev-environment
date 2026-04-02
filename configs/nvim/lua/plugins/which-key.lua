-- ============================================
-- WHICH-KEY - Affiche les raccourcis disponibles
-- ============================================

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")

      wk.setup({
        preset = "helix",
        delay = 300,
        icons = {
          rules = false,
          separator = "→",
        },
        win = {
          border = "rounded",
        },
      })

      -- Groupes de raccourcis
      wk.add({
        { "<leader>b", group = "Buffers" },
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Hunks (git)" },
        { "<leader>m", group = "Minimap" },
        { "<leader>o", group = "Opencode" },
        { "<leader>y", group = "Yank path" },
        { "<leader>c", group = "Code (LSP)" },
        { "<leader>t", group = "Tailwind" },
      })
    end,
  },
}
