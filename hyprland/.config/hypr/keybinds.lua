local main_mod = "SUPER"
local resize_increment = 32
local num_workspaces = 10
local volume_increment = 5
local brightness_increment = 5

hl.bind(main_mod .. " + CTRL + ESCAPE", hl.dsp.exec_cmd(
    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Launch programs
local programs = require("programs")
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(programs.file_manager))
hl.bind(main_mod .. " + T", hl.dsp.exec_cmd(programs.terminal))
hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(programs.menu))
-- SHIFT TAB: rofi -show window

-- Window
hl.bind(main_mod .. " + C", hl.dsp.window.close())
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen({ }))

-- Window move
hl.bind(main_mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left", group_aware = true }))
hl.bind(main_mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down", group_aware = true }))
hl.bind(main_mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up", group_aware = true }))
hl.bind(main_mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right", group_aware = true }))

-- Window focus
hl.bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(main_mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + TAB", hl.dsp.window.cycle_next({ }))

-- Window resize
hl.bind(main_mod .. " + CTRL + H", hl.dsp.window.resize({ x = -resize_increment, y = 0, relative = true }))
hl.bind(main_mod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = -resize_increment, relative = true }))
hl.bind(main_mod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = resize_increment, relative = true }))
hl.bind(main_mod .. " + CTRL + L", hl.dsp.window.resize({ x = resize_increment, y = 0, relative = true }))

-- Workspace
for i = 1, num_workspaces do
    local key = i % num_workspaces
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Layout
hl.bind(main_mod .. " + M", hl.dsp.layout("addmaster"))
hl.bind(main_mod .. " + SHIFT + M", hl.dsp.layout("removemaster"))
hl.bind(main_mod .. " + CTRL + O", hl.dsp.layout("orientationcycle left center"))

-- Groups
hl.bind(main_mod .. " + G", hl.dsp.group.toggle({ }), { long_press = true })
hl.bind(main_mod .. " + G", hl.dsp.group.lock({ }))
hl.bind(main_mod .. " + A", hl.dsp.group.next({ }))
hl.bind(main_mod .. " + SHIFT + A", hl.dsp.group.prev({ }))

-- Move window/focus to next monitor
hl.bind(main_mod .. " + O", hl.dsp.focus({ monitor = "+1" }))
hl.bind(main_mod .. " + SHIFT + O", hl.dsp.window.move({ monitor = "+1" }))

-- Move/resize windows with main_mod + LMB/RMB and dragging
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume controls
hl.bind( "XF86AudioRaiseVolume", hl.dsp.exec_cmd(
    "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ " .. volume_increment .. "%+"
    ), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(
    "wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. volume_increment .."%-"
    ), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ), { locked = true, repeating = true })

-- Brightness controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(
    "brightnessctl -e4 -n2 set " .. brightness_increment .. "%+"
    ), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd(
    "brightnessctl -e4 -n2 set " .. brightness_increment .. "%-"
    ), { locked = true, repeating = true })

-- Media controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(
    "playerctl next"
    ), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(
    "playerctl play-pause"
    ), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(
    "playerctl play-pause"
    ), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(
    "playerctl previous"
    ), { locked = true })

