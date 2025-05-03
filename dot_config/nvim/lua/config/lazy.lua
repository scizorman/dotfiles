local M = {}

function M.setup()
  local lazy_path = string.format("%s/lazy/lazy.nvim", vim.fn.stdpath("data"))
  if not vim.uv.fs_stat(lazy_path) then
    local lazy_repository = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazy_repository, lazy_path })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim.echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." }
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazy_path)

  require("lazy").setup({
    spec = {
      {
        "cocopon/iceberg.vim",
        lazy = false,
        config = function()
          vim.cmd("colorscheme iceberg")
        end,
      },
      {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = true,
      },
      {
        "kylechui/nvim-surround",
        event = { "BufRead", "BufNewFile" },
        config = true,
      },
      { import = "plugins" },
    },
    install = { colorschema = "iceberg" },
    checker = { enabled = true },
  })
end

return M
