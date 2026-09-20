local w = require("wezterm")
local config = {}

-- sessionizer
local sessionizer = w.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
local history = w.plugin.require("https://github.com/mikkasendke/sessionizer-history.git") -- the most recent functionality moved to another plugin

local home_dir = w.home_dir
local config_path = home_dir .. "/.config"

-- Disable the "fancy" bar so it respects your color choices
config.use_fancy_tab_bar = false

-- Apply your custom tab bar colors based on One Light
config.colors = {
	tab_bar = {
		-- The background of the empty space behind tabs
		background = "#eaeaea",

		-- The tab you are currently looking at (matches your main window)
		active_tab = {
			fg_color = "#2a2c33", -- One Light main text
			bg_color = "#fafafa", -- One Light main background
			intensity = "Normal",
			italic = false,
		},

		-- Tabs that are open but not currently focused
		inactive_tab = {
			fg_color = "#2a2c33", -- Muted text for readability
			bg_color = "#e0e0e0", -- Slightly darker gray to show it is inactive
		},

		-- When you hover your mouse over an inactive tab
		inactive_tab_hover = {
			fg_color = "#2a2c33",
			bg_color = "#d5d5d5",
		},

		-- The "New Tab" plus button (+)
		new_tab = {
			fg_color = "#2a2c33",
			bg_color = "#e0e0e0",
		},
		new_tab_hover = {
			fg_color = "#2a2c33",
			bg_color = "#d5d5d5",
		},
	},
}

local schema = {
	options = {
		title = "My title",
		always_fuzzy = true,
		callback = history.Wrapper(sessionizer.DefaultCallback), -- tell history that we changed to another workspace
	},
	config_path .. "/wezterm",
	config_path .. "/nvim",
	config_path .. "/nixos",
	config_path,
	home_dir .. "/repos",
	sessionizer.FdSearch({ home_dir .. "/repos", include_submodules = true }),
}
config.keys = {
	-- Keybindings for sessionizer
	{ key = "m", mods = "CTRL|SHIFT", action = sessionizer.show(schema) },
	{ key = "e", mods = "CTRL|SHIFT", action = history.switch_to_most_recent_workspace },

	-- Keybindings for pane splitting
	{ key = '"', mods = "CTRL|SHIFT", action = w.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "s", mods = "CTRL|SHIFT", action = w.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

	-- Keybindings for resizing panes
	{ key = "LeftArrow", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Left", 10 } }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Right", 10 } }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Up", 3 } }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Down", 3 } }) },
	{ key = "H", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Left", 10 } }) },
	{ key = "L", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Right", 10 } }) },
	{ key = "K", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Up", 3 } }) },
	{ key = "J", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Down", 3 } }) },

	-- Keybinding for closing the current pane
	{ key = "q", mods = "CTRL|SHIFT", action = w.action({ CloseCurrentPane = { confirm = true } }) },
	-- Keybinding for closing the current tab
	{ key = "d", mods = "CTRL|SHIFT", action = w.action({ CloseCurrentTab = { confirm = true } }) },
	-- Show the selector, using your own alphabet
	{
		key = "x",
		mods = "CTRL|SHIFT",
		action = w.action({ PaneSelect = { alphabet = "0123456789", mode = "SwapWithActive" } }),
	},
}

-- theme
config.color_scheme = "oneLight"
-- font
config.font_size = 20

-- Disable gray fading on unfocused panes
config.inactive_pane_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 1.0,
}

return config
