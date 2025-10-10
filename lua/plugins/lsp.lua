-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end

        nmap("gD", vim.lsp.buf.declaration, "Go to Declaration")
        nmap("gd", vim.lsp.buf.definition, "Go to Definition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        nmap("gr", vim.lsp.buf.references, "Go to References")

        nmap("<leader>dv", function()
          vim.cmd.vsplit()
          vim.lsp.buf.definition()
        end, "Definition (Vertical Split)")

        -- Open definition in a horizontal split
        nmap("<leader>ds", function()
          vim.cmd.split()
          vim.lsp.buf.definition()
        end, "Definition (Horizontal Split)")
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig_servers = {
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
        "bashls"
      }

      -- This list ensures all our LSPs AND formatters are installed by Mason
      local mason_packages = {
        "typescript-language-server",
        "lua-language-server",
        "pyright",
        "ruff",
        "tailwindcss-language-server",
        "eslint-lsp",
        "prettierd",
        "gopls",
        "goimports",
        "golangci-lint",
        "css-lsp",
        "json-lsp",
        "html-lsp",
        "basics-language-server"
      }

      require("mason").setup({
        ensure_installed = mason_packages
      })

      local lspconfig = require("lspconfig")
      for _, server_name in ipairs(lspconfig_servers) do
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
}
