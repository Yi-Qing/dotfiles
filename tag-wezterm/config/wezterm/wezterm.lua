local wezterm = require 'wezterm'

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font_size = 15.0
config.color_scheme = 'Breeze'
config.font = wezterm.font 'JetBrains Mono'

config.window_decorations = "NONE"
config.window_background_opacity = 0.7
config.window_padding = {
    top = 3,
    left = 3,
    right = 0,
    bottom = 0,
}

-- Tab bar
-- config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.font_size = 13.0
    config.window_background_opacity = 0.8
    config.default_prog = { 'C:\\Root\\MSYS2\\usr\\bin\\bash.exe', "--login", "-i"}
    config.set_environment_variables = {
        MSYSTEM = "UCRT64",
		MSYS = "winsymlinks:nativestrict",
		CHERE_INVOKING = "enabled_from_arguments",
    }
end

return config
