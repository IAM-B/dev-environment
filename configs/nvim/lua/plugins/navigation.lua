-- ============================================
-- NAVIGATION - neo-tree + telescope + mini.map + tmux
-- ============================================

return {
  -- Neo-tree (replaces nvim-tree - better UI, git status inline)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
        window = {
          width = 30,
          position = "left",
          mappings = {
            ["<space>"] = "none", -- ne pas confondre avec leader
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
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
      })

      -- Memes raccourcis qu'avant
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
      vim.keymap.set("n", "<leader>E", "<cmd>Neotree reveal<cr>", { desc = "Find file in Neo-tree" })
      vim.keymap.set("n", "<leader>ep", function()
        require("neo-tree.command").execute({ dir = vim.fn.getcwd() })
      end, { desc = "Neo-tree: back to project root" })

      -- Ouvrir Neo-tree au demarrage si pas de fichier
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
          local directory = vim.fn.isdirectory(data.file) == 1
          if no_name or directory then
            if directory then
              vim.cmd.cd(data.file)
            end
            require("neo-tree.command").execute({ toggle = true })
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

  -- minimap.vim (uses code-minimap in Rust, real split)
  {
    "wfxr/minimap.vim",
    config = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 1
      vim.g.minimap_auto_start_win_enter = 1
      vim.g.minimap_git_colors = 1
      vim.g.minimap_highlight_search = 1
      vim.g.minimap_close_filetypes = {
        "neo-tree", "fugitive", "git", "gitcommit",
        "TelescopePrompt", "lazy", "mason", "help",
        "qf", "terminal", "trouble", "noice",
      }

      vim.keymap.set("n", "<leader>mm", "<cmd>MinimapToggle<cr>", { desc = "Toggle Minimap" })
      vim.keymap.set("n", "<leader>mc", "<cmd>MinimapClose<cr>", { desc = "Close Minimap" })
      vim.keymap.set("n", "<leader>mr", "<cmd>MinimapRefresh<cr>", { desc = "Refresh Minimap" })
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
