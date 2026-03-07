-- ============================================
-- APPEARANCE - dracula.nvim + lualine + devicons
-- ============================================

return {
  -- Dracula theme
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
      require("dracula").setup({
        show_end_of_buffer = true,
        transparent_bg = false,
        italic_comment = true,
      })
      vim.cmd.colorscheme("dracula")
      -- More visible Visual mode (dark purple)
      vim.api.nvim_set_hl(0, "Visual", { bg = "#3d3566" })
      -- Disable @none so text inherits normal color
      vim.api.nvim_set_hl(0, "@none", {})
      vim.api.nvim_set_hl(0, "@none.svelte", {})
      -- Variables in orange
      vim.api.nvim_set_hl(0, "@variable", { fg = "#FFB86C" })
    end,
  },

  -- Status bar (replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula-nvim",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        tabline = {
          lualine_a = { "buffers" },
          lualine_z = { "tabs" },
        },
      })
    end,
  },

  -- Icons (replaces vim-devicons)
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },
}
