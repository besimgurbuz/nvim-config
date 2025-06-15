return {
  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        -- ... other lualine options
      },
    },
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          side = "right"
        },
      })
      -- Keymaps for nvim-tree
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
      vim.keymap.set("n", "<leader>E", ":NvimTreeFindFile<CR>", { desc = "Explorer: Find current file" })
    end,
  },
}

