-- ============================================
-- OPTIONS - Migrated from vimrc
-- ============================================

local opt = vim.opt

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "utf-8" }

-- Interface
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.colorcolumn = "80,120"
opt.laststatus = 2
opt.showmode = true
opt.showcmd = true
opt.wildmenu = true
opt.wildmode = "list:longest,full"
opt.cmdheight = 2
opt.signcolumn = "yes"
opt.termguicolors = true

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.smarttab = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

-- Navigation
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.whichwrap:append("<,>,h,l")

-- Files
opt.autoread = true
opt.autowrite = true
opt.backup = true
opt.backupdir = vim.fn.expand("~/.local/state/nvim/backup//")
opt.directory = vim.fn.expand("~/.local/state/nvim/swap//")
opt.undofile = true
opt.undodir = vim.fn.expand("~/.local/state/nvim/undo//")
opt.swapfile = false

-- Create directories if needed
local dirs = { "~/.local/state/nvim/backup", "~/.local/state/nvim/swap", "~/.local/state/nvim/undo" }
for _, dir in ipairs(dirs) do
  local path = vim.fn.expand(dir)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end
end

-- Behavior
opt.hidden = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.backspace = "indent,eol,start"
opt.timeoutlen = 500
opt.updatetime = 300
opt.shortmess:append("c")

-- Appearance
opt.background = "dark"
vim.cmd("syntax on")

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Grep (if ripgrep available)
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case --hidden"
  opt.grepformat = "%f:%l:%c:%m"
end
