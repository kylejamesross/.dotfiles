local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup{
  direction = 'float',
  open_mapping = [[<C-\>]],
  float_opts = {
    border = "curved",
		winblend = 0,
		highlights = {
			border = "curved",
			background = "Normal",
		},
  }
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
