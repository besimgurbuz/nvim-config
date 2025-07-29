-- File: lua/plugins/commenting.lua

return {
  'numToStr/Comment.nvim',
  -- This event will load the plugin when you open a file, which is a good balance of performance and availability.
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Enable the plugin with default settings.
    -- You can add a table with custom configurations inside the setup() function if needed.
    require('Comment').setup()
  end,
}

