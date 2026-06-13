local programs = {
    terminal     = "alacritty",
    file_manager = "thunar",
    menu         = "rofi -show combi -modi p:\"~/.config/rofi/powermenu/rofi-power-menu --confirm=''\" -combi-modes \"drun,p\"",
    browser      = "firefox",
    notification = "dunst",
}

local config_dir = debug.getinfo(1).source:match("@?(.*)/")
hl.on("hyprland.start", function ()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-gtk")
    hl.exec_cmd(config_dir .. "/wallpaperscript")
    hl.exec_cmd(programs.notification)
    hl.exec_cmd("hypridle")
    hl.exec_cmd("waybar")
end)

return programs
