-- ============================================
-- ~/.config/nvim/init.lua
-- Neovim IDE Configuration
-- For JavaScript/TypeScript development
-- ============================================

-- Leader key (before any plugin)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- ============================================
-- BOOTSTRAP LAZY.NVIM
-- ============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins/
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install = { colorscheme = { "dracula" } },
  checker = { enabled = false },
  change_detection = { notify = false },
})
