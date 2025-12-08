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
        return require("telescope.builtin").git_files({
          show_untracked = true,
        })
      end,
    },
    { "<Leader>fg", "<Cmd>Telescope live_grep<CR>" },
    { "<Leader>fb", "<Cmd>Telescope buffers<CR>" },
    { "<Leader>fh", "<Cmd>Telescope help_tags<CR>" },
    {
      "<Leader>fc",
      function()
        require("telescope.builtin").find_files({
          prompt_title = "Git Repositories",
          find_command = { "ghq", "list", "-p" },
          attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.cmd(string.format("tcd %s", selection.path))
            end)
            return true
          end,
        })
      end,
    },
  },
}
