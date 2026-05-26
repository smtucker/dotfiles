
---@module 'hl'

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0.25, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            tap_to_click = true,          -- Note: hyphens converted to underscores
            disable_while_typing = true,
            clickfinger_behavior = true,
            -- natural_scroll = true,
        },

        tablet = {
            output = "eDP-1",
            transform = 0,
        },
    },

    gestures = {
        workspace_swipe_cancel_ratio = 0.15,
    }

    -- TODO: Is there a new version of this?
    -- windowrule = { "suppress_event maximize, match:class ^(.*)$" }
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

-- hl.device({
--     name = "wacom-hid-5362-pen",
--     transform = 0,
--     output = "eDP-1",
--     region_size = "1680, 1050",
--     active_area_size = "301.59, 188.5",
-- })

-- hl.device({ name = "elan327e:00-04f3:327e-touchpad" })
-- hl.device({ name = "elan327e:00-04f3:327e-mouse" })
-- hl.device({ name = "wacom-hid-5362-finger" })

hl.device({
    name = "wacom-hid-5362-pen",
    transform = 0,
    output = "eDP-1",
    region_size = { 1680, 1050},
    active_area_size = { 301.59, 188.5 },
    -- pointer_accel_profile = "none",
    -- disable_internal_mouse = true,
})
