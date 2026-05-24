---- INPUT ----
hl.config({
    input = {
        kb_layout          = "us",
        follow_mouse       = 1,
        sensitivity        = 0,
        accel_profile      = "flat",
        numlock_by_default = true,

        touchpad           = {
            natural_scroll       = true,
            scroll_factor        = 0.5,
            disable_while_typing = true,
        },
    },
})

hl.device({
    name          = "elan0307:00-04f3:3282-touchpad",
    accel_profile = "flat",
    sensitivity   = 0.5,
})

-- gestures

local function ctrlTab()
    hl.exec_cmd("wtype -M ctrl -k tab -m ctrl")
end

local function ctrlShiftTab()
    hl.exec_cmd("wtype -M ctrl -M shift -k tab -m shift -m ctrl")
end

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.gesture({ fingers = 3, direction = "down", action = ctrlTab })
hl.gesture({ fingers = 3, direction = "up", action = ctrlShiftTab })
