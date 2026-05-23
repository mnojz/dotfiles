local M = {}

function M.touchpad_toggle()
    hl.notification.create({
        text = "touchpad_toggle",
        icon = "ok",
        timeout = 1000,
    })
end

return M
