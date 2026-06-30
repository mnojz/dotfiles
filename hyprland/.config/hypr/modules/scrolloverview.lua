-- hyprland.lua
hl.define_submap("scrolloverview", function()
    hl.bind("left", hl.plugin.scrolloverview.navigate("left"))
    hl.bind("right", hl.plugin.scrolloverview.navigate("right"))
    hl.bind("up", hl.plugin.scrolloverview.navigate("up"))
    hl.bind("down", hl.plugin.scrolloverview.navigate("down"))
    hl.bind("return", hl.plugin.scrolloverview.overview("select"))
    hl.bind("escape", hl.plugin.scrolloverview.overview("off"))
    hl.bind("mouse:272", function()
        -- Select the clicked window, or just the workspace if no window was clicked, then close the overview. This is the default behaviour if submap is not defined.
        hl.plugin.scrolloverview.overview("select")
        hl.plugin.scrolloverview.window("select")
        hl.plugin.scrolloverview.overview("off")
    end, { mouse = true })
    hl.bind("mouse:274", hl.plugin.scrolloverview.window("close"), { mouse = true })
end)

-- Example Hyprland bind that keeps working inside the submap:
for i = 1, 10 do
    local key = i % 10
    hl.bind("ALT + " .. key, hl.dsp.focus({ workspace = i }), { submap_universal = true })
end


-- hyprland.lua
hl.plugin.scrolloverview.gesture({ fingers = 3, direction = "vertical" })
hl.plugin.scrolloverview.gesture({ fingers = 4, direction = "vertical", mod = "SUPER", scale = 1.5 })
hl.plugin.scrolloverview.gesture({ fingers = 4, direction = "vertical", disable_inhibit = true })
hl.plugin.scrolloverview.gesture({ fingers = 3, direction = "vertical", action = "unset" })
