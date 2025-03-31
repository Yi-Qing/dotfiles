local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- config.automatically_reload_config = false
config.check_for_updates = false

config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower" -- iGPU
config.audible_bell= "Disabled"
config.bold_brightens_ansi_colors = "BrightOnly"    -- or "No"

config.color_scheme = 'synthwave'   -- 'Isotope (base16)'
-- config.color_scheme = 'Isotope (base16)'   -- 'synthwave'
config.initial_rows = 30
config.initial_cols = 120

config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.exit_behavior = "Close"

config.font = wezterm.font 'FiraCode Nerd Font Mono Light'
config.font_size = 13.0

config.scrollback_lines = 5000

config.window_decorations = "NONE"
config.window_background_opacity = 0.75
-- config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

config.switch_to_last_active_tab_when_closing_tab = true
config.window_close_confirmation = 'NeverPrompt'

config.window_padding = {
    top = 10,
    left = 5,
    right = 0,
    bottom = 0,
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    -- config.canonicalize_pasted_newlines = "CarriageReturn"
    config.hide_tab_bar_if_only_one_tab = false
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    config.win32_system_backdrop = "Disable"
    config.default_prog = { 'C:\\Root\\MSYS2\\usr\\bin\\bash.exe', "--login", "-i"}
    config.set_environment_variables = {
        MSYSTEM = "UCRT64",
        MSYS = "winsymlinks:nativestrict",
        CHERE_INVOKING = "enabled_from_arguments",
    }
end

return config
