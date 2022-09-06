 local theme_assets = require("beautiful.theme_assets")
 local xresources = require("beautiful.xresources")
 local dpi = xresources.apply_dpi
 
 local gfs = require("gears.filesystem")
 local gears = require("gears")
 local awful = require("awful")
 local wibox = require("wibox")
 local themes_path = "~/.config/awesome/themes/"
 local theme_path = themes_path.."theme/"
 local icons_path = theme_path.."icons/"
 
 local lain  = require("lain")
 local markup = lain.util.markup
 
local theme = {}
 
 theme.font          = "sans 8"
 
 theme.bg_normal     = "#222222"
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
 theme.vol_mute_icon = icons_path.."vol_mute.png"
 theme.vol_no_icon = icons_path.."vol_no.png"
 theme.vol_low_icon = icons_path.."vol_low.png"
 theme.vol_full_icon = icons_path.."vol.png"
 
 theme.bat_ac_icon = icons_path.."ac.png"
 theme.bat_empty_icon = icons_path.."battery_empty.png"
 theme.bat_low_icon = icons_path.."battery_low.png"
 theme.bat_full_icon = icons_path.."battery.png"
 
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
 local month_calendar = awful.widget.calendar_popup.month({
     margin = 8,
     bg = "#282a36aa"
 })
 month_calendar:attach(mytextclock, "tr")
 
 
 -- ALSA volume
 local volume_icon_widget = wibox.widget.imagebox(theme.vol_mute_icon)
 theme.volume = lain.widget.alsa({
     settings = function()
         if volume_now.status == "off" then
             volume_icon_widget:set_image(theme.vol_mute_icon)
         elseif tonumber(volume_now.level) == 0 then
             volume_icon_widget:set_image(theme.vol_no_icon)
         elseif tonumber(volume_now.level) <= 50 then
             volume_icon_widget:set_image(theme.vol_low_icon)
         else
             volume_icon_widget:set_image(theme.vol_full_icon)
         end
 
         widget:set_markup(markup.font(theme.font, "" .. volume_now.level .. "%    "))
     end
 })
 
 -- Battery
 local battery_icon_widget = wibox.widget.imagebox(theme.bat_full_icon)
 theme.battery = lain.widget.bat({
     settings = function()
         if bat_now.status and bat_now.status ~= "N/A" then
             if bat_now.ac_status == 1 then
                 widget:set_markup(markup.font(theme.font, " AC "))
                 battery_icon_widget:set_image(theme.bat_ac_icon)
                 return
             elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                 battery_icon_widget:set_image(theme.bat_empty_icon)
             elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                 battery_icon_widget:set_image(theme.bat_low_icon)
             else
                 battery_icon_widget:set_image(theme.bat_full_icon)
             end
             widget:set_markup(markup.font(theme.font, "" .. bat_now.perc .. "%    "))
         else
             widget:set_markup()
             battery_icon_widget:set_image(theme.bat_full_icon)
         end
     end,
     timeout = 5,
 })
 
 
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
         buttons = taglist_buttons
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
 
             volume_icon_widget,
             theme.volume.widget,
 
             battery_icon_widget,
             theme.battery,
 
             mytextclock,
 
             s.mylayoutbox,
         },
     }
 end
 
return theme
