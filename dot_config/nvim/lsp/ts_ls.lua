--- @type vim.lsp.Config
return {
  root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
  single_file_support = false,
  workspace_required = true,
}
