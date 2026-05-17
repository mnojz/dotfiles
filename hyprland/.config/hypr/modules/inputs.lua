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
            scroll_factor        = 1.5,
            disable_while_typing = true,
        },
    },
})

hl.device({
    name          = "elan0307:00-04f3:3282-touchpad",
    accel_profile = "flat",
    sensitivity   = -0.5,
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", mods = "ALT", action = "close" })
hl.gesture({ fingers = 3, direction = "up", mods = "SUPER", scale = 1.5, action = "fullscreen" })
