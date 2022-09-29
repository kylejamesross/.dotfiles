local dracula = require("dracula")
dracula.setup({
	colors = {
		bg = "#242631",
	},
	lualine_bg_color = "#242631",
})
local colorscheme = "dracula"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
