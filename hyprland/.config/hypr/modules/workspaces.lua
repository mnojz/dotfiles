---- WINDOWS AND WORKSPACES ----

local suppressMaximizeRule = hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- make calculator floating
hl.window_rule({
    name  = "gnome-calculator",
    match = { class = "org.gnome.Calculator" },
    move  = "monitor_w-450 80",
    float = true,
})

-- make audio player floating
hl.window_rule({
    name   = "audio player",
    match  = { class = "org.gnome.Decibels" },
    center = true,
    size   = "480 260",
    float  = true,
})

--make file picker floating
hl.window_rule({
    name   = "portal file dialogs",
    match  = { class = "^xdg-desktop-portal-.*$" },
    center = true,
    size   = "800 550",
    float  = true,
})

--make kdenlive splash screen floating
hl.window_rule({
    name   = "kdenlive splash screen",
    match  = {
        class = "org.kde.kdenlive",
        title = "^Kdenlive$"
    },
    center = true,
    float  = true,
})

-- make app manager floating
hl.window_rule({
    name   = "app manager",
    match  = { class = "com.github.AppManager" },
    center = true,
    float  = true,
})

-- make kdeconnect floating
hl.window_rule({
    name   = "kdeconnect",
    match  = { class = "org.kde.kdeconnect.app" },
    center = true,
    float  = true,
    size   = "600 460",
})

-- make mpv floating
hl.window_rule({
    name   = "mpv",
    match  = { class = "mpv" },
    center = true,
    float  = true,
})
