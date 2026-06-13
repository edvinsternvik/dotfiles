local red           = "rgba(FF3333EE)"
local red_dark      = "rgba(960000EE)"
local shadow        = "rgba(1A1A1AEE)"
local gray          = "rgba(383838AA)"
local gray_light    = "rgba(CDD6F4AA)"
local white         = "rgba(FFFFFFFF)"
local gray_lighter  = "rgba(EFF8F6AA)"
local white_dark    = "rgba(888888AA)"

hl.config({
    general = { layout = "master" },
    master = {
        new_status = "slave",
        slave_count_for_center_master = 0,
    },
})

hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,

        border_size = 1,

        col = {
            active_border   = { colors = {red, red_dark}, angle = 45 },
            inactive_border = gray,
        },
    },

    decoration = {
        rounding       = 4,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = shadow,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    group = {
        col = {
            border_active = { colors = {red, red_dark}, angle = 45 },
            border_inactive = gray,
            border_locked_active = { colors = {red, red_dark}, angle = 45 },
            border_locked_inactive = gray,
        },
        groupbar = {
            font_size = 12,
            height = 16,
            indicator_height = 3,
            text_offset = 2,
            text_padding = 8,

            text_color = white,
            text_color_inactive = gray_lighter,
            text_color_locked_active = white,
            text_color_locked_inactive = gray_light,

            col = {
                active = red,
                inactive = white_dark,
                locked_active = red_dark,
                locked_inactive = gray,
            },
        },
    },
})

hl.config({animations = { enabled = true } })
hl.animation({ leaf = "global", enabled = true, speed = 0.4, bezier = "default" })

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})
