local wezterm = require("wezterm")
local act = wezterm.action

local mykeys = {}
for i = 1, 8 do
	table.insert(mykeys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

return {
	use_ime = true,
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("Hack Nerd Font"),
	animation_fps = 10,
	window_padding = {
		left = 5,
		right = 5,
		top = 8,
		bottom = 0,
	},
	adjust_window_size_when_changing_font_size = false,
	tab_bar_at_bottom = true,
	keys = mykeys,
}
