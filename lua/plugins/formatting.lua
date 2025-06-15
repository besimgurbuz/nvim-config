-- ~/.config/nvim/lua/plugins/formatting.lua

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Run on save
    cmd = { "ConformInfo" },
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff" },
        json = {"prettierd" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
      -- Configure format on save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true, -- Fallback to LSP formatting if conform fails
      },
    },
    init = function()
      -- Add a keymap for manual formatting
      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format file or range" })
    end,
  },
}

