local pid = vim.fn.getpid()

local omnisharp_bin = "/home/kyle/.dotfiles/.local/.local/share/nvim/lsp_servers/omnisharp/omnisharp"

return {
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
}
