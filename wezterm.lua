local w = require 'wezterm'
local config = {}

-- sessionizer
local sessionizer = w.plugin.require "https://github.com/mikkasendke/sessionizer.wezterm"
local history = w.plugin.require "https://github.com/mikkasendke/sessionizer-history.git" -- the most recent functionality moved to another plugin

local home_dir = w.home_dir
local config_path = home_dir .. ("/.config")

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
   sessionizer.FdSearch { home_dir .. "/repos", include_submodules = true },
}
config.keys = {
	  -- Keybindings for sessionizer
   { key = "m", mods = "CTRL|SHIFT", action = sessionizer.show(schema) },
   { key = "x", mods = "CTRL|SHIFT", action = history.switch_to_most_recent_workspace },

   -- Keybindings for pane splitting
	{ key = '"', mods = "CTRL|SHIFT", action = w.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "s", mods = "CTRL|SHIFT", action = w.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

	-- Keybindings for resizing panes
	{ key = "LeftArrow", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Left", 10 } }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Right", 10 } }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Up", 10 } }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT|ALT", action = w.action({ AdjustPaneSize = { "Down", 10 } }) },

	-- Keybinding for closing the current pane
	{ key = "q", mods = "CTRL|SHIFT", action = w.action({ CloseCurrentPane = { confirm = true } }) },
	-- Keybinding for closing the current tab
	{ key = "d", mods = "CTRL|SHIFT", action = w.action({ CloseCurrentTab = { confirm = true } }) },
	-- Show the selector, using your own alphabet
	{
		key = "x",
		mods = "CTRL",
		action = w.action({ PaneSelect = { alphabet = "0123456789", mode = "SwapWithActive" } }),
	},
}

-- theme
config.color_scheme = "oneLight"
-- font
config.font_size = 20

return config
