-- ============================================
-- SNIPPETS - LuaSnip + friendly-snippets
-- Replaces UltiSnips + vim-snippets
-- ============================================

return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")

      -- Load VSCode snippets (friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Snippet navigation (same as vimrc UltiSnips)
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        end
      end, { desc = "Next snippet" })

      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { desc = "Previous snippet" })
    end,
  },
}
