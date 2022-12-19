local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
  return
end

lsp.preset("recommended")

lsp.ensure_installed({
  "html",
  "cssls",
  "tsserver",
  "eslint",
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
  vim.keymap.set("n", "<leader>f", ":LspZeroFormat<CR>", opts)
end)

local augroup = vim.api.nvim_create_augroup
local formatOnWriteGroup = augroup('formatOnWrite', {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = formatOnWriteGroup,
  pattern = "*",
  command = [[ :LspZeroFormat! ]],
})

lsp.configure('sumneko_lua', {
    settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-- Extra typescript support
lsp.configure('tsserver', {
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "TypescriptRemoveUnused",
      function(opts)
        local typescript_status_ok, typescript = pcall(require, "typescript")
        if typescript_status_ok then
          typescript.actions.removeUnused({ sync = opts.bang, bufnr = bufnr })
        end
      end,
      { bang = true }
    )
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "TypescriptAddMissingImports",
      function(opts)
        local typescript_status_ok, typescript = pcall(require, "typescript")
        if typescript_status_ok then
          typescript.actions.addMissingImports({ sync = opts.bang, bufnr = bufnr })
        end
      end,
      { bang = true }
    )
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "TypescriptRenameFile",
      function(opts)
        local source = vim.api.nvim_buf_get_name(bufnr)
        vim.ui.input(
          { prompt = "New path: ", default = source },
          function(input)
            if input == "" or input == source or input == nil then
              return
            end

            local typescript_status_ok, typescript = pcall(require, "typescript")
            if typescript_status_ok then
              typescript.renameFile(source, input, { force = opts.bang })
            end
          end
        )
      end,
      { bang = true }
    )

    local opts = { buffer = bufnr, remap = false, silent = true }

    vim.keymap.set("n", "<leader>tia", ":TypescriptAddMissingImports<CR>", opts)
    vim.keymap.set("n", "<leader>trf", ":TypescriptRenameFile<CR>", opts)
    vim.keymap.set("n", "<leader>tir", ":TypescriptRemoveUnused<CR>", opts)
  end
})

lsp.configure('eslint', {
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false, silent = true }

    vim.keymap.set("n", "<leader>fe", ":EslintFixAll<CR>", opts)
  end
})

-- snippets
require("luasnip/loaders/from_vscode").lazy_load()

lsp.nvim_workspace()
lsp.setup()
