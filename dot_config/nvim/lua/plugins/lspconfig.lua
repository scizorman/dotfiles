local function setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      vim.diagnostic.config({
        virtual_text = { current_line = true },
      })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = event.buf })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf })
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = event.buf })
      vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, { buffer = event.buf })
      vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, { buffer = event.buf })
      vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, { buffer = event.buf })
      vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, { buffer = event.buf })

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
      end
    end,
  })

  vim.lsp.enable({
    "gopls",
    "lua_ls",
    "terraformls",
    "ts_ls",
  })
end

return {
  "neovim/nvim-lspconfig",
  config = setup,
}
