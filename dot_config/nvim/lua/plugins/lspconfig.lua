local function setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      vim.diagnostic.config({
        virtual_text = { current_line = true },
      })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
        buffer = event.buf,
        desc = "vim.lsp.buf.definition()",
      })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
        buffer = event.buf,
        desc = "vim.lsp.buf.declaration()",
      })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
        buffer = event.buf,
        desc = "vim.lsp.buf.implementation()",
      })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {
        buffer = event.buf,
        desc = "vim.lsp.buf.references()",
      })
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, {
        buffer = event.buf,
        desc = "vim.lsp.buf.type_definition()",
      })
      vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, {
        buffer = event.buf,
        desc = "vim.lsp.buf.code_action()",
      })
      vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, {
        buffer = event.buf,
        desc = "vim.lsp.buf.hover()",
      })
      vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, {
        buffer = event.buf,
        desc = "vim.lsp.buf.rename()",
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format({ async = true })
        end,
      })

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client ~= nil and client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
      end
    end,
  })

  vim.lsp.enable({
    "gopls",
    "lua_ls",
    "terraformls",
    "ts_ls",
    "yamlls",
  })
end

--- @type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  config = setup,
}
