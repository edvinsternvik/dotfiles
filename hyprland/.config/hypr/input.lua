hl.config({
    input = {
        kb_layout  = "us, se",
        kb_variant = "altgr-intl",
        kb_model   = "",
        kb_options = "caps:escape,grp:alt_shift_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
        },

        repeat_delay = 240,
        repeat_rate = 45,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
