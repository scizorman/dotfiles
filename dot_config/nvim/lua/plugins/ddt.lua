local function configure_global()
  local ddt_cache_dir = vim.fn.stdpath("cache") .. "/ddt"
  vim.fn.mkdir(ddt_cache_dir, "p")

  vim.fn["ddt#custom#patch_global"]({
    nvimServer = vim.fn.stdpath("cache") .. "/server.pipe",
    uiParams = {
      shell = {
        noSaveHistoryCommands = { "exit" },
        shellHistoryPath = ddt_cache_dir .. "/ddt-shell-history",
        split = "floating",
      },
      terminal = {
        command = { "zsh" },
        split = "horizontal",
        winHeight = 20,
      },
    },
  })
end

local function configure_ddt_ui_shell_keymaps()
  vim.keymap.set({ "n", "i" }, "<CR>", [[<Cmd>call ddt#ui#do_action("executeLine")<CR>]], { buffer = true })
  vim.keymap.set("i", "<C-C>", [[<Cmd>call ddt#ui#do_action("terminate")<CR>]], { buffer = true })
  vim.keymap.set("n", "<C-N>", [[<Cmd>call ddt#ui#do_action("nextPrompt")<CR>]], { buffer = true })
  vim.keymap.set("n", "<C-Y>", [[<Cmd>call ddt#ui#do_action("pastePrompt")<CR>]], { buffer = true })
  vim.keymap.set("n", "<C-P>", [[<Cmd>call ddt#ui#do_action("previousPrompt")<CR>]], { buffer = true })

  vim.keymap.set("i", "<Tab>", function()
    if vim.fn["pum#visible"]() then
      return [[<Cmd>call pum#map#insert_relative(1, "empty")<CR>]]
    end
    return vim.fn["ddc#map#manual_complete"]({ sources = { "shell_native", "shell_history" } })
  end, { expr = true, buffer = true })
  vim.keymap.set("i", "<C-N>", [[<Cmd>call pum#map#select_relative(1)<CR>]], { buffer = true })
  vim.keymap.set("i", "<C-P>", [[<Cmd>call pum#map#select_relative(-1)<CR>]], { buffer = true })
end

local function configure_ddt_ui_terminal_keymaps()
  vim.keymap.set("n", "<Leader>tt", [[<Cmd>close<CR>]], { buffer = true })
end

local function setup()
  configure_global()

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddt-shell",
    callback = configure_ddt_ui_shell_keymaps,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddt-terminal",
    callback = configure_ddt_ui_terminal_keymaps,
  })
end

--- @type LazyPluginSpec
return {
  "Shougo/ddt.vim",
  dependencies = {
    { "vim-denops/denops.vim",  lazy = false },
    { "Shougo/ddt-ui-shell",    lazy = true },
    { "Shougo/ddt-ui-terminal", lazy = true },
  },
  config = setup,
  keys = {
    {
      "<Leader>ts",
      function()
        vim.fn["ddt#start"]({
          name = "shell-" .. vim.fn.win_getid(),
          ui = "shell",
        })
      end,
    },
    {
      "<Leader>tt",
      function()
        vim.fn["ddt#start"]({
          name = "terminal-" .. vim.fn.win_getid(),
          ui = "terminal",
        })
      end,
    },
  },
}
