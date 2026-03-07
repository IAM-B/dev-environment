-- ============================================
-- LSP - mason + vim.lsp.config (Neovim 0.11+) + nvim-cmp + conform
-- ============================================

return {
  -- Mason (LSP server manager)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "+",
            package_pending = "~",
            package_uninstalled = "-",
          },
        },
      })
    end,
  },

  -- Mason-lspconfig (automatically installs servers)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "jsonls",
          "html",
          "cssls",
          "eslint",
          "svelte",
          "yamlls",
          "marksman",
          "lua_ls",
          "bashls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP keymaps + server configuration (Neovim 0.11+ native)
  {
    "hrsh7th/cmp-nvim-lsp",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gy", vim.lsp.buf.type_definition, "Type definition")
          map("n", "gi", vim.lsp.buf.implementation, "Implementation")
          map("n", "gr", vim.lsp.buf.references, "References")
          map("n", "<leader>d", vim.lsp.buf.hover, "Hover documentation")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, "Format file")
          map("v", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, "Format selection")
          map("n", "[g", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("n", "]g", vim.diagnostic.goto_next, "Next diagnostic")
          map("n", "[G", function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end, "Previous error")
          map("n", "]G", function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
          end, "Next error")
          map("n", "<leader>cd", vim.diagnostic.setloclist, "Diagnostics list")
        end,
      })

      -- Server configuration with vim.lsp.config (Neovim 0.11+)
      local servers = {
        ts_ls = {},
        jsonls = {},
        html = {},
        cssls = {},
        eslint = {},
        svelte = {},
        yamlls = {},
        marksman = {},
        bashls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config[server] = config
        vim.lsp.enable(server)
      end

      -- Diagnostic config
      vim.diagnostic.config({
        virtual_text = { prefix = ">" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },

  -- nvim-cmp (completions)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })

      -- Cmdline completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- conform.nvim (formatting)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          svelte = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 3000,
          lsp_format = "fallback",
        },
      })
    end,
  },
}
