---@module 'hl'

-- Sets "Windows" key as main modifier
local mainMod = "SUPER"

-- Core Window Management
hl.bind("ALT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind("ALT + T", hl.dsp.exec_cmd("uwsm app -- thunar"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("ALT + R", hl.dsp.exec_cmd("uwsm app -- ~/.config/rofi/drun/run.sh"))
hl.bind("ALT + S", hl.dsp.exec_cmd("uwsm app -- ~/.config/rofi/boring/boring.sh"))
hl.bind("ALT + C", hl.dsp.exec_cmd("uwsm app -- ~/.config/rofi/run/run.sh"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind("ALT + grave", hl.dsp.exec_cmd("uwsm app -- kitty"))

-- System / Utilities
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("wlogout -b 5"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/rofi/wallpaper/wallpaper.sh"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("~/.config/rofi/clipboard/clipboard.sh"))
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/Screenshot-$(date +%Y-%m-%d-%H%M%S).png'))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.local/bin/rotate-screen"))

-- Hardware Controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + F", hl.dsp.window.fullscreen())
hl.bind("SHIFT + ALT + F", hl.dsp.window.fullscreen())

-- Switch workspace with ALT + [0-9] (Fixed: Workspace values as Strings)
hl.bind("ALT + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("ALT + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("ALT + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("ALT + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("ALT + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("ALT + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("ALT + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("ALT + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("ALT + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("ALT + 0", hl.dsp.focus({ workspace = "10" }))

-- Move active window to a workspace with SHIFT + ALT + [0-9] (Fixed: Workspace values as Strings)
hl.bind("SHIFT + ALT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SHIFT + ALT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SHIFT + ALT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SHIFT + ALT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SHIFT + ALT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SHIFT + ALT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SHIFT + ALT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SHIFT + ALT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("SHIFT + ALT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind("SHIFT + ALT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
