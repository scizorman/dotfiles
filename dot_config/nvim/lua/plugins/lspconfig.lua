local function setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
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
