local M = {}

--              █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀             --
--              ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█             --

-------------------------------------------------------------------------------------------------------------
---                                 enable or disable touchpad                                            ---
-------------------------------------------------------------------------------------------------------------
-- touchpad variables
local touchpad_enabled = true
local TOUCHPAD_NAME = "elan0307:00-04f3:3282-touchpad"

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

-------------------------------------------------------------------------------------------------------------
---                                    spawn terminal under selection                                     ---
-------------------------------------------------------------------------------------------------------------
-- drag terminal variables

local StartX = 0
local StartY = 0
local IsDragging = false
local DragTimer = nil
local DragOverlayInstance = nil



-- Update the visual drag rectangle
local function updateDragOverlay()
    if not IsDragging then
        return
    end

    local cursor = hl.get_cursor_pos()

    if not cursor then
        return
    end

    local monitor = hl.get_monitor_at_cursor().position

    local x = cursor.x - monitor.x
    local y = cursor.y - monitor.y

    hl.exec_cmd(
        string.format(
            "id=$(qs list --all | awk '/^Instance / { id=$2; sub(/:$/, \"\", id) } /^  Shell ID: ambxst$/ { print id; exit }'); qs ipc -i \"$id\" call dragOverlay update %.0f %.0f",
            x,
            y
        )
    )
end


function M.dragStart()
    local cursor = hl.get_cursor_pos()

    if not cursor then
        return
    end

    local monitor = hl.get_monitor_at_cursor().position

    StartX = cursor.x - monitor.x
    StartY = cursor.y - monitor.y

    IsDragging = true

    hl.exec_cmd([[
    id=$(qs list --all | awk '/^Instance / { id=$2; sub(/:$/, "", id) } /^  Shell ID: ambxst$/ { print id; exit }')
    qs ipc -i "$id" call dragOverlay start ]] .. string.format("%.0f %.0f", StartX, StartY))

    -- Update the rectangle continuously while dragging
    if DragTimer then
        DragTimer:set_enabled(false)
    end

    DragTimer = hl.timer(
        updateDragOverlay,
        {
            timeout = 16,
            type = "repeat"
        }
    )
end

function M.dragEnd()
    if not IsDragging then
        return
    end

    IsDragging = false

    -- Stop the update timer
    if DragTimer then
        DragTimer:set_enabled(false)
        DragTimer = nil
    end

    local cursor = hl.get_cursor_pos()

    -- Always stop the overlay, even if cursor position can't be read
    hl.exec_cmd([[
        id=$(qs list --all | awk '/^Instance / { id=$2; sub(/:$/, "", id) } /^  Shell ID: ambxst$/ { print id; exit }')
        qs ipc -i "$id" call dragOverlay stop
    ]])

    if not cursor then
        return
    end

    -- Monitor position
    local monitor = hl.get_monitor_at_cursor().position

    -- Convert cursor to monitor-local coordinates
    local cursorX = cursor.x - monitor.x
    local cursorY = cursor.y - monitor.y

    -- Final terminal geometry
    local x = math.min(StartX, cursorX)
    local y = math.min(StartY, cursorY)
    local w = math.abs(StartX - cursorX)
    local h = math.abs(StartY - cursorY)

    -- Create Kitty
    hl.dispatch(
        hl.dsp.exec_cmd(
            "kitty",
            {
                float = true,
                move = { x, y },
                size = { w, h }
            }
        )
    )
end

-------------------------------------------------------------------------------------------------------------
---                                    toggle refresh rate                                                ---
-------------------------------------------------------------------------------------------------------------
-- refreshrate variables
local is_144 = false
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

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
return M
