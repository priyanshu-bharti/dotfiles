local wezterm = require("wezterm")

-- --------------------------------------------------
-- Config Builder
-- --------------------------------------------------
local config = wezterm.config_builder()

-- --------------------------------------------------
-- Imports
-- --------------------------------------------------
local keyMaps = require("hacks")

-- --------------------------------------------------
-- Animations
-- --------------------------------------------------

config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- --------------------------------------------------
-- Theme
-- --------------------------------------------------
local scheme = "Catppuccin Mocha"
config.color_scheme = scheme

-- Catppuccin Mocha palette (manual reference)
local colors = {
	base = "#1e1e2e",
	mantle = "#181825",
	surface0 = "#313244",
	surface1 = "#45475a",
	surface2 = "#585b70",
	text = "#cdd6f4",
	lavender = "#b4befe",
}

-- --------------------------------------------------
-- Window / UI
-- --------------------------------------------------
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_frame = {
	font = wezterm.font("CaskaydiaCove Nerd Font"),
	active_titlebar_bg = colors.base,
	inactive_titlebar_bg = colors.mantle,
}

config.window_background_opacity = 0.95
config.macos_window_background_blur = 16

config.window_padding = {
	top = 3,
	right = 3,
	bottom = 3,
	left = 3,
}

-- --------------------------------------------------
-- Tabs
-- --------------------------------------------------
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.show_tab_index_in_tab_bar = true

config.colors = {
	tab_bar = {
		background = colors.mantle,

		active_tab = {
			bg_color = colors.lavender,
			fg_color = colors.base,
			intensity = "Normal",
		},

		inactive_tab = {
			bg_color = colors.mantle,
			fg_color = colors.surface1,
		},

		inactive_tab_hover = {
			bg_color = colors.surface0,
			fg_color = colors.text,
			italic = true,
		},

		new_tab = {
			bg_color = colors.mantle,
			fg_color = colors.surface1,
		},

		new_tab_hover = {
			bg_color = colors.surface0,
			fg_color = colors.text,
			italic = true,
		},
	},
}

-- --------------------------------------------------
-- Panes
-- --------------------------------------------------
-- config.colors.inactive_pane = colors.mantle
-- config.inactive_pane_hsb = {
-- 	hue = 1.0,
-- 	saturation = 0.9,
-- 	brightness = 0.7,
-- }

-- --------------------------------------------------
-- Font / Cursor
-- --------------------------------------------------
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 13
config.line_height = 1.5

config.default_cursor_style = "BlinkingBlock"

-- --------------------------------------------------
-- Toggle Terminal
-- --------------------------------------------------
local has_toggle_terminal = false

local function toggle_terminal(window, pane)
	local tab = pane:tab()
	local panes_list = tab:panes_with_info()

	if has_toggle_terminal and #panes_list > 1 then
		-- A toggle terminal exists, close the last pane
		local last_pane = panes_list[#panes_list].pane
		last_pane:kill()
		has_toggle_terminal = false
	else
		-- Create new toggle terminal split
		pane:split({
			direction = "Bottom",
			size = 0.35,
		})
		has_toggle_terminal = true
	end
end

-- --------------------------------------------------
-- Keybindings
-- --------------------------------------------------
config.keys = {
	{
		key = "j",
		mods = "CMD",
		action = wezterm.action_callback(toggle_terminal),
	},
	{
		key = "|",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "CMD|SHIFT|CTRL",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Navigate between panes
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- Resize panes
	{
		key = "H",
		mods = "CMD|SHIFT|CTRL",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "L",
		mods = "CMD|SHIFT|CTRL",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "K",
		mods = "CMD|SHIFT|CTRL",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "J",
		mods = "CMD|SHIFT|CTRL",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "x",
		mods = "CMD|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	-- Reorder tabs
	{
		key = "LeftArrow",
		mods = "CMD|SHIFT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CMD|SHIFT",
		action = wezterm.action.MoveTabRelative(1),
	},
	{
		key = "T",
		mods = "CMD|SHIFT",
		action = wezterm.action.TogglePaneZoomState,
	},
}
-- config.disable_default_key_bindings = true
-- config.enable_csi_u_key_encoding = true
-- config.keys = keyMaps

-- --------------------------------------------------
-- Return
-- --------------------------------------------------
return config
