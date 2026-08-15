local theme      = require("rose-pine-hyprland/dist/rose-pine-moon")

local terminal    = "kitty"
local fileManager = "yazi"
local menu        = "fuzzel"
local mainMod     = "SUPER"

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-----------------
-- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet &")
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("dunst &")
	hl.exec_cmd("blueman-applet &")
	hl.exec_cmd("clipse -listen")
	hl.exec_cmd("hyprland-per-window-layout")
	hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland.service")
	hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
	hl.exec_cmd([[dconf write /org/gnome/desktop/interface/cursor-theme "'BreezeX-RosePine-Linux'"]])
	hl.exec_cmd("dconf write /org/gnome/desktop/interface/cursor-size 32")
end)

hl.env    = {
	{ "XCURSOR_SIZE",              "32" },
	{ "HYPRCURSOR_SIZE",           "32" },
	{ "LIBVA_DRIVER_NAME",         "nvidia" },
	{ "XDG_SESSION_TYPE",          "wayland" },
	{ "GBM_BACKEND",               "nvidia-drm" },
	{ "__GLX_VENDOR_LIBRARY_NAME", "nvidia" },
	{ "HYPRCURSOR_THEME",          "rose-pine-hyprcursor" },
	{ "XCURSOR_THEME",             "BreezeX-RosePine-Linux" },
}

-------------------------------
-- PLUGIN CONFIGURATION -------
-------------------------------

hl.plugin = {
	hyprexpo = {
		columns          = 3,
		gap_size         = 5,
		bg_col           = "rgb(111111)",
		workspace_method = "center current",
	},
	hyprtrails = {
		color = "rgba(ffaa00ff)",
	},
}

---------------------
-- LOOK AND FEEL ---
---------------------

-- Removed defaults: border_size=1, resize_on_border=false, allow_tearing=false, layout="dwindle"
hl.config({
	general    = {
		gaps_in     = 0,
		gaps_out    = 0,
		border_size = 1,
		col         = {
			active_border = {
				colors = {
					theme.rose,
					theme.pine,
					theme.love,
					theme.iris
				},
				angle = 90
			},
			inactive_border = theme.muted,
		},
		layout      = "dwindle"
	},
	dwindle    = {
		preserve_split = true,
	},
	decoration = {
		inactive_opacity = 0.90,
		rounding = 0,
		active_opacity = 1,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
	},
	misc       = {
		disable_hyprland_logo = true,
	},
	input      = {
		kb_layout    = "us,ir",
		kb_options   = "grp:win_space_toggle",
		follow_mouse = 1,
		sensitivity  = 0,
	},
})

-- Removed defaults: animations block completely matched Hyprland defaults

hl.dwindle = {
	preserve_split = true,
}

-- Removed default: force_default_wallpaper=1

-----------
-- INPUT --
-----------

-- Removed defaults: follow_mouse=1, sensitivity=0, touchpad.natural_scroll=false

--------------------
-- KEYBINDINGS ---
--------------------

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("kitty --class clipse -e clipse"))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Workspace binds generated via Lua loop (replaces 20 lines of repetitive config)
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------------------
-- WINDOWS AND WORKSPACES ---
------------------------------
hl.window_rule({
	name            = "Zen/Firefox PiP",
	match           = {
		title = "^.*Picture-in-Picture.*$",
	},
	pin             = true,
	float           = true,
	persistent_size = true,
})
hl.window_rule({
	name         = "Clipse",
	match        = {
		class = "clipse",
	},
	float        = true,
	center       = true,
	size         = "600 700",
	stay_focused = true,
})

hl.window_rule({
	name           = "suppress-maximize-events",
	match          = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name     = "fix-xwayland-drags",
	match    = {
		class      = "^$",
		title      = "^$",
		xwayland   = true,
		float      = true,
		fullscreen = false,
		pin        = false,
	},

	no_focus = true,
})
