-- ============================================
-- GIT - fugitive + gitsigns
-- ============================================

return {
  -- vim-fugitive
  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
      -- Global keymaps
      vim.keymap.set("n", "<leader>gs", function()
        -- Close NvimTree before opening Fugitive
        local ok, api = pcall(require, "nvim-tree.api")
        if ok then api.tree.close() end
        vim.cmd("vert Git")
      end, { desc = "Git status" })
      vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "Git diff" })
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
      vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
      vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" })

      -- Fugitive: Enter opens vertically, replaces existing buffer
      vim.api.nvim_create_autocmd("User", {
        pattern = "FugitiveIndex",
        callback = function()
          vim.keymap.set("n", "<CR>", function()
            -- Get the path under cursor
            local line = vim.api.nvim_get_current_line()
            -- Extract path (fugitive prefixes with M/A/? etc.)
            local path = line:match("^[MAU%?!%s]+(.+)$")
            if path then path = path:gsub("^%s+", ""):gsub("%s+$", "") end

            -- Check if it's a directory before opening
            if path then
              local git_dir = vim.fn.FugitiveWorkTree()
              local full_path = git_dir .. "/" .. path
              if vim.fn.isdirectory(full_path) == 1 then
                -- It's a directory, open in NvimTree
                local ok_tree, api = pcall(require, "nvim-tree.api")
                if ok_tree then
                  api.tree.open()
                  api.tree.find_file(full_path)
                end
                return
              end
            end

            -- It's a file, open with o (horizontal split)
            vim.cmd("normal o")
            -- We are now in the opened file
            if vim.bo.filetype ~= "fugitive" then
              local opened_buf = vim.api.nvim_get_current_buf()
              local opened_win = vim.api.nvim_get_current_win()
              -- Check that the buffer is valid
              if not vim.api.nvim_buf_is_valid(opened_buf) then
                return
              end
              -- Close this split
              vim.api.nvim_win_close(opened_win, false)
              -- Find the window on the right (not fugitive)
              local target_win = nil
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                if ft ~= "fugitive" and ft ~= "NvimTree" and ft ~= "minimap" then
                  target_win = win
                  break
                end
              end
              if target_win and vim.api.nvim_buf_is_valid(opened_buf) then
                -- Replace buffer in existing window
                vim.api.nvim_win_set_buf(target_win, opened_buf)
                vim.api.nvim_set_current_win(target_win)
              elseif vim.api.nvim_buf_is_valid(opened_buf) then
                -- No window found, create a vsplit on the right
                vim.cmd("wincmd l")
                vim.cmd("vsplit")
                vim.api.nvim_win_set_buf(0, opened_buf)
              end
            end
          end, { buffer = true, silent = true })
        end,
      })
    end,
  },

  -- gitsigns.nvim (replaces vim-gitgutter)
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
        },
        linehl = true,
        numhl = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigate between hunks
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous hunk" })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        end,
      })

      -- Dracula colors
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#50fa7b" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffb86c" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff5555" })
      vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#2a4a2a" })
      vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#4a3a2a" })
      vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#4a2a2a" })
      vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#50fa7b" })
      vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#ffb86c" })
      vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#ff5555" })
    end,
  },
}
