--- @type vim.lsp.Config
return {
  on_init = function(client)
    local venv_python = vim.fs.joinpath(client.root_dir, ".venv", "bin", "python")
    if vim.uv.fs_stat(venv_python) then
      client.settings = vim.tbl_deep_extend("force", client.settings, {
        python = { pythonPath = venv_python },
      })
      client:notify("workspace/didChangeConfiguration", {
        settings = client.settings,
      })
    end
  end,
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
}
