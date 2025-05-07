--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Telescope" },
  keys = {
    {
      "<Leader>ff",
      function()
        if vim.fn.finddir(".git", ";") == "" then
          return require("telescope.builtin").find_files()
        end
        return require("telescope.builtin").git_files()
      end,
    },
    { "<Leader>fg", "<Cmd>Telescope live_grep<CR>" },
    { "<Leader>fb", "<Cmd>Telescope buffers<CR>" },
    { "<Leader>fh", "<Cmd>Telescope help_tags<CR>" },
  },
}
