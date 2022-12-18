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

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-- cmp config
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
})
lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

-- lsp config
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, opts)
  vim.keymap.set("n", "<leader>f", ":LspZeroFormat<CR>", opts)
  vim.keymap.set("n", "<leader>z", vim.lsp.buf.format, opts)
  vim.keymap.set("n", "<leader>tia", ":TypescriptAddMissingImports<CR>", opts)
  vim.keymap.set("n", "<leader>trf", ":TypescriptRenameFile<CR>", opts)
  vim.keymap.set("n", "<leader>tir", ":TypescriptRemoveUnused<CR>", opts)
end)

-- snippets
require("luasnip/loaders/from_vscode").lazy_load()

lsp.nvim_workspace()
lsp.setup()
