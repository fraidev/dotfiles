-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- For example, changing the color scheme:
config.color_scheme = "Horizon Dark (base16)"
-- config.color_scheme = 'Humanoid dark (base16)'

config.colors = {
  -- The default text color
  foreground = '#E0E0E0',
  -- The default background color
  background = '#1F1E1E',
}


-- enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW"

config.window_decorations = "RESIZE"

config.window_padding = {
    left = 0,
    right = 0,
    top = 20,
    bottom = 0,
}

-- config.font = wezterm.font "Fira Code"
-- config.font = wezterm.font "FiraCode Nerd Font Mono"
-- config.font = wezterm.font "ComicMono NF"
-- config.font = wezterm.font "ComicShannsMono Nerd Font"
-- config.font = wezterm.font "JetBrainsMono Nerd Font"
-- config.font = wezterm.font "JetBrains Mono NL"
-- config.font = wezterm.font "JetBrains Mono"
-- config.font = wezterm.font "JetBrains Mono NF"
config.font = wezterm.font "Cascadia Mono"

local act = wezterm.action

-- font size
config.font_size = 18.0

config.keys = {
  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
}

-- and finally, return the configuration to wezterm
return config
