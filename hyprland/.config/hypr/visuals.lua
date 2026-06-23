---@module 'hl'

local colors = require("colors")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 4,
        col = {
          active_border = {
            colors = {colors.FG, colors.BG, colors.FG},
            angle = 90,
          },
          inactive_border = colors.BG,
        },
        -- no_border_on_floating = true,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
})

hl.config({
    decoration = {
        rounding = 12,
        -- active_opacity = 0.90
        -- inactive_opacity = 0.80
        -- drop_shadow = true
        -- shadow_range = 4
        -- shadow_render_power = 2
        -- shadow_ignore_window = true
        -- col.shadow = rgba(1a1a1aee)
        blur = {
            enabled = true,
            size = 6,
            passes = 1,
            ignore_opacity = true,
            vibrancy = 0.1696,
        },
        shadow = {
            enabled = true,
            range = 14,
            render_power = 2,
            color = "0xee1a1a1a",
            color_inactive = "0xee1a1a1a",
            scale = 1.0,
        },
    },
})

hl.config({
    animations = {
        enabled = true,
        --animation = borderangle, 1, 180, liner, loop #used by rainbow borders and rotating colors
        -- animations for -git or version >0.42.0
    },
})


hl.config({
    dwindle = {
        -- pseudotile = true
        preserve_split = true,
    },
})

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

-- layerrule = blur 1, match:namespace ^(logout_dialog)$

hl.window_rule({
    match = {
        class = "^(.*)$",
    },
    opacity = "0.95 0.8",
})

hl.window_rule({
    match = {
        class = "^(google-chrome)$",
    },
    opacity = "1 0.92",
})

hl.window_rule({
    match = {
        class = "firefox",
    },
    opacity = "1 0.92",
})

hl.window_rule({
    match = {
        class = "^(org.godotengine.Editor)$",
    },
    opacity = "1 0.92",
})

hl.window_rule({
    match = {
        class = "kitty",
    },
    opacity = "1 0.9",
})

hl.window_rule({
    match = {
        class = "^(org.gnome.Totem)$",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        class = "luanti",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        class = "virt-manager",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        class = "org.gnome.Loupe",
    },
    opacity = "1 1",
})
