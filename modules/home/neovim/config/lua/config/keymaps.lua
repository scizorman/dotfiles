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
