local module = {}

local bash_path = "C:/Program Files/Git/usr/bin/bash.exe"
-- local bash_path = "D:/MSYS2/usr/bin/bash.exe"

local function file_exists(file_name)
    local success, err = io.open(file_name, "r")
    if success then
        success:close()
        return true
    else
        return false
    end
end

local function config_env(config)
    if string.find(bash_path, "msys2") or string.find(bash_path, "MSYS2") then
        config.set_environment_variables = {
            MSYSTEM = "UCRT64",
            MSYS2_PATH_TYPE = "inherit",
            MSYS = "winsymlinks:nativestrict",
            CHERE_INVOKING = "enabled_from_arguments",
        }
    elseif string.find(bash_path, "Git") then
        config.set_environment_variables = {
            MSYSTEM = "MINGW64",
            MSYS = "winsymlinks:nativestrict",
            CHERE_INVOKING = "enabled_from_arguments",
        }
    end
    config.skip_close_confirmation_for_processes_named = {
        'cmd.exe',
        'bash.exe',
        'powershell.exe',
    }
end

function module.apply(config)
    config.enable_tab_bar = true
    config.check_for_updates = true
    config.tab_bar_at_bottom = false
    config.hide_tab_bar_if_only_one_tab = false
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    config.color_scheme = 'Isotope (base16)' -- 'synthwave'

    if file_exists(bash_path) then
        config.default_prog = { bash_path, "-l", "-i" }
        config_env(config)
    else
        config.default_prog = { 'powershell.exe' }
    end
end

return module
