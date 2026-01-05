return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "lua_ls",
          "pyright",
          "ruff",
          "tailwindcss",
          "eslint",
          "gopls",
          "cssls",
          "jsonls",
          "html",
          "bashls",
          "svelte",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- =========================
      -- Capabilities
      -- =========================
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- =========================
      -- on_attach
      -- =========================
      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "K", vim.lsp.buf.hover, "LSP Hover")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "gi", vim.lsp.buf.implementation, "Implementation")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

        -- Disable formatting for some servers (recommended)
        if client.name == "ts_ls" or client.name == "eslint" then
          client.server_capabilities.documentFormattingProvider = false
        end
      end

      -- =========================
      -- Server setups
      -- =========================

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("ruff", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("eslint", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("cssls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("jsonls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("html", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("bashls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("svelte", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("workspace/didChangeWatchedFiles", {
                changes = {
                  {
                    uri = vim.uri_from_fname(ctx.file),
                    type = 2,
                  },
                },
              })
            end,
          })
        end,
      })
      -- =========================
      -- Diagnostics UI
      -- =========================
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
}
