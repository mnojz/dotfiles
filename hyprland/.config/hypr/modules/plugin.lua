-- .config/hypr/hyprland.lua
hl.config({
    plugin = {
        scrolloverview = {
            gesture_distance = 200, -- how far is the "max" for the gesture
            scale = 0.5,            -- preferred overview scale
            workspace_gap = 20,
            layout = "vertical",    -- vertical or horizontal
            wallpaper = 0,          -- 0: global only, 1: per-workspace only, 2: both
            blur = true,            -- blur only the main overview wallpaper

            shadow = {
                enabled = false,
                range = 50,
                render_power = 3,
                color = 0xee1a1a1a,
            },
        },
    },
})
