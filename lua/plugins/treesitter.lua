return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { 
        "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python", 
        "tsx", "html", "css", "json", "go", "gomod", "gosum" 
      },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true }, -- For auto-closing HTML/JSX tags
    })
  end,
}

