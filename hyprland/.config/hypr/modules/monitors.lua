---- MONITORS ----

local refresh = "60.32"

local f = io.open("/sys/class/power_supply/ADP1/online", "r")
if f then
    local online = f:read("*l")
    f:close()

    if online == "1" then
        refresh = "144.42"
        os.execute('notify-send "Power" "Switched to 144 Hz"')
    else
        refresh = "60.32"
        os.execute('notify-send "Power" "Switched to 60 Hz"')
    end
end

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@" .. refresh,
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