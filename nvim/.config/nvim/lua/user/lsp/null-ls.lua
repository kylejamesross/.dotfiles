local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath("config") .. "/.prettierrc"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debounce = 150,
	autostart = true,
	debug = false,
	sources = {
		formatting.eslint_d,
		diagnostics.eslint_d,
		code_actions.eslint_d,
		formatting.prettier.with({
			prefer_local = "node_modules/.bin",
			filetypes = {
				"typescriptreact",
				"typescript",
				"javascriptreact",
				"javascript",
				"svelte",
				"json",
				"jsonc",
				"css",
				"less",
				"scss",
				"html",
				"yaml",
			},
		}),
		formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ set_timeout = 2000 })
				end,
			})
		end
	end,
})
