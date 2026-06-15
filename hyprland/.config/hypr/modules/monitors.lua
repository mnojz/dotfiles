---- MONITORS ----

-- Set the initial state tracking variable
local is_144 = false


-- Define a helper function to apply the monitor config based on the state
local function apply_config()
    local eDP_mode = is_144 and "1920x1080@144" or "1920x1080@60"

    hl.monitor({
        output   = "eDP-1",
        mode     = eDP_mode,
        position = "auto",
        scale    = "1",
    })

    hl.monitor({
        output   = "HDMI-A-1",
        mode     = "preferred",
        position = "auto",
        scale    = "1",
        mirror   = "eDP-1",
    })
end

-- Run it once on startup to set your default (60Hz)
apply_config()

local function toggle_refresh_rate()
    is_144 = not is_144
    apply_config()
    local current_rate = is_144 and "144Hz" or "60Hz"
    hl.exec_cmd("notify-send 'Refresh Rate' '" .. current_rate .. "'")
end

hl.bind("XF86Tools", toggle_refresh_rate)

-- dynamic refreshrate based on power supply
local function get_power_state()
    local f = io.popen("cat /sys/class/power_supply/ADP1/online")
    local state = f:read("*l")
    f:close()
    return state
end

local function apply_refresh(state)
    if state == "1" then
        is_144 = false
        toggle_refresh_rate()
    elseif state == "0" then
        is_144 = true
        toggle_refresh_rate()
    end
end

local function check_and_update()
    local state = get_power_state()
    apply_refresh(state)
end

check_and_update()
