-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Start Neovim server so external tools (Claude, etc.) can open files here
local servername = "/tmp/nvim-lazyvim.pipe"
if vim.fn.filereadable(servername) == 0 then
  pcall(vim.fn.serverstart, servername)
end

-- Soft wrap + visual guide for Edge/HTML templates
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("EdgeWrap", { clear = true }),
  pattern = { "edge", "html" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.colorcolumn = "80"
  end,
})
