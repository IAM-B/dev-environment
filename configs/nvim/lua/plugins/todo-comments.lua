-- ============================================
-- TODO-COMMENTS - TODOs, FIXME, HACK colores et cherchables
-- ============================================

return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "TODO suivant" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "TODO precedent" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Chercher TODOs (Telescope)" },
    },
    opts = {},
  },
}
