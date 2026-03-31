-- ============================================
-- NAVIGATION - nvim-tree + telescope + mini.map + tmux
-- ============================================

return {
  -- NvimTree (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          icons = {
            show = {
              git = true,
              file = true,
              folder = true,
              folder_arrow = true,
            },
            glyphs = {
              git = {
                unstaged = "~",
                staged = "+",
                untracked = "?",
                renamed = ">",
                unmerged = "=",
                deleted = "-",
                ignored = "i",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })

      -- Keymaps same as vimrc
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
      vim.keymap.set("n", "<leader>E", ":NvimTreeFindFile<CR>", { desc = "Find file in NvimTree" })
      vim.keymap.set("n", "<leader>ep", function()
        require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
      end, { desc = "NvimTree: back to project root" })

      -- Open NvimTree at startup if no file
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
          local directory = vim.fn.isdirectory(data.file) == 1
          if no_name or directory then
            if directory then
              vim.cmd.cd(data.file)
            end
            require("nvim-tree.api").tree.open()
          end
        end,
      })
    end,
  },

  -- Telescope (replaces fzf.vim)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Esc>"] = actions.close,
            },
          },
          file_ignore_patterns = { "node_modules", ".git/" },
        },
        pickers = {
          find_files = { hidden = true },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
      })

      telescope.load_extension("fzf")

      -- Keymaps same as vimrc (leader+f*)
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.oldfiles, { desc = "History" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
      vim.keymap.set("n", "<leader>fm", builtin.keymaps, { desc = "Keymaps" })
    end,
  },

  -- mini.map (replaces minimap.vim - pure Lua, more stable)
  {
    "echasnovski/mini.map",
    version = false,
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      local map = require("mini.map")

      -- Highlights for git integrations in mini.map
      vim.api.nvim_set_hl(0, "MiniMapSymbolGitAdd", { fg = "#50fa7b" })
      vim.api.nvim_set_hl(0, "MiniMapSymbolGitChange", { fg = "#ffb86c" })
      vim.api.nvim_set_hl(0, "MiniMapSymbolGitDelete", { fg = "#ff5555" })

      map.setup({
        symbols = {
          encode = map.gen_encode_symbols.dot("4x2"),
        },
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic(),
          map.gen_integration.gitsigns({
            untracked = true,
            add = "MiniMapSymbolGitAdd",
            change = "MiniMapSymbolGitChange",
            delete = "MiniMapSymbolGitDelete",
          }),
        },
        window = {
          width = 10,
          winblend = 0,
          side = "right",
          show_integration_count = false,
        },
      })

      -- Auto open on code files
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local ft = vim.bo.filetype
          local excluded = {
            "NvimTree", "fugitive", "git", "gitcommit",
            "TelescopePrompt", "lazy", "mason", "help",
            "qf", "terminal", "",
          }
          for _, v in ipairs(excluded) do
            if ft == v then return end
          end
          if vim.bo.buftype == "" then
            map.open()
          end
        end,
      })

      -- Refresh minimap when gitsigns updates
      vim.api.nvim_create_autocmd("User", {
        pattern = "GitSignsUpdate",
        callback = function()
          pcall(map.refresh, {}, { lines = false, scrollbar = false })
        end,
      })

      -- Keymaps (same as before)
      vim.keymap.set("n", "<leader>mm", map.toggle, { desc = "Toggle Minimap" })
      vim.keymap.set("n", "<leader>mc", map.close, { desc = "Close Minimap" })
      vim.keymap.set("n", "<leader>mr", map.refresh, { desc = "Refresh Minimap" })
      vim.keymap.set("n", "<leader>mf", map.toggle_focus, { desc = "Focus Minimap" })
    end,
  },

  -- Tmux navigator (kept as-is)
  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
      vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
      vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
      vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
      vim.keymap.set("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", { silent = true })
    end,
  },
}
