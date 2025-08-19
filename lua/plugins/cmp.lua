-- ~/.config/nvim/lua/plugins/cmp.lua

return {
  "hrsh7th/nvim-cmp",
  -- Load nvim-cmp after starting the language server
  event = "LspAttach",
  dependencies = {
    -- The snippet engine
    "L3MON4D3/LuaSnip",
    -- This adds snippet support to nvim-cmp
    "saadparwaiz1/cmp_luasnip",

    -- These are optional, but recommended sources
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    -- This provides friendly icons for completion items
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- This function tells nvim-cmp how to expand snippets
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      
      -- Configure the completion sources
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Source for LSP completions
        { name = "luasnip" },  -- Source for snippets
        { name = "buffer" },   -- Source for text in current buffer
        { name = "path" },     -- Source for file system paths
      }),

      -- Configure keymappings
      mapping = cmp.mapping.preset.insert({
        -- Select the next item
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- Select the previous item
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- Scroll documentation
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- Abort completion
        ["<C-e>"] = cmp.mapping.abort(),
        -- Manually trigger completion
        ["<C-Space>"] = cmp.mapping.complete(),
        
        -- Confirm selection:
        -- - <CR>: Accept currently selected item.
        -- - Set `select = true` to confirm the first item when hitting enter.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Tab completion:
        -- This is a bit more advanced. It will jump to the next snippet placeholder
        -- if a snippet is active; otherwise, it will select the next completion item.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- Add nice icons to the completion menu
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text", -- Show symbol and text
          maxwidth = 50, -- Truncate long completion items
          ellipsis_char = "...",
        }),
      },
    })
    vim.api.nvim_create_autocmd('InsertEnter', {
      group = vim.api.nvim_create_augroup('CmpOnEnter', { clear = true }),
      callback = function()
        require('cmp').complete()
      end,
    })
  end,
}

