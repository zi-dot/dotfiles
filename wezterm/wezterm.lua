local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("gui-startup", function()
	local _, _, window = wezterm.mux.spawn_window({})
	local w = window:gui_window()
	w:maximize()
	w:toggle_fullscreen()
end)

wezterm.on("window-config-reloaded", function(window)
	window:toast_notification("wezterm", "Configuration reloaded!", nil, 4000)
end)

return {
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
	tab_bar_at_bottom = true,
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
