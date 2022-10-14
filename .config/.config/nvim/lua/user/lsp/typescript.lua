local typescript_status_ok, typescript = pcall(require, "typescript")
if not typescript_status_ok then
	return
end

typescript.setup({
	--[[ disable_commands = false, ]]
	debug = false,
	go_to_source_definition = {
		fallback = true,
	},
	server = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	},
})
