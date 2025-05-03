local function setup()
  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "<Leader>ff", builtin.find_files)
  vim.keymap.set("n", "<Leader>fg", builtin.live_grep)
  vim.keymap.set("n", "<Leader>fb", builtin.buffers)
  vim.keymap.set("n", "<Leader>fh", builtin.help_tags)
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = setup,
}
