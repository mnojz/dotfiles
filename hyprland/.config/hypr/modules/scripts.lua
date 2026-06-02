local M = {}

-- Track the touchpad state right in memory
local touchpad_enabled = true
local TOUCHPAD_NAME = "elan0307:00-04f3:3282-touchpad"

function M.touchpad_toggle()
    -- Flip the boolean state
    touchpad_enabled = not touchpad_enabled

    -- Dynamically update the device setting inside Hyprland
    hl.device({
        name = TOUCHPAD_NAME,
        enabled = touchpad_enabled,
    })

    -- Send a sleek native notification
    local status_text = touchpad_enabled and "enabled" or "disabled"
    hl.exec_cmd("notify-send 'Touchpad' '" .. status_text .. "'")
end

-- Minimize window to special workspace
function M.minimize()
    hl.dispatch(
        hl.dsp.window.move({ workspace = "special:magic" })
    )
    hl.dispatch(
        hl.dsp.workspace.toggle_special("magic")
    )

    hl.exec_cmd("notify-send 'Minimized' 'moved to special workspace'")
end

return M
