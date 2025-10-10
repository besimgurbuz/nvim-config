return {
  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- Get current hour (0-23)
      local current_hour = tonumber(os.date("%H"))

      -- Define time ranges for light/dark themes
      -- Light theme: 6 AM to 5 PM (6-18)
      -- Dark theme: 5 PM to 6 AM (18-6)
      if current_hour >= 6 and current_hour < 17 then
        vim.cmd.colorscheme "catppuccin-latte"                               -- Light theme for daytime
        -- Set cursor color for light theme
        vim.api.nvim_set_hl(0, "Cursor", { fg = "#dc8a78", bg = "#dc8a78" }) -- Catppuccin latte rosewater
        vim.api.nvim_set_hl(0, "lCursor", { fg = "#dc8a78", bg = "#dc8a78" })
        vim.api.nvim_set_hl(0, "CursorIM", { fg = "#dc8a78", bg = "#dc8a78" })
      else
        vim.cmd.colorscheme "catppuccin-mocha"                               -- Dark theme for nighttime
        -- Set cursor color for dark theme
        vim.api.nvim_set_hl(0, "Cursor", { fg = "#f5e0dc", bg = "#f5e0dc" }) -- Catppuccin mocha rosewater
        vim.api.nvim_set_hl(0, "lCursor", { fg = "#f5e0dc", bg = "#f5e0dc" })
        vim.api.nvim_set_hl(0, "CursorIM", { fg = "#f5e0dc", bg = "#f5e0dc" })
      end

      -- Configure cursor shape and blinking
      vim.opt.guicursor = {
        "n-v-c:block-Cursor/lCursor",   -- Normal, Visual, Command-line: block cursor
        "i-ci-ve:ver25-Cursor/lCursor", -- Insert, Command-line Insert, Visual-Exclude: vertical bar cursor
        "r-cr:hor20-Cursor/lCursor",    -- Replace, Command-line Replace: horizontal bar cursor
        "o:hor50-Cursor/lCursor",       -- Operator-pending: horizontal bar cursor
      }
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Get current hour to match the theme
      local current_hour = tonumber(os.date("%H"))
      local theme = (current_hour >= 6 and current_hour < 17) and "catppuccin-latte" or "catppuccin-mocha"

      require('lualine').setup({
        options = {
          theme = theme,
          -- ... other lualine options
        },
      })
    end,
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
