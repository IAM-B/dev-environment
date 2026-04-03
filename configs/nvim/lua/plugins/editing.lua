-- ============================================
-- EDITING - surround, comment, autopairs, flash, repeat, unimpaired
-- ============================================

return {
  -- nvim-surround (replaces vim-surround)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- ts-comments.nvim (replaces Comment.nvim - better JSX/TSX support)
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- nvim-autopairs (replaces auto-pairs)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },

  -- flash.nvim (replaces vim-easymotion)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
    config = function()
      require("flash").setup({})
    end,
  },

  -- vim-repeat (kept - tpope)
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- vim-unimpaired (kept - tpope)
  { "tpope/vim-unimpaired", event = "VeryLazy" },
}
