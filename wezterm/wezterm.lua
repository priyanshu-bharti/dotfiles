local wezterm = require("wezterm")

-- Create a config builder
local config = wezterm.config_builder()

-- Import your custom key mappings
local keyMaps = require("hacks")

-- Basic settings
config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingBar"
config.color_scheme = "Tokyo Night Moon"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 16
config.font_size = 16
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.line_height = 1.25
config.window_padding = {
	top = 3,
	right = 3, 
	bottom = 3,
	left = 3,
}

-- Apply your custom Cmd-based escape sequences

-- config.disable_default_key_bindings = true -- optional but recommended
-- config.enable_csi_u_key_encoding = true
-- config.keys = keyMaps

-- Export final config
return config
