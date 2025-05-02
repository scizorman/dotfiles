local M = {}

function M.hook_source()
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
    end,
  })

  vim.lsp.enable({
    "gopls",
    "denols",
    "terraformls",
    "lua_ls",
  })

  vim.lsp.config("denols", {
    settings = {
      root_markers = {"deno.json", "deno.jsonc"},
      workspace_required = false,
    },
  })
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = {"vim"},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

return M
