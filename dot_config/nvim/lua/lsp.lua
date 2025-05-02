local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local buffer = event.buf
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buffer })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buffer })
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = buffer })
      vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, { buffer = buffer })
      vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, { buffer = buffer })
      vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, { buffer = buffer })
      vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, { buffer = buffer })
      vim.keymap.set('n', ']d', function() vim.diagnostic.jump({count=1, float=true}) end, { buffer = buffer })
      vim.keymap.set('n', '[d', function() vim.diagnostic.jump({count=-1, float=true}) end, { buffer = buffer })

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client ~= nil then
        if client.server_capabilities.completionProvider then
          vim.lsp.completion.enable(true, client.id, event.buf, {
            autotrigger = true
          })
        end
      end
    end,
  })

  vim.lsp.enable({
    "gopls",
    "terraformls",
    "lua_ls",
  })
end

return M
