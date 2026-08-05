---- AUTOSTART ----

hl.on("hyprland.start", function()
  hl.exec_cmd("sh -c 'ambxst >/dev/null 2>&1 &'")
  hl.exec_cmd("sh -c '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 >/dev/null 2>&1 &'")
  hl.exec_cmd("sh -c 'kdeconnect >/dev/null 2>&1 &'")
  hl.exec_cmd("sh -c 'kdeconnect-indicator >/dev/null 2>&1 &'")
end)
