local wezterm = require("wezterm")
local act = wezterm.action

function macCommandToMeta()
    local lower_keys = "abdefgijklmnoprsuxyz[]\\;',./"
    local upper_keys = "ABDEFGIJKLMNOPRSUXYZ"

    local keyMappings = {}

    -- Cmd only
    for i = 1, #lower_keys do
        local char = lower_keys:sub(i, i)
        local esc_code = string.format("\x1b[99;%du", i + 200)
        table.insert(keyMappings, {
            key = char,
            mods = "CMD",
            action = act.SendString(esc_code),
        })
    end

    -- Cmd+Shift
    for i = 1, #upper_keys do
        local char = upper_keys:sub(i, i)
        local esc_code = string.format("\x1b[99;%du", i + 250)
        table.insert(keyMappings, {
            key = char,
            mods = "CMD|SHIFT",
            action = act.SendString(esc_code),
        })
    end

    -- **New: Cmd+Ctrl+Shift**
    for i = 1, #upper_keys do
        local char = upper_keys:sub(i, i)
        local esc_code = string.format("\x1b[99;%du", i + 300)  -- offset differently to avoid conflicts
        table.insert(keyMappings, {
            key = char,
            mods = "CMD|CTRL|SHIFT",
            action = act.SendString(esc_code),
        })
    end

    return keyMappings
end

return macCommandToMeta()
