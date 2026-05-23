---- importing modules ----
require("modules.autostart")
require("modules.inputs")
require("modules.lookandfeel")
require("modules.monitors")
require("modules.variables")
require("modules.workspaces")
require("modules.scripts")




---- MY PROGRAMS ----
local terminal    = "kitty"
local fileManager = "dolphin"


---- KEYBINDINGS ----
local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("xdg-open https://"))
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))

---- custom keybinds for ambxst ----
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a --notify --disable-preview --scale=10 --radius=40"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("ambxst run screenrecord"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("ambxst run screenshot"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("ambxst run lens"))
hl.bind(mainMod .. " + Super_L", hl.dsp.exec_cmd("ambxst run dashboard"))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("ambxst run powermenu"))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd("ambxst run emoji"))
hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd("ambxst run wallpapers"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("ambxst run lockscreen"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("ambxst run clipboard"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("ambxst run assistant"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("ambxst run tools"))

hl.bind("ALT + SPACE", hl.dsp.exec_cmd("ambxst run launcher"))

---- move focus with mainmod + arrow keys ----
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

---- move windows with mainmod + shift + arrow keys ----
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- special workspace (scratchpad)
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("ALT + PERIOD", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("ALT + COMMA", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- macro bindings for script
local touchpad_toggle = require("modules.scripts").touchpad_toggle
hl.bind(mainMod .. " + CTRL + F24", touchpad_toggle)

-- open hyprland config in code editor
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("cd ~/.config/hypr && kitty nvim hyprland.lua"))
