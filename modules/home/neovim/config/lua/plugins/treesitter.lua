--- @type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "go",
      "python",
      "typescript",
      "javascript",
      "html",
      "css",
      "terraform",
      "nix",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "bash",
      "vim",
      "vimdoc",
      "lua",
    },
    auto_install = true,
    highlight = { enable = true },
  },
  build = ":TSUpdate",
  event = { "BufRead" },
}
