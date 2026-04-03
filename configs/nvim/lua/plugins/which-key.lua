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
        { "<leader>c", group = "Code (LSP)" },
        { "<leader>d", group = "Debug (DAP)" },
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>m", group = "Minimap / Markdown" },
        { "<leader>o", group = "Opencode" },
        { "<leader>p", group = "Persistence (sessions)" },
        { "<leader>s", group = "Search & Replace" },
        { "<leader>t", group = "Tailwind" },
        { "<leader>x", group = "Trouble (diagnostics)" },
        { "<leader>y", group = "Yank path" },
      })
    end,
  },
}
