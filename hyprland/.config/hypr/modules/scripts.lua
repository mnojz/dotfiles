local M = {}

-- refreshrate variables
local is_144 = false
-- touchpad variables
local touchpad_enabled = true
local TOUCHPAD_NAME = "elan0307:00-04f3:3282-touchpad"
-- drag perminal variables
local StartX = 0
local StartY = 0
local IsDragging = false

-- enable/disable touchpad
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

---lua.conf.drag_terminal
function M.dragStart()
    local cursor = hl.get_cursor_pos()
    if not cursor then
        return
    end

    StartX = cursor.x
    StartY = cursor.y
    IsDragging = true
end

function M.dragEnd()
    if not IsDragging then
        return
    end
    IsDragging = false

    local cursor = hl.get_cursor_pos()
    if not cursor then
        return
    end

    local monitor = hl.get_monitor_at_cursor().position
    local x = math.min(StartX, cursor.x) - monitor.x
    local y = math.min(StartY, cursor.y) - monitor.y
    local w = math.abs(StartX - cursor.x)
    local h = math.abs(StartY - cursor.y)

    hl.dispatch(hl.dsp.exec_cmd("kitty", { float = true, move = { x, y }, size = { w, h } }))
end

-- dynamic power profiles with dynamic refreshrate
function M.toggle_refresh_rate()
    is_144 = not is_144
    local eDP_mode = is_144 and "1920x1080@144" or "1920x1080@60"
    hl.monitor({
        output   = "eDP-1",
        mode     = eDP_mode,
        position = "auto",
        scale    = "1",
    })
    local current_rate = is_144 and "144Hz" or "60Hz"
    hl.exec_cmd("notify-send 'Refresh Rate' '" .. current_rate .. "'")
end

return M
