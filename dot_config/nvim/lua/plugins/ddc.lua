local function configure_insert_mode_keymaps()
  vim.keymap.set("i", "<Tab>", function()
    if vim.fn["pum#visible"]() then
      return [[<Cmd>call pum#map#insert_relative(1, "empty")<CR>]]
    end

    local current_column = vim.fn.col(".")
    local current_line_text = vim.fn.getline(".")
    local character_before_cursor = current_line_text:sub(current_column - 1, current_column - 1)
    if current_column <= 1 or character_before_cursor:match("%s") then
      return "<Tab>"
    end

    return vim.fn["ddc#map#manual_complete"]()
  end, { expr = true })
  vim.keymap.set("i", "<S-Tab>", [[<Cmd>call pum#map#insert_relative(-1, "empty")<CR>]])
  vim.keymap.set("i", "<C-N>", [[<Cmd>call pum#map#select_relative(+1)<CR>]])
  vim.keymap.set("i", "<C-P>", [[<Cmd>call pum#map#select_relative(-1)<CR>]])
  vim.keymap.set("i", "<C-Y>", [[<Cmd>call pum#map#confirm()<CR>]])
  vim.keymap.set("i", "<C-E>", function()
    if vim.fn["pum#visible"]() then
      return [[<Cmd>call pum#map#cancel()<CR>]]
    end

    return "<End>"
  end, { expr = true })
end

local function configure_command_mode_keymaps()
  vim.keymap.set("c", "<Tab>", function()
    if vim.fn.wildmenumode() == 1 then
      return vim.fn.nr2char(vim.o.wildcharm)
    end

    if vim.fn["pum#visible"]() then
      return [[<Cmd>call pum#map#insert_relative(1)<CR>]]
    end

    return vim.fn["ddc#map#manual_complete"]()
  end, { expr = true })
  vim.keymap.set("c", "<S-Tab>", [[<Cmd>call pum#map#insert_relative(-1)<CR>]])
  vim.keymap.set("c", "<C-N>", [[<Cmd>call pum#map#select_relative(+1)<CR>]])
  vim.keymap.set("c", "<C-P>", [[<Cmd>call pum#map#select_relative(-1)<CR>]])
  vim.keymap.set("c", "<C-Y>", [[<Cmd>call pum#map#confirm()<CR>]])
  vim.keymap.set("c", "<C-E>", function()
    if vim.fn["pum#visible"]() then
      return [[<Cmd>call pum#map#cancel()<CR>]]
    end

    return "<End>"
  end, { expr = true })
end

local saved_buffer_config = nil

local function restore_buffer_config()
  if saved_buffer_config ~= nil then
    vim.fn["ddc#custom#set_buffer"](saved_buffer_config)
    saved_buffer_config = nil
  end
end

local function configure_command_mode_completion()
  saved_buffer_config = vim.fn["ddc#custom#get_buffer"]()

  vim.fn["ddc#custom#patch_buffer"]("sourceOptions", {
    _ = {
      keywordPattern = "[0-9a-zA-Z:*/.-]*",
    },
  })

  vim.fn["ddc#custom#set_context_buffer"](function()
    local command_line_text = vim.fn.getcmdline()
    if command_line_text:find("^!") == 1 then
      return {
        cmdlineSources = { "shell_native", "cmdline", "cmdline_history", "around" },
      }
    end
    return {}
  end)

  vim.api.nvim_create_autocmd("User", {
    pattern = "DDCCmdlineLeave",
    once = true,
    callback = restore_buffer_config,
  })

  vim.fn["ddc#enable_cmdline_completion"]()
end

local function configure_search_mode_completion()
  saved_buffer_config = vim.fn["ddc#custom#get_buffer"]()

  vim.api.nvim_create_autocmd("User", {
    pattern = "DDCCmdlineLeave",
    once = true,
    callback = restore_buffer_config,
  })

  vim.fn["ddc#enable_cmdline_completion"]()
end

local function setup()
  vim.fn["ddc#custom#load_config"](string.format("%s/lua/plugins/ddc.ts", vim.fn.stdpath("config")))

  configure_insert_mode_keymaps()
  configure_command_mode_keymaps()

  vim.fn["ddc#enable_terminal_completion"]()
  vim.fn["ddc#enable"]({
    context_filetype = "treesitter",
  })
end

--- @type LazyPluginSpec[]
return {
  {
    "Shougo/ddc.vim",
    dependencies = {
      { "vim-denops/denops.vim",                      lazy = false },
      { "Shougo/ddc-ui-pum",                          lazy = true },
      { "Shougo/ddc-source-around",                   lazy = true },
      { "Shougo/ddc-source-line",                     lazy = true },
      { "LumaKernel/ddc-source-file",                 lazy = true },
      { "Shougo/ddc-source-lsp",                      lazy = true },
      { "Shougo/ddc-source-cmdline",                  lazy = true },
      { "Shougo/ddc-source-cmdline_history",          lazy = true },
      { "Shougo/ddc-source-shell",                    lazy = true },
      { "Shougo/ddc-source-shell_history",            lazy = true },
      { "Shougo/ddc-source-shell_native",             lazy = true },
      { "Shougo/ddc-filter-matcher_head",             lazy = true },
      { "Shougo/ddc-filter-matcher_length",           lazy = true },
      { "Shougo/ddc-filter-matcher_prefix",           lazy = true },
      { "Shougo/ddc-filter-sorter_rank",              lazy = true },
      { "Shougo/ddc-filter-sorter_head",              lazy = true },
      { "Shougo/ddc-filter-converter_remove_overlap", lazy = true },
    },
    config = setup,
    keys = {
      {
        ":",
        function()
          configure_command_mode_completion()
          return ":"
        end,
        expr = true,
        mode = { "n", "x" },
      },
      {
        "?",
        function()
          configure_search_mode_completion()
          return "?"
        end,
        expr = true,
        mode = "n"
      },
    },
    event = { "InsertEnter", "CmdlineEnter" },
  },
  {
    "Shougo/pum.vim",
    config = function()
      vim.fn["pum#set_option"]({
        commit_characters = { "." },
        padding = true,
      })
    end,
  }
}
