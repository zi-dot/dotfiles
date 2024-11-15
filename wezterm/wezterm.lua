local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("window-config-reloaded", function(window)
	window:toast_notification("wezterm", "Configuration reloaded!", nil, 4000)
end)

return {
	colors = {},
	window_frame = {
		font_size = 16.0,
	},

	window_decorations = "RESIZE",
	win32_system_backdrop = "Acrylic",
	show_tab_index_in_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	-- color_scheme = "Chameleon (Gogh)",
	color_scheme = "Ayu Dark (Gogh)",
	use_ime = true,
	font = wezterm.font("Zed Mono Extended"),
	window_padding = {
		left = 5,
		right = 5,
		top = 8,
		bottom = 0,
	},
	adjust_window_size_when_changing_font_size = false,
	use_fancy_tab_bar = true,
	keys = {
		{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
		{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },

		{ key = "f", mods = "SHIFT|META", action = wezterm.action.ToggleFullScreen },
	},
	animation_fps = 60,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	scrollback_lines = 350000,
}
