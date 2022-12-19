local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
  return
end

lsp.preset("recommended")

lsp.ensure_installed({
  "tsserver",
  "eslint",
  "rust_analyzer",
})

lsp.set_preferences({
  sign_icons = {
    error = "",
    warn = "",
    hint = "",
    info = ""
  }
})

-- lsp config
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false, silent = true }

  vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, opts)
  vim.keymap.set("n", "<leader>z", vim.lsp.buf.format, opts)
  vim.keymap.set("n", "<leader>tia", ":TypescriptAddMissingImports<CR>", opts)
  vim.keymap.set("n", "<leader>trf", ":TypescriptRenameFile<CR>", opts)
  vim.keymap.set("n", "<leader>tir", ":TypescriptRemoveUnused<CR>", opts)
  vim.keymap.set("n", "<leader>f", ":LspZeroFormat<CR>", opts)
  vim.keymap.set("n", "<leader>fe", ":EslintFixAll<CR>", opts)
end)

lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-- snippets
require("luasnip/loaders/from_vscode").lazy_load()

lsp.nvim_workspace()
lsp.setup()

-- Override with extended typescript support
local typescript_status_ok, typescript = pcall(require, "typescript")
if not typescript_status_ok then
	return
end

typescript.setup({
	debug = false,
	go_to_source_definition = {
		fallback = true,
	},
	server = {
		on_attach = lsp.on_attach,
	},
})
