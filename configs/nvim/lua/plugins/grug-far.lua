-- ============================================
-- GRUG-FAR - Search and replace dans tout le projet
-- ============================================

return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      { "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search & Replace (projet)" },
      {
        "<leader>sw",
        function()
          require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
        end,
        desc = "Search & Replace (mot sous curseur)",
      },
    },
    opts = {},
  },
}
