return {
  {
    "wfxr/minimap.vim",
    config = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 1
      vim.g.minimap_auto_start_win_enter = 1
      vim.g.minimap_git_colors = 1
      vim.g.minimap_highlight_search = 1
      vim.g.minimap_close_filetypes = {
        "neo-tree", "lazy", "mason", "help",
        "TelescopePrompt", "trouble", "noice",
        "qf", "terminal", "snacks_dashboard",
      }

      vim.keymap.set("n", "<leader>mm", "<cmd>MinimapToggle<cr>", { desc = "Toggle Minimap" })
      vim.keymap.set("n", "<leader>mc", "<cmd>MinimapClose<cr>", { desc = "Close Minimap" })
      vim.keymap.set("n", "<leader>mr", "<cmd>MinimapRefresh<cr>", { desc = "Refresh Minimap" })
    end,
  },
}
