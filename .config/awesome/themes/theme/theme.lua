local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local beautiful = require("beautiful")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local themes_path = ".config/awesome/themes/"
local theme_path = themes_path.."theme/"
local icons_path = theme_path.."icons/"

local lain  = require("lain")
local markup = lain.util.markup

local theme = {}

theme.font          = "sans 8"
theme.battery_font  = "sans 9"

theme.bg_normal     = "#000000AA"
theme.bg_focus      = "#d42e26"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(6)
theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_focus  = "#d42e26"
theme.border_marked = "#91231c"

beautiful.tooltip_border_color = theme.border_focus
beautiful.tooltip_bg = theme.bg_normal
beautiful.tooltip_border_width = 1

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_bg_normal = "#ffff0000"
theme.menu_submenu_icon = icons_path.."submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the image to load
function load_icon(icon_name)
    return gears.color.recolor_image(icons_path..icon_name, theme.fg_normal)
end

theme.speaker_muted_icon = load_icon("speaker_muted.svg")
theme.speaker_off_icon = load_icon("speaker_off.svg")
theme.speaker_low_icon = load_icon("speaker_low.svg")
theme.speaker_medium_icon = load_icon("speaker_medium.svg")
theme.speaker_full_icon = load_icon("speaker_full.svg")

theme.ac_icon = load_icon("ac.svg")
theme.battery_critical_icon = load_icon("battery_critical.svg")
theme.battery_low_icon = load_icon("battery_low.svg")
theme.battery_medium_icon = load_icon("battery_medium.svg")
theme.battery_high_icon = load_icon("battery_high.svg")
theme.battery_full_icon = load_icon("battery_full.svg")

theme.battery_critical_charging_icon = load_icon("battery_critical_charging.svg")
theme.battery_low_charging_icon = load_icon("battery_low_charging.svg")
theme.battery_medium_charging_icon = load_icon("battery_medium_charging.svg")
theme.battery_high_charging_icon = load_icon("battery_high_charging.svg")
theme.battery_full_charging_icon = load_icon("battery_full_charging.svg")

theme.ethernet_icon = load_icon("ethernet.svg")
theme.ethernet_no_connection_icon = load_icon("ethernet_no_connection.svg")
theme.wifi_no_signal_icon = load_icon("wifi_no_signal.svg")
theme.wifi_low_icon = load_icon("wifi_low.svg")
theme.wifi_medium_icon = load_icon("wifi_medium.svg")
theme.wifi_full_icon = load_icon("wifi_full.svg")

--theme.wallpaper = theme_path.."wallpaper/background.png"
theme.wallpaper = nil

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Create a textclock widget
mytextclock = wibox.widget.textclock()
mytextclock.refresh = 5
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    },
    followtag = true
})

-- ALSA volume
theme.volume_icon = wibox.widget.imagebox(theme.speaker_off_icon)
theme.volume = lain.widget.alsabar {
    width = dpi(50), border_width = 0, ticks = false, ticks_size = dpi(5),
    notification_preset = { font = theme.font },
    settings = function()
        if volume_now.status == "off" then
            theme.volume_icon:set_image(theme.speaker_muted_icon)
        elseif tonumber(volume_now.level) == 0 then
            theme.volume_icon:set_image(theme.speaker_off_icon)
        elseif tonumber(volume_now.level) <= 25 then
            theme.volume_icon:set_image(theme.speaker_low_icon)
        elseif tonumber(volume_now.level) <= 50 then
            theme.volume_icon:set_image(theme.speaker_medium_icon)
        else
            theme.volume_icon:set_image(theme.speaker_full_icon)
        end
    end,
    colors = {
        background   = theme.bg_normal,
        mute         = "FF0000",
        unmute       = theme.fg_normal
    }
}
local volumewidget = wibox.container.margin(theme.volume_icon, dpi(2), dpi(2), dpi(2), dpi(2))

