local status_ok, dracula = pcall(require, "dracula")
if not status_ok then
	return
end

dracula.setup({
	colors = {
		bg = "#242631",
	},
	lualine_bg_color = "#242631",
})
