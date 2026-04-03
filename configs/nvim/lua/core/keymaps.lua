-- ============================================
-- KEYMAPS - Migrated from vimrc
-- ============================================

local map = vim.keymap.set

-- Disable arrow keys
map({ "n", "v" }, "<Up>", "<Nop>")
map({ "n", "v" }, "<Down>", "<Nop>")
map({ "n", "v" }, "<Left>", "<Nop>")
map({ "n", "v" }, "<Right>", "<Nop>")
map("i", "<Up>", "<Nop>")
map("i", "<Down>", "<Nop>")
map("i", "<Left>", "<Nop>")
map("i", "<Right>", "<Nop>")

-- Quick navigation
map("n", "H", "^", { desc = "Beginning of line" })
map("n", "L", "$", { desc = "End of line" })

-- J/K = 5 lines, except in special buffers (fugitive, help, etc.)
local function smart_5j()
  local ft = vim.bo.filetype
  if ft == "fugitive" or ft == "help" or ft == "qf" or ft == "neo-tree" then
    return "j"
  end
  return "5j"
end
local function smart_5k()
  local ft = vim.bo.filetype
  if ft == "fugitive" or ft == "help" or ft == "qf" or ft == "neo-tree" then
    return "k"
  end
  return "5k"
end
map({ "n", "v" }, "J", smart_5j, { desc = "5 lines down", expr = true })
map({ "n", "v" }, "K", smart_5k, { desc = "5 lines up", expr = true })

-- Center screen on search
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")

-- Windows
map("n", "<leader>v", "<C-w>v", { desc = "Vertical split" })
map("n", "<leader>s", "<C-w>s", { desc = "Horizontal split" })
map("n", "<leader>h", "<C-w>h", { desc = "Left window" })
map("n", "<leader>j", "<C-w>j", { desc = "Bottom window" })
map("n", "<leader>k", "<C-w>k", { desc = "Top window" })
map("n", "<leader>l", "<C-w>l", { desc = "Right window" })
map("n", "<leader>q", "<C-w>q", { desc = "Close window" })
map("n", "<leader>=", "<C-w>=", { desc = "Equalize windows" })

-- Buffers
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>bl", ":buffers<CR>", { desc = "List buffers" })

-- Search and replace
map("n", "<leader>r", ":%s//g<Left><Left>", { desc = "Search/Replace" })
map("n", "<leader>R", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace current word" })

-- Undo/redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Y like C and D
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Select all
map("n", "<leader>a", "ggVG", { desc = "Select all" })

-- Save and quit
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>W", ":wa<CR>", { desc = "Save all" })
map("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Disable search highlighting
map("n", "<leader><space>", ":nohlsearch<CR>", { desc = "Clear search" })

-- Quick insert mode exit
map("i", "jj", "<Esc>")
map("i", "jk", "<Esc>")

-- Quick save in insert mode
map("i", "<C-s>", "<Esc>:w<CR>a")

-- Movement in insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

-- Copy file path
map("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("Path copied")
end, { desc = "Copy absolute path" })
map("n", "<leader>yr", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  print("Relative path copied")
end, { desc = "Copy relative path" })
map("n", "<leader>yf", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
  print("Filename copied")
end, { desc = "Copy filename" })

-- Lazy plugin manager
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy (plugins)" })

-- Opencode integration
map("n", "<leader>oo", ":!opencode %:p<CR>", { desc = "Open in Opencode" })
map("n", "<leader>oc", ":!opencode<CR>", { desc = "Launch Opencode" })
map("n", "<leader>on", ":!opencode --new<CR>", { desc = "Opencode new conversation" })
