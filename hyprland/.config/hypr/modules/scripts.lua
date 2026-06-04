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

---lua.conf.drag_terminal
local StartX = 0
local StartY = 0
local IsDragging = false

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

return M
