local M = {}

function M.setup()
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  vim.opt.expandtab = true
  vim.opt.smarttab = true
  vim.opt.autoindent = true
  vim.opt.smartindent = true
  vim.opt.modeline = false

  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.colorcolumn = '120'
  vim.opt.cmdheight = 2

  vim.opt.completeopt = { "menuone", "noselect", "popup" }

  vim.opt.linebreak = true
  vim.opt.showbreak = "\\"
  vim.opt.breakindent = true
  vim.opt.clipboard = "unnamedplus"

  vim.opt.splitbelow = true
  vim.opt.splitright = true

  vim.opt.undofile = true
  vim.opt.mouse = "n"
  vim.opt.termguicolors = true
end

return M
