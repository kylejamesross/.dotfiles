local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[                 .88888888:.]],
	[[                88888888.88888.]],
	[[              .8888888888888888.]],
	[[              888888888888888888]],
	[[              88' _`88'_  `88888]],
	[[              88 88 88 88  88888]],
	[[              88_88_::_88_:88888]],
	[[              88:::,::,:::::8888]],
	[[              88`:::::::::'`8888]],
	[[             .88  `::::'    8:88.]],
	[[            8888            `8:888.]],
	[[          .8888'             `888888.]],
	[[         .8888:..  .::.  ...:'8888888:.]],
	[[        .8888.'     :'     `'::`88:88888]],
	[[       .8888        '         `.888:8888.]],
	[[      888:8         .           888:88888]],
	[[    .888:88        .:           888:88888:]],
	[[    8888888.       ::           88:888888]],
	[[    `.::.888.      ::          .88888888]],
	[[   .::::::.888.    ::         :::`8888'.:.]],
	[[  ::::::::::.888   '         .::::::::::::]],
	[[  ::::::::::::.8    '      .:8::::::::::::.]],
	[[ .::::::::::::::.        .:888:::::::::::::]],
	[[ :::::::::::::::88:.__..:88888:::::::::::']],
	[[  `'.:::::::::::88888888888.88:::::::::']],
	[[        `':::_:' -- '' -'-' `':_::::'`]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}
local function footer()
	return "Kyle Ross"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
