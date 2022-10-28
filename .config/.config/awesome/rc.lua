-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
--[[ myawesomemenu = { ]]
--[[ 	{ ]]
--[[ 		"hotkeys", ]]
--[[ 		function() ]]
--[[ 			hotkeys_popup.show_help(nil, awful.screen.focused()) ]]
--[[ 		end, ]]
--[[ 	}, ]]
--[[ 	{ "manual", terminal .. " -e man awesome" }, ]]
--[[ 	{ "edit config", editor_cmd .. " " .. awesome.conffile }, ]]
--[[ 	{ "restart", awesome.restart }, ]]
--[[ 	{ ]]
--[[ 		"quit", ]]
--[[ 		function() ]]
--[[ 			awesome.quit() ]]
--[[ 		end, ]]
--[[ 	}, ]]
--[[ } ]]

--[[ mymainmenu = awful.menu({ ]]
--[[ 	items = { ]]
--[[ 		{ "awesome", myawesomemenu, beautiful.awesome_icon }, ]]
--[[ 		{ "open terminal", terminal }, ]]
--[[ 	}, ]]
--[[ }) ]]

--[[ mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu }) ]]
local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")
myCustomLauncher = awful.widget.button({
	image = beautiful.awesome_icon,
})
myCustomLauncher:buttons(gears.table.join(
	myCustomLauncher:buttons(),
	awful.button({}, 1, nil, function()
		logout_popup.launch({
			bg_color = "#282a36",
			accent_color = "#ff79c6",
			phrases = {},
		})
	end)
))

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%m/%d/%y %I:%M  ")

local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local cw = calendar_widget({
	placement = "top_right",
})
mytextclock:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)

