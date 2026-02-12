--- @type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = "all",
    sync_install = true,
    auto_install = true,
    highlight = { enable = true },
    additional_vim_regex_highlighting = false,
  },
  main = "nvim-treesitter.configs",
  build = ":TSUpdate",
  event = { "BufRead" },
}
