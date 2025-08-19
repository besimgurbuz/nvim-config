return {
    "neovim/nvim-lspconfig",
    -- Declare the dependencies this file needs
    dependencies = {
        "williamboman/mason-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local masonlspconfig = require("mason-lspconfig")

        local on_attach = function(client, bufnr)
            -- Your keymaps for LSP actions
            local keymap = vim.keymap
            keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
            keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
            keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
            keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "List References" })
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
            keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "List Code Action" })
        end

        require("mason-lspconfig").setup({
            function(server_name)
                lspconfig[server_name].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
        })
    end,
}
