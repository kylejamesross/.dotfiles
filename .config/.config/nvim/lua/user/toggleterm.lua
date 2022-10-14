local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	direction = "float",
	open_mapping = [[<C-\>]],
	start_in_insert = true,
	close_on_exit = true,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "curved",
			background = "Normal",
		},
	},
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local bpytop = Terminal:new({ cmd = "bpytop", hidden = true })

function _lazygit_toggle()
	lazygit:toggle()
end

function _bpytop_toggle()
	bpytop:toggle()
end
