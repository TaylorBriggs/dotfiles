return {
  { "RRethy/nvim-treesitter-endwise" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        endwise = { enable = true },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
