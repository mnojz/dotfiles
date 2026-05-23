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
