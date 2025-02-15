local w = require("wezterm")

local config = {}

if w.config_builder then
	config = w.config_builder()
end

-- sessionizer
local sessionizer = w.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
sessionizer.apply_to_config(config, true) -- disable default binds (right now you can also just not call this)
-- you can also list multiple paths
sessionizer.config = {
	paths = {
		"C:/users/egork/AppData/Roaming/helix",
		"C:/users/egork/AppData/Local/nvim",
		"C:/users/egork/.config",
		"D:/repos",
	},
}

config.keys = {
	-- Keybindings for sessionizer
	{
		key = "s",
		mods = "ALT",
		action = sessionizer.show,
	},
	{
		key = "r",
		mods = "ALT",
		action = sessionizer.switch_to_most_recent,
	},

	-- Keybindings for pane splitting
	{ key = '"', mods = "CTRL|SHIFT", action = w.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "s", mods = "CTRL|SHIFT", action = w.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

	-- Keybindings for resizing panes
	{ key = "LeftArrow", mods = "CTRL|ALT", action = w.action({ AdjustPaneSize = { "Left", 10 } }) },
	{ key = "RightArrow", mods = "CTRL|ALT", action = w.action({ AdjustPaneSize = { "Right", 10 } }) },
	{ key = "UpArrow", mods = "CTRL|ALT", action = w.action({ AdjustPaneSize = { "Up", 10 } }) },
	{ key = "DownArrow", mods = "CTRL|ALT", action = w.action({ AdjustPaneSize = { "Down", 10 } }) },

	-- Keybinding for closing the current pane
	{ key = "q", mods = "CTRL|SHIFT", action = w.action({ CloseCurrentPane = { confirm = true } }) },
	-- Keybinding for closing the current tab
	{ key = "d", mods = "CTRL|SHIFT", action = w.action({ CloseCurrentTab = { confirm = true } }) },
	-- Show the selector, using your own alphabet
	{
		key = "p",
		mods = "CTRL",
		action = w.action({ PaneSelect = { alphabet = "0123456789", mode = "SwapWithActive" } }),
	},
}

-- theme
config.color_scheme = "oneLight"

-- default terminal for windows
config.default_prog = { 'powershell.exe' }

return config
