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

local region = {}

local function to_number_pos(pos)
    if not pos then return nil end
    local x = tonumber(pos.x)
    local y = tonumber(pos.y)
    if not x or not y then return nil end
    return { x = x, y = y }
end

local function normalize_region(p1, p2)
    return {
        x = math.floor(math.min(p1.x, p2.x)),
        y = math.floor(math.min(p1.y, p2.y)),
        w = math.floor(math.max(p1.x, p2.x) - math.min(p1.x, p2.x)),
        h = math.floor(math.max(p1.y, p2.y) - math.min(p1.y, p2.y)),
    }
end

function M.finish()
    local action = function(r) hl.exec_cmd("kitty", { float = true, move = { r.x, r.y }, size = { r.w, r.h } }) end
    if type(action) ~= "function" then
        region.start = nil
        return
    end

    local start = region.start
    region.start = nil
    if not start then return end
    local stop = to_number_pos(hl.get_cursor_pos())
    if not stop then return end
    local r = normalize_region(start, stop)
    if not r and r.w > 0 and r.h > 0 then return end
    action(r)
end

function M.drag_terminal()
    local key = "SUPER + ALT + mouse:272"
    hl.bind(key, function() region.start = to_number_pos(hl.get_cursor_pos()) end, { mouse = true })
    hl.bind(key, function() region.start = nil end, { mouse = true, click = true })
    hl.bind(key, function() M.finish() end, { mouse = true, drag = true })
end

return M
