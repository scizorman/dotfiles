local M = {}

local function install_plugin(plugin, plugin_src)
  local cmd = string.format("git clone https://github.com/%s %s", plugin, plugin_src)
  vim.fn.system(cmd)
end

local function init_plugin(dpp_base, plugin)
  local src = string.format("%s/repos/github.com/%s", dpp_base, plugin)
  if vim.fn.isdirectory(src) == 0 then
    install_plugin(plugin, src)
  end
  vim.opt.runtimepath:prepend(src)
end

function M.setup()
  local dpp_base = string.format("%s/dpp", vim.fn.expand(vim.env.XDG_CACHE_HOME))

  init_plugin(dpp_base, "Shougo/dpp.vim")
  init_plugin(dpp_base, "Shougo/dpp-ext-lazy")
  init_plugin(dpp_base, "vim-denops/denops.vim")

  local dpp = require("dpp")
  if dpp.load_state(dpp_base) then
    local plugins = {
      "vim-denops/denops.vim",
      "Shougo/dpp-ext-toml",
      "Shougo/dpp-ext-installer",
      "Shougo/dpp-protocol-git",
    }
    for _, plugin in ipairs(plugins) do
      init_plugin(dpp_base, plugin)
    end

    local dpp_config = string.format("%s/config/dpp.ts", vim.fn.stdpath("config"))
    vim.api.nvim_create_autocmd("User", {
      pattern = "DenopsReady",
      callback = function()
        vim.notify("dpp load_state() is failed")
        dpp.make_state(dpp_base, dpp_config)
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.toml",
      callback = function()
        local not_installed = vim.fn["dpp#sync_ext_action"]("installer", "getNotInstalled")
        if #not_installed > 0 then
          vim.fn["dpp#async_ext_action"]("installer", "install")
        end
      end,
    })
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "Dpp:makeStatePost",
    callback = function()
      vim.notify("dpp make_state() is done")
    end,
  })
end

return M
