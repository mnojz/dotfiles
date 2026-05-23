local M = {}

function M.refresh_rate()
    local MONITOR = "eDP-1"

    local handle = io.popen("hyprctl monitors | grep -A1 'Monitor " .. MONITOR .. "' | tail -n1")
    local output = handle:read("*a")
    handle:close()

    local rate = tonumber(output:match("@([0-9]+)%."))
    if not rate then rate = 60 end

    local new_rate = (rate >= 100) and 60 or 144

    hl.monitor({
        output = MONITOR,
        mode = "1920x1080@" .. new_rate,
        position = "0x0",
        scale = 1
    })

    os.execute("notify-send 'Refresh rate' '" .. new_rate .. "Hz'")
end

function M.touchpad_toggle()
    hl.notification.create({
        text = "touchpad_toggle",
        icon = "ok",
        timeout = 1000,
    })
end

return M
