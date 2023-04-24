local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
  return
end
local status_ok_cmp, cmp = pcall(require, "cmp")
if not status_ok_cmp then
  return
end

lsp.preset("recommended")

lsp.ensure_installed({
  "html",
  "cssls",
  "tsserver",
  "eslint",
  "lua_ls",
})

lsp.set_sign_icons({
  error = "",
  warn = "",
  hint = "",
  info = "",
})

-- lsp config
lsp.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false, silent = true }

  vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, remap = false, silent = true, desc = "Hover (LSP)" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition,
  { buffer = bufnr, remap = false, silent = true, desc = "Go to definition (LSP)" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
  { buffer = bufnr, remap = false, silent = true, desc = "Go to declaration (LSP)" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
  { buffer = bufnr, remap = false, silent = true, desc = "Go to implementations (LSP)" })
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition,
  { buffer = bufnr, remap = false, silent = true, desc = "Go to type definition (LSP)" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references,
  { buffer = bufnr, remap = false, silent = true, desc = "Go to references (LSP)" })
  vim.keymap.set("n", "gl", vim.diagnostic.open_float,
  { buffer = bufnr, remap = false, silent = true, desc = "Go diagnostic float (LSP)" })
  vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol,
  { buffer = bufnr, remap = false, silent = true, desc = "Workspace symbol (LSP)" })
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action,
  { buffer = bufnr, remap = false, silent = true, desc = "Code action" })
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, remap = false, silent = true, desc = "Rename" })
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { buffer = bufnr, remap = false, silent = true, desc = "Signature help" })
  vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist,
  { buffer = bufnr, remap = false, silent = true, desc = "Set location list" })
  vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist,
  { buffer = bufnr, remap = false, silent = true, desc = "Set quickfix list" })
  vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = bufnr, remap = false, silent = true, desc = "Next diagnostic (LSP)" })
  vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = bufnr, remap = false, silent = true, desc = "Previous diagnostic (LSP)" })
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ bufnr, async = true })
  end, { buffer = bufnr, remap = false, silent = true, desc = "Format file (LSP)" })
end)

lsp.configure("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Extra typescript support
lsp.configure("tsserver", {
  on_attach = function(client, bufnr)
    lsp.default_keymaps({
      buffer = bufnr,
      pr
    })
    vim.api.nvim_buf_create_user_command(bufnr, "TypescriptRemoveUnused", function(opts)
      local typescript_status_ok, typescript = pcall(require, "typescript")
      if typescript_status_ok then
        typescript.actions.removeUnused({ sync = opts.bang, bufnr = bufnr })
      end
    end, { bang = true })
    vim.api.nvim_buf_create_user_command(bufnr, "TypescriptAddMissingImports", function(opts)
      local typescript_status_ok, typescript = pcall(require, "typescript")
      if typescript_status_ok then
        typescript.actions.addMissingImports({ sync = opts.bang, bufnr = bufnr })
      end
    end, { bang = true })
    vim.api.nvim_buf_create_user_command(bufnr, "TypescriptRenameFile", function(opts)
      local source = vim.api.nvim_buf_get_name(bufnr)
      vim.ui.input({ prompt = "New path: ", default = source }, function(input)
        if input == "" or input == source or input == nil then
          return
        end

        local typescript_status_ok, typescript = pcall(require, "typescript")
        if typescript_status_ok then
          typescript.renameFile(source, input, { force = opts.bang })
        end
      end)
    end, { bang = true })

    local opts = { buffer = bufnr, remap = false, silent = true }

    vim.keymap.set("n", "<leader>l1", ":TypescriptAddMissingImports<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "Add missing imports" })
    vim.keymap.set("n", "<leader>l2", ":TypescriptRemoveUnused<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "Remove unused imports" })
    vim.keymap.set("n", "<leader>l3", ":TypescriptRenameFile<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "File rename" })
  end,
})

lsp.configure("eslint", {
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false, silent = false }
    vim.keymap.set("n", "<leader>le", ":EslintFixAll<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "Eslint fix all" })
  end,
})

-- snippets
require("luasnip/loaders/from_vscode").lazy_load()

-- cmp
cmp.setup()

lsp.nvim_workspace() -- To be removed
lsp.setup()

-- show diagnostic messages inline
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
