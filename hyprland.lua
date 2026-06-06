local config = Hyprland.config

-----------------
-- SOURCE FILE --
-----------------

require("~/.config/hypr/catppuccin-hyprland/themes/mocha")

-------------------
-- MY PROGRAMS ---
-------------------

local terminal      = "kitty"
local fileManager   = "yazi"
local menu          = "fuzzel"
local mainMod       = "SUPER"

----------------
-- MONITORS ---
----------------

-- Note: ",preferred,auto,1" is the absolute default behavior in Hyprland.
-- You don't need to declare it unless you are overriding it.
-- config.monitor = { ",preferred,auto,1" }

-----------------
-- AUTOSTART ---
-----------------

config["exec-once"] = {
	"nm-applet &",
	"waybar",
	"hyprpaper",
	"hypridle",
	"dunst &",
	"blueman-applet &",
	"clipse -listen",
	"hyprland-per-window-layout",
	"systemctl --user start xdg-desktop-portal-hyprland.service",
	"systemctl --user start hyprpolkitagent.service",
	[[dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-lavender-cursors'"]],
	"dconf write /org/gnome/desktop/interface/cursor-size 32",
}

-----------------------------
-- ENVIRONMENT VARIABLES ---
-----------------------------

config.env          = {
	{ "XCURSOR_SIZE",              "32" },
	{ "HYPRCURSOR_SIZE",           "32" },
	{ "LIBVA_DRIVER_NAME",         "nvidia" },
	{ "XDG_SESSION_TYPE",          "wayland" },
	{ "GBM_BACKEND",               "nvidia-drm" },
	{ "__GLX_VENDOR_LIBRARY_NAME", "nvidia" },
	{ "HYPRCURSOR_THEME",          "catppuccin-mocha-lavender-cursors" },
	{ "XCURSOR_THEME",             "catppuccin-mocha-lavender-cursors" },
}

-------------------------------
-- PLUGIN CONFIGURATION -------
-------------------------------

config.plugin       = {
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
config.general      = {
	gaps_in  = 0,
	gaps_out = 0,
	col      = {
		active_border   = "$mauve",
		inactive_border = "$surface0",
	},
}

-- Removed defaults: rounding=0, active_opacity=1.0, blur.enabled=true, blur.size=3, blur.passes=1, blur.vibrancy=0.1696
config.decoration   = {
	inactive_opacity = 0.90,
}

-- Removed defaults: animations block completely matched Hyprland defaults
config.animations   = {
	enabled = true,
}

config.dwindle      = {
	preserve_split = true,
}

-- Removed default: force_default_wallpaper=1
config.misc         = {
	disable_hyprland_logo = true,
}

-----------
-- INPUT --
-----------

-- Removed defaults: follow_mouse=1, sensitivity=0, touchpad.natural_scroll=false
config.input        = {
	kb_layout  = "us,ir",
	kb_options = "grp:win_space_toggle",
}

--------------------
-- KEYBINDINGS ---
--------------------

config.bind         = {
	-- Core binds
	{ mainMod,             "Q",                    "exec",                   terminal },
	{ mainMod,             "C",                    "killactive" },
	{ mainMod,             "M",                    "exit" },
	{ mainMod,             "E",                    "exec",                   fileManager },
	{ mainMod,             "F",                    "togglefloating" },
	{ mainMod,             "R",                    "exec",                   menu },
	{ mainMod,             "P",                    "pseudo" },
	{ mainMod,             "V",                    "exec",                   "kitty --class clipse -e clipse" },

	-- Move focus with mainMod + arrow keys
	{ mainMod,             "left",                 "movefocus",              "l" },
	{ mainMod,             "right",                "movefocus",              "r" },
	{ mainMod,             "up",                   "movefocus",              "u" },
	{ mainMod,             "down",                 "movefocus",              "d" },

	-- Special workspace (scratchpad)
	{ mainMod,             "S",                    "togglespecialworkspace", "magic" },
	{ mainMod .. " SHIFT", "S",                    "movetoworkspace",        "special:magic" },

	-- Scroll through existing workspaces with mainMod + scroll
	{ mainMod,             "mouse_down",           "workspace",              "e+1" },
	{ mainMod,             "mouse_up",             "workspace",              "e-1" },

	-- Volume control
	{ "",                  "XF86AudioRaiseVolume", "exec",                   "pamixer -i 5" },
	{ "",                  "XF86AudioLowerVolume", "exec",                   "pamixer -d 5" },
	{ "",                  "XF86AudioMute",        "exec",                   "pamixer -t" },

	-- Media keys
	{ "",                  "XF86AudioPlay",        "exec",                   "playerctl play-pause" },
	{ "",                  "XF86AudioPause",       "exec",                   "playerctl play-pause" },
	{ "",                  "XF86AudioNext",        "exec",                   "playerctl next" },
	{ "",                  "XF86AudioPrev",        "exec",                   "playerctl previous" },
}

-- Workspace binds generated via Lua loop (replaces 20 lines of repetitive config)
for i = 1, 9 do
	table.insert(config.bind, { mainMod, tostring(i), "workspace", tostring(i) })
	table.insert(config.bind, { mainMod .. " SHIFT", tostring(i), "movetoworkspace", tostring(i) })
end
table.insert(config.bind, { mainMod, "0", "workspace", "10" })
table.insert(config.bind, { mainMod .. " SHIFT", "0", "movetoworkspace", "10" })

-- Mouse bindings
config.bindm = {
	{ mainMod, "mouse:272", "movewindow" },
	{ mainMod, "mouse:273", "resizewindow" },
}

------------------------------
-- WINDOWS AND WORKSPACES ---
------------------------------

config.windowrule = {
	"match:class zen-twilight, match:title Picture-in-Picture, pin on",
	"match:class zen-twilight, match:title Picture-in-Picture, float on",
	"match:class zen-twilight, match:title Picture-in-Picture, persistent_size on",
	"match:class clipse, float on",
	"match:class clipse, size 642 652",
	"match:class clipse, center on",
	"match:class clipse, stay_focused on",
}
