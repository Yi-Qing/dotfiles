local wezterm = require 'wezterm'

local config = wezterm.config_builder()
-- config.automatically_reload_config = false

-- theme
config.color_scheme = 'synthwave'                -- or 'Isotope (base16)'
config.bold_brightens_ansi_colors = "BrightOnly" -- or "No"

-- font
config.font = wezterm.font_with_fallback {
    { family = 'JetBrainsMono Nerd Font Mono', weight = 'Light' },
    { family = '思源黑体 CN', weight = 'Light' },
    'Noto Color Emoji',
}
config.font_size = 16

-- window
config.initial_rows = 30
config.initial_cols = 120
config.window_background_opacity = 0.65
config.window_decorations = "NONE"
config.window_padding = {
    top = 10,
    left = 5,
    right = 0,
    bottom = 0,
}

-- exit
config.window_close_confirmation = "NeverPrompt"
config.exit_behavior = "Close"

-- Gpu rendering
config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower" -- iGPU

-- Tab bar
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

-- cursor
config.animation_fps = 1
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.default_cursor_style = 'BlinkingBlock'
config.hide_mouse_cursor_when_typing = true

-- bell
config.audible_bell = "Disabled"
config.visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = 'CursorColor',
}

-- misc config
config.scrollback_lines = 5000
config.check_for_updates = false
config.prefer_to_spawn_tabs = true                       -- prefer to spawn new tabs instead of new windows
config.detect_password_input = true                      -- when user is typing a password then hide the input
config.notification_handling = "SuppressFromFocusedPane" -- notificetaion unless focused pane

-- keymap
if true then
    config.disable_default_key_bindings = true
    local keymap = require 'keymap'
    keymap.apply(config)
end

-- target cusomization
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    local windows = require 'windows'
    windows.apply(config)
end

return config
