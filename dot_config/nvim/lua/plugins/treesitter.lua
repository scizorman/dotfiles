return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead" },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = "all",
      sync_install = true,
      auto_install = true,
      highlight = { enable = true },
      additional_vim_regex_highlighting = false,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    source = { "nvim-treesitter/nvim-treesitter" },
  },
}
