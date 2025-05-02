local M = {}

function M.hook_add()
  vim.keymap.set(
    "n",
    "<Leader>f",
    function()
      local src = vim.fn.finddir(".git", ";") ~= "" and "file_git" or "file_rg"
      local cmd = [[Ddu -name=files %s -ui-param-ff-startFilter]]
      vim.cmd(string.format(cmd, src))
    end
  )
  vim.keymap.set("n", "/", [[<Cmd>Ddu -name=search line -ui-param-ff-startFilter<CR>]])
  vim.keymap.set("n", "*", [[<Cmd>Ddu -name=search line -input=`expand("<cword>)`<CR>]])

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff",
    callback = function()
      vim.keymap.set("n", "<CR>", [[<Cmd>call ddu#ui#do_action("itemAction")<CR>]], { buffer = true })
      vim.keymap.set("n", "<Esc>", [[<Cmd>call ddu#ui#do_action("quit")<CR>]], { buffer = true })
      vim.keymap.set("n", "i", [[<Cmd>call ddu#ui#do_action("openFilterWindow")<CR>]], { buffer = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-filer",
    callback = function()
      vim.keymap.set("n", "<CR>", [[<Cmd>call ddu#ui#filer#do_action("itemAction")<CR>]], { buffer = true })
      vim.keymap.set("n", "q", [[<Cmd>call ddu#ui#do_action("quit")]], { buffer = true })
      vim.keymap.set("n", "o", [[<Cmd>call ddu#ui#filer#do_action("expandItem", #{ mode: "toggle", isGrouped: v:true, isInTree: v:false })]], { buffer = true })
    end
  })
end

function M.hook_source()
  local ddu_config = string.format("%s/config/ddu.ts", vim.fn.stdpath("config"))
  vim.fn["ddu#custom#load_config"](ddu_config)
end

return M
