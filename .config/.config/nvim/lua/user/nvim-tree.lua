local status_ok, nvimTree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local typescript_status_ok, typescript = pcall(require, "typescript")
if not typescript_status_ok then
	return
end

nvimTree.setup({
	view = {
		adaptive_size = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	on_attach = function(bufnr)
		local inject_node = require("nvim-tree.utils").inject_node
		vim.keymap.set(
			"n",
			"<leader>n",
			inject_node(function(node)
				if node then
					--[[ typescript.actions.renameFile() ]]
					node.print(node.absolute_path)
				end
			end),
			{ buffer = bufnr, noremap = true }
		)
		vim.bo[bufnr].path = "/tmp"
	end,
})