myseparator = wibox.widget.textbox("  ")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		--[[ awful.tag.viewnext(t.screen) ]]
	end),
	awful.button({}, 5, function(t)
		--[[ awful.tag.viewprev(t.screen) ]]
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		--[[ awful.client.focus.byidx(1) ]]
	end),
	awful.button({}, 5, function()
		--[[ awful.client.focus.byidx(-1) ]]
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag(
		{ " 爵 ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  " },
		s,
		awful.layout.layouts[6]
	)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	local colors = {
		"#dddddd",
		"#50fa7b",
		"#f7df1e",
		"#ffb86c",
		"#61dbfb",
		"#dddddd",
		"#bd93f9",
		"#ff79c6",
		"#ff5555",
	}
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		widget_template = {
			{
				id = "text_role",
				widget = wibox.widget.textbox,
			},
			id = "background_role",
			widget = wibox.container.background,
			create_callback = function(self, t, index, tagsList)
				self.fg = colors[index]
			end,
		},
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 5,
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })
	local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
	local mpris_widget = require("awesome-wm-widgets.mpris-widget")
	local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
	local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
	local net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")
	local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")
	local docker_widget = require("awesome-wm-widgets.docker-widget.docker")
	local cmus_widget = require("awesome-wm-widgets.cmus-widget.cmus")

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			myseparator,
			myCustomLauncher,
			myseparator,
			s.mytaglist,
			myseparator,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			--[[ mykeyboardlayout, ]]
			myseparator,
			wibox.widget.systray(),
			myseparator,
			cpu_widget({ color = "#50fa7b" }),
			myseparator,
			fs_widget({ mounts = { "/", "/home" }, widget_bar_color = "#f7df1e", widget_border_color = "#f7df1e" }),
			myseparator,
			ram_widget({ color_free = "#ffb86c", color_used = "#ff5555" }),
			myseparator,
			{
				mpris_widget(),
				fg = "#61dbfb",
				widget = wibox.container.background,
			},
			myseparator,
			{
				volume_widget({
					widget_type = "icon_and_text",
					icon_dir = "/home/kyle/.config/awesome/volume-icons/",
					size = 25,
				}),
				fg = "#bd93f9",
				widget = wibox.container.background,
			},
			myseparator,
			{
				docker_widget({ icon = "/home/kyle/.config/awesome/docker.svg" }),
				fg = "#ff79c6",
				widget = wibox.container.background,
			},
			myseparator,
			{
				mytextclock,
				fg = "#ff5555",
				widget = wibox.container.background,
			},
			myseparator,
			s.mylayoutbox,
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
--[[ root.buttons(gears.table.join( ]]
--[[ 	awful.button({}, 3, function() ]]
--[[ 		mymainmenu:toggle() ]]
--[[ 	end), ]]
--[[ 	awful.button({}, 4, awful.tag.viewnext), ]]
--[[ 	awful.button({}, 5, awful.tag.viewprev) ]]
--[[ )) ]]
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
	awful.key({ modkey }, "l", function()
		logout_popup.launch()
	end, { description = "Show logout screen", group = "custom" }),
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey, "Shift" }, "j", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey, "Shift" }, "k", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey }, "b", function()
		awful.spawn("brave")
	end, { description = "open a browser", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	awful.key({ modkey }, "r", function()
		awful.spawn("dmenu_run")
		--[[ awful.screen.focused().mypromptbox:run() ]]
	end, { description = "run dmenu", group = "launcher" }),

	awful.key({ modkey }, "n", function()
		awful.spawn("/home/kyle/.joplin/Joplin.AppImage")
		--[[ awful.screen.focused().mypromptbox:run() ]]
	end, { description = "run joplin", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	awful.key({ modkey }, "p", function()
		--[[ menubar.show() ]]
		awful.spawn(
			'rofi -combi-modi window,drun -font "JetBrainsMono Nerd Font Medium 16" -show combi -icon-theme "Papirus" -show-icons /home/kyle/.config/rofi/config.rasi'
		)
	end, { description = "show the menubar", group = "launcher" }),
	awful.key({ modkey }, "F1", function()
		local screen = awful.screen.focused()
		local tag = screen.tags[1]
		if tag then
			tag:view_only()
		end
		awful.spawn("brave")
	end, { description = "open browser in tag #1", group = "tag" }),
	awful.key({ modkey }, "F2", function()
		local screen = awful.screen.focused()
		local tag = screen.tags[2]
		if tag then
			tag:view_only()
		end
		awful.spawn("alacritty")
	end, { description = "open alacritty in tag #2", group = "tag" }),
	awful.key({ modkey }, "F3", function()
		local screen = awful.screen.focused()
		local tag = screen.tags[3]
		if tag then
			tag:view_only()
		end
		awful.spawn("brave")
	end, { description = "open browser in tag #3", group = "tag" }),
	awful.key({ modkey }, "F4", function()
		local screen = awful.screen.focused()
		local tag = screen.tags[4]
		if tag then
			tag:view_only()
		end
		awful.spawn("azuredatastudio")
	end, { description = "open azure data studio in tag #4", group = "tag" }),
	awful.key({ modkey }, "F5", function()
		local screen = awful.screen.focused()
		local tag = screen.tags[5]
		if tag then
			tag:view_only()
		end
		awful.spawn("rider")
	end, { description = "open rider in tag #5", group = "tag" }),
	awful.key({ modkey }, "F7", function()
		local screen = awful.screen.focused()
		local tag = screen.tags[7]
		if tag then
			tag:view_only()
		end
		awful.spawn("brave --new-window https://outlook.office.com/")
	end, { description = "open outlook in tag #7", group = "tag" }),
	awful.key({ modkey }, "F8", function()
		local screen = awful.screen.focused()
		local tag = screen.tags[8]
		if tag then
			tag:view_only()
		end
		awful.spawn("brave --new-window https://teams.microsoft.com/")
	end, { description = "open teams in tag #8", group = "tag" }),
	awful.key({ modkey }, "F9", function()
		local screen = awful.screen.focused()
		local tag = screen.tags[9]
		if tag then
			tag:view_only()
		end
		awful.spawn("brave --new-window https://music.youtube.com/")
	end, { description = "open music in tag #9", group = "tag" })
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
--[[ client.connect_signal("mouse::enter", function(c) ]]
--[[ 	c:emit_signal("request::activate", "mouse_enter", { raise = false }) ]]
--[[ end) ]]

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

gears.timer.start_new(1200, function()
	collectgarbage("step", 1024)
	return true
end)
-- Autostart Applications
awful.spawn("nitrogen --random --set-zoom-fill --head=0 /usr/share/backgrounds/")
awful.spawn("nitrogen --random --set-zoom-fill --head=1 /usr/share/backgrounds/")
awful.spawn("nitrogen --random --set-zoom-fill --head=2 /usr/share/backgrounds/")
awful.spawn("picom")
awful.spawn("xcape -e 'Control_L=Escape'")
awful.spawn("setxkbmap -option ctrl:nocaps")
awful.spawn("mkdir -p /home/kyle/google-drive/")
awful.spawn("rclone mount --file-perms 0777 --dir-perms 0777 --daemon google-drive: /home/kyle/google-drive/")
