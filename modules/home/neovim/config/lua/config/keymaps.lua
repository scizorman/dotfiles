vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("i", "<C-F>", "<Right>")
vim.keymap.set("i", "<C-B>", "<Left>")
vim.keymap.set("i", "<C-A>", "<Home>")
vim.keymap.set("i", "<C-E>", "<End>")
vim.keymap.set("i", "<C-D>", "<Del>")
vim.keymap.set("i", "<C-K>", "<C-O>D")

vim.keymap.set(
  "c",
  "<C-N>",
  function()
    return vim.fn.pumvisible() == 1 and "<C-N>" or "<Down>"
  end,
  { expr = true }
)
vim.keymap.set(
  "c",
  "<C-P>",
  function()
    return vim.fn.pumvisible() == 1 and "<C-P>" or "<Up>"
  end,
  { expr = true }
)
vim.keymap.set("c", "<C-F>", "<Right>")
vim.keymap.set("c", "<C-B>", "<Left>")
vim.keymap.set("c", "<C-A>", "<Home>")
vim.keymap.set("c", "<C-E>", "<End>")
vim.keymap.set("c", "<C-D>", "<Del>")
vim.keymap.set("c", "<C-Y>", "<C-R>*")

local function find_canvas_bufnr()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.b[bufnr].is_canvas then
      return bufnr
    end
  end
  return nil
end

local function create_canvas()
  vim.cmd("enew")
  local bufnr = vim.api.nvim_get_current_buf()
  vim.b[bufnr].is_canvas = true
  vim.bo[bufnr].buftype = "nofile"
  vim.bo[bufnr].bufhidden = "hide"
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].filetype = "markdown"
  return bufnr
end

local function toggle_canvas()
  local bufnr = find_canvas_bufnr()
  if bufnr then
    local winnr = vim.fn.bufwinnr(bufnr)
    if winnr > 0 then
      vim.cmd(winnr .. "wincmd w")
    else
      vim.cmd("buffer " .. bufnr)
    end
  else
    create_canvas()
  end
end

vim.keymap.set("n", "<Leader>c", toggle_canvas, { desc = "Toggle canvas buffer" })
