local M = {}

local function is_pum_visible()
  return vim.fn["pum#visible"]() == 1
end

local function is_start_or_after_space()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")
  return col <= 1 or string.match(string.sub(line, col-1, col-1), "%s")
end

local function cleanup_cmdline_completion()
end

local function setup_cmdline_completion(cmd)
  local cmdline_bufnr = vim.fn.getbufnr("%")

  vim.api.nvim_create_autocmd("User", {
    pattern = "DDCCmdlineLeave",
    callback = cleanup_cmdline_completion,
    once = true
  })
  vim.api.nvim_create_autocmd("InsertEnter", {
    buffer = cmdline_bufnr,
    callback = cleanup_cmdline_completion,
    once = true
  })
end

function M.hook_add()
end

function M.hook_source()
  local ddc_config = string.format("%s/config/ddc.ts", vim.fn.stdpath("config"))
  vim.fn["ddc#custom#load_config"](ddc_config)

  vim.keymap.set(
    "i",
    "<Tab>",
    function()
      if is_pum_visible() then
        return vim.fn["pum#map#insert_relative"](1)
      end
      if is_start_or_after_space() then
        return "<Tab>"
      end
      return vim.fn["ddc#map#manual_complete"]()
    end,
    { expr = true, silent = true }
  )
  vim.keymap.set("i", "<S-Tab>", [[<Cmd>call pum#map#insert_relative(-1)<CR>]], { silent = true })
  vim.keymap.set("i", "<C-N>", [[<Cmd>call pum#map#select_relative(+1)<CR>]], { silent = true })
  vim.keymap.set("i", "<C-P>", [[<Cmd>call pum#map#select_relative(-1)<CR>]], { silent = true })
  vim.keymap.set("i", "<C-Y>", [[<Cmd>call pum#map#confirm()<CR>]], { silent = true })
  vim.keymap.set("i", "<C-E>", [[<Cmd>call pum#map#cancel()<CR>]], { silent = true })

  vim.fn["ddc#enable"]()
end

return M
