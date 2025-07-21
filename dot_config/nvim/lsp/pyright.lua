local function configure_python_path()
  local venv_path = vim.fn.getcwd() .. "/.venv"

  if vim.fn.isdirectory(venv_path) == 1 then
    return venv_path .. "/bin/python"
  end
  return "python"
end

--- @type vim.lsp.Config
return {
  settings = {
    python = {
      pythonPath = configure_python_path(),
    },
  },
}
