-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Sauvegarder (Ctrl+s pris par Zellij)
map({ "n", "i", "v" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Diff mode
map("n", "<leader>df", "<cmd>diffthis<cr>", { desc = "Diff this window" })
map("n", "<leader>dF", "<cmd>diffoff!<cr>", { desc = "Diff off (all windows)" })
