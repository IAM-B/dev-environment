-- ============================================
-- TREESITTER - Additional parsers
-- Neovim 0.11+ handles highlighting natively
-- nvim-treesitter installs missing parsers
-- ============================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      -- Enable treesitter highlighting for supported filetypes
      local ts_filetypes = { "svelte", "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "lua", "bash" }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = ts_filetypes,
        callback = function(args)
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
              pcall(vim.treesitter.start, args.buf)
            end
          end)
        end,
      })
      -- Also enable for current buffer if already open
      local ft = vim.bo.filetype
      if vim.tbl_contains(ts_filetypes, ft) then
        pcall(vim.treesitter.start)
      end
    end,
  },
}
