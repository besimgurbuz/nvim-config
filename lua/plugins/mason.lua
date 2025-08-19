return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                -- We are using a clean list of servers and leaving out 'tsserver'
                -- for now to resolve the error.
                ensure_installed = {
                    "ts_ls",
                    "lua_ls",
                    "pyright",
                    "gopls",
                    "jsonls",
                    "html",
                    "cssls",
                },
            })
        end,
    },
}
