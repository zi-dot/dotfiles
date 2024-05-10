local wezterm = require("wezterm")
local act = wezterm.action
--
-- wezterm.on("gui-startup", function()
-- 	local _, _, window = wezterm.mux.spawn_window({})
-- 	local w = window:gui_window()
-- 	w:maximize()
-- 	w:toggle_fullscreen()
-- end)
--
wezterm.on("window-config-reloaded", function(window)
	window:toast_notification("wezterm", "Configuration reloaded!", nil, 4000)
end)

local color_default_fg_light = wezterm.color.parse("#cacaca") -- 💩
local color_default_fg_dark = wezterm.color.parse("#303030")

local color = (function()
	local COLOR = {
		VERIDIAN = {
			bg = wezterm.color.parse("#4D8060"),
			fg = color_default_fg_light,
		},
		PAYNE = {
			bg = wezterm.color.parse("#385F71"),
			fg = color_default_fg_light,
		},
		INDIGO = {
			bg = wezterm.color.parse("#7C77B9"),
			fg = color_default_fg_light,
		},
		CAROLINA = {
			bg = wezterm.color.parse("#8FBFE0"),
			fg = color_default_fg_dark,
		},
		FLAME = {
			bg = wezterm.color.parse("#D36135"),
			fg = color_default_fg_dark,
		},
		JET = {
			bg = wezterm.color.parse("#282B28"),
			fg = color_default_fg_light,
		},
		TAUPE = {
			bg = wezterm.color.parse("#785964"),
			fg = color_default_fg_light,
		},
		ECRU = {
			bg = wezterm.color.parse("#C6AE82"),
			fg = color_default_fg_dark,
		},
		VIOLET = {
			bg = wezterm.color.parse("#685F74"),
			fg = color_default_fg_light,
		},
		VERDIGRIS = {
			bg = wezterm.color.parse("#28AFB0"),
			fg = color_default_fg_light,
		},
	}

	local coolors = {
		COLOR.VERIDIAN,
		COLOR.PAYNE,
		COLOR.INDIGO,
		COLOR.CAROLINA,
		COLOR.FLAME,
		COLOR.JET,
		COLOR.TAUPE,
		COLOR.ECRU,
		COLOR.VIOLET,
		COLOR.VERDIGRIS,
	}

	return coolors[math.random(#coolors)]
end)()

local color_primary = color

local title_color_bg = color_primary.bg
local title_color_fg = color_primary.fg

local color_off = title_color_bg:lighten(0.4)
local color_on = color_off:lighten(0.4)
wezterm.on("update-right-status", function(window)
	local bat = ""

	local time = wezterm.strftime("%-l:%M %P")

	local bg1 = title_color_bg:lighten(0.1)
	local bg2 = title_color_bg:lighten(0.2)

	window:set_right_status(wezterm.format({
		{ Background = { Color = title_color_bg } },
		{ Foreground = { Color = bg1 } },
		{ Text = "" },
		{ Background = { Color = title_color_bg:lighten(0.1) } },
		{ Foreground = { Color = title_color_fg } },
		{ Text = " " .. window:active_workspace() .. " " },
		{ Foreground = { Color = bg1 } },
		{ Background = { Color = bg2 } },
		{ Text = "" },
		{ Foreground = { Color = title_color_bg:lighten(0.4) } },
		{ Foreground = { Color = title_color_fg } },
		{ Text = " " .. time .. " " .. bat },
	}))
end)

wezterm.on("gui-startup", function(cmd)
	local mux = wezterm.mux

	local padSize = 80
	local screenWidth = 2560
	local screenHeight = 1600

	local tab, pane, window = mux.spawn_window(cmd or {
		workspace = "main",
	})

	local icons = {
		"🌞",
		"🍧",
		"🫠",
		"🏞️",
		"📑",
		"🪁",
		"🧠",
		"🦥",
		"🦉",
		"📀",
		"🌮",
		"🍜",
		"🧋",
		"🥝",
		"🍊",
	}

	tab:set_title("  " .. icons[math.random(#icons)] .. "  ")

	if window ~= nil then
		window:gui_window():set_position(padSize, padSize)
		window:gui_window():set_inner_size(screenWidth - (padSize * 2), screenHeight - (padSize * 2) - 48)
	end
end)

local TAB_EDGE_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick
local TAB_EDGE_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick

local function tab_title(tab_info)
	local title = tab_info.tab_title

	if title and #title > 0 then
		return title
	end

	return tab_info.active_pane.title:gsub("%.exe", "")
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
	local edge_background = title_color_bg
	local background = title_color_bg:lighten(0.05)
	local foreground = title_color_fg

	if tab.is_active then
		background = background:lighten(0.1)
		foreground = foreground:lighten(0.1)
	elseif hover then
		background = background:lighten(0.2)
		foreground = foreground:lighten(0.2)
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = TAB_EDGE_LEFT },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = TAB_EDGE_RIGHT },
	}
end)

return {
	colors = {
		tab_bar = {
			active_tab = {
				bg_color = title_color_bg:lighten(0.03),
				fg_color = title_color_fg:lighten(0.8),
				intensity = "Bold",
			},
			inactive_tab = {
				bg_color = title_color_bg:lighten(0.01),
				fg_color = title_color_fg,
				intensity = "Half",
			},
			inactive_tab_edge = title_color_bg,
		},
		split = title_color_bg:lighten(0.3):desaturate(0.5),
	},
	window_frame = {
		active_titlebar_bg = title_color_bg,
		inactive_titlebar_bg = title_color_bg,
		font_size = 14.0,
	},

	window_decorations = "RESIZE",
	win32_system_backdrop = "Acrylic",
	show_tab_index_in_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	-- }
	--
	-- return {
	use_ime = true,
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("Hack Nerd Font"),
	window_padding = {
		left = 5,
		right = 5,
		top = 8,
		bottom = 0,
	},
	adjust_window_size_when_changing_font_size = false,
	use_fancy_tab_bar = true,
	keys = {
		{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
		{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = act.ActivateTab(4) },

		{ key = "f", mods = "SHIFT|META", action = wezterm.action.ToggleFullScreen },
	},
	animation_fps = 60,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
}
