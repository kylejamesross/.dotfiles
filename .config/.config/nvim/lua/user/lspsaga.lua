local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

local keymap = vim.keymap.set

saga.init_lsp_saga()

-- Lsp finder find the symbol definition implement reference
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("v", "<leader>la", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

-- Rename
keymap("n", "lr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Definition preview
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
keymap("n", "gl", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnsotic jump
keymap("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })

-- Only jump to error
keymap("n", "<leader>lj", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "<leader>lk", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
keymap("n", "<leader>lo", "<cmd>LSoutlineToggle<CR>", { silent = true })

-- Hover Doc
keymap("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Signature help
keymap("n", "ls", "<Cmd>Lspsaga signature_help<CR>", { silent = true })

--[[ local action = require("lspsaga.action") ]]
--[[ -- scroll in hover doc or  definition preview window ]]
--[[ vim.keymap.set("n", "<C-f>", function() ]]
--[[ 	action.smart_scroll_with_saga(1) ]]
--[[ end, { silent = true }) ]]
--[[ -- scroll in hover doc or  definition preview window ]]
--[[ vim.keymap.set("n", "<C-b>", function() ]]
--[[ 	action.smart_scroll_with_saga(-1) ]]
--[[ end, { silent = true }) ]]
