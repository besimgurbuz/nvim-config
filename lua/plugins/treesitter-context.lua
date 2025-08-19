return {
  "nvim-treesitter/nvim-treesitter-context",
  opts = {
    enable = true,
    max_lines = 0, -- No limit on context lines
    -- Add this patterns table
    patterns = {
      -- Default patterns for most languages
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        'if',
        'switch',
        'case',
      },
      -- Add a custom pattern specifically for Python
      python = {
        'class_definition',
        'function_definition',
      },
    },
  },
}
