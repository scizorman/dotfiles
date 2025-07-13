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

      vim.lsp.config("*", {
        capabilities = require("ddc_source_lsp").make_client_capabilities(),
      })
    end,
  })

  vim.lsp.enable({
    "denols",
    "gopls",
    "jsonls",
    "lua_ls",
    "terraformls",
    "ts_ls",
    "yamlls",
  })
end

--- @type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  dependencies = { "Shougo/ddc-source-lsp", lazy = true },
  config = setup,
  event = { "BufReadPre", "BufNewFile" },
}