theme.volume.tooltip.wibox.fg = theme.fg_focus
local volumebg = wibox.container.background(theme.volume.bar, theme.fg_normal, gears.shape.rectangle)
local volumebarwidget = wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))

theme.volume.bar:buttons(awful.util.table.join (
    awful.button({}, 1, function()
        awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
    end)
))

-- Battery
theme.battery_icon = wibox.widget.imagebox(theme.battery_full_icon)
theme.battery = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                if bat_now.perc and tonumber(bat_now.perc) <= 15 then
                    theme.battery_icon:set_image(theme.battery_critical_charging_icon)
                elseif bat_now.perc and tonumber(bat_now.perc) <= 25 then
                    theme.battery_icon:set_image(theme.battery_low_charging_icon)
                elseif bat_now.perc and tonumber(bat_now.perc) <= 50 then
                    theme.battery_icon:set_image(theme.battery_medium_charging_icon)
                elseif bat_now.perc and tonumber(bat_now.perc) <= 75 then
                    theme.battery_icon:set_image(theme.battery_high_charging_icon)
                else
                    theme.battery_icon:set_image(theme.battery_full_charging_icon)
                end
            elseif bat_now.perc and tonumber(bat_now.perc) <= 15 then
                theme.battery_icon:set_image(theme.battery_critical_icon)
            elseif bat_now.perc and tonumber(bat_now.perc) <= 25 then
                theme.battery_icon:set_image(theme.battery_low_icon)
            elseif bat_now.perc and tonumber(bat_now.perc) <= 50 then
                theme.battery_icon:set_image(theme.battery_medium_icon)
            elseif bat_now.perc and tonumber(bat_now.perc) <= 75 then
                theme.battery_icon:set_image(theme.battery_high_icon)
            else
                theme.battery_icon:set_image(theme.battery_full_icon)
            end

            widget:set_markup(markup.font(theme.battery_font, bat_now.perc .. "%"))
        else
            theme.battery_icon:set_image(theme.ac_icon)
            widget:set_markup(markup.font(theme.battery_font, ""))
        end
    end,
    timeout = 5,
})
local batterywidget = wibox.container.margin(theme.battery_icon, dpi(2), dpi(2), dpi(2), dpi(2))

-- Net
theme.net_icon = wibox.widget.imagebox(theme.ethernet_no_connection_icon)
theme.net = lain.widget.net {
    notify = "off",
    wifi_state = "on",
    eth_state = "on",
    settings = function()
        for device_name,network_device in pairs(net_now.devices) do
            if network_device.ethernet then
                if network_device.state == "up" then
                    theme.net_icon:set_image(theme.ethernet_icon)

                    break
                else
                    theme.net_icon:set_image(theme.ethernet_no_connection_icon)
                end
            end

            if network_device.wifi then
                if network_device.state == "up" then
                    if network_device.signal < -83 then
                        theme.net_icon:set_image(theme.wifi_low_icon)
                    elseif network_device.signal < -70 then
                        theme.net_icon:set_image(theme.wifi_medium_icon)
                    elseif network_device.signal < -53 then
                        theme.net_icon:set_image(theme.wifi_full_icon)
                    else
                        theme.net_icon:set_image(theme.wifi_full_icon)
                    end

                    break
                else
                    theme.net_icon:set_image(theme.wifi_no_signal_icon)
                end
            end
        end
    end
} 
local netwidget = wibox.container.margin(theme.net_icon, dpi(2), dpi(2), dpi(2), dpi(2))

netwidget:connect_signal("button::press", function() awful.spawn(string.format("%s -e nmtui connect", awful.util.terminal)) end)

-- Misc
theme.separator = wibox.widget.textbox("   ")

-- 
function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Create tags for each screen
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons,
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

            mykeyboardlayout,

            wibox.widget.systray(),

            theme.separator,

            volumewidget,
            volumebarwidget,

            theme.separator,

            batterywidget,
            theme.battery.widget,

            theme.separator,

            netwidget,

            theme.separator,

            mytextclock,

            s.mylayoutbox,
        },
    }
end

return theme
