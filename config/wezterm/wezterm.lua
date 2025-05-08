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
-- config.color_scheme = "Doom One"
-- config.color_scheme = "VSCodeDark+ (Gogh)"
-- config.color_scheme = 'Humanoid dark (base16)'

config.colors = {
    -- The default text color
    -- foreground = '#E0E0E0',
    -- The default background color
    background = "#1F1E1E",
}

-- config.colors = {
--   -- The default text color
--   -- foreground = '#E0E0E0',
--   -- The default background color
--   background = '#292c33',
--   -- background = '#292C2D',
-- }

-- enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW"

config.window_decorations = "RESIZE"
config.cursor_blink_rate = 500

config.window_padding = {
    left = 0,
    right = 0,
    top = 20,
    bottom = 0
}

-- config.font = wezterm.font "Fira Code"
-- config.font = wezterm.font "FiraCode Nerd Font Mono"
-- config.font = wezterm.font "ComicMono NF"
-- https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/ComicShannsMono/ComicShannsMonoNerdFontPropo-Regular.otf
-- config.font = wezterm.font "ComicShannsMono Nerd Font Propo"
-- config.font = wezterm.font "JetBrainsMono Nerd Font"
-- config.font = wezterm.font "JetBrains Mono NL"
-- config.font = wezterm.font "JetBrains Mono"
-- config.font = wezterm.font "JetBrains Mono NF"
-- config.font = wezterm.font "Cascadia Mono"
-- config.font = wezterm.font "Comic Neue"
config.font = wezterm.font "Comic Code Ligatures"

-- config.font = wezterm.font "cascadia mono"
-- config.font = wezterm.font "Comic Code Ligatures SemiBold"
-- config.font = wezterm.font "Comic Code Ligatures UltraLight"
-- config.font = wezterm.font "Comic Code Ligatures Thin"
-- config.font = wezterm.font "Comic Code Ligatures Light"
config.enable_kitty_keyboard = true

local act = wezterm.action

-- font size
config.font_size = 18.0

config.keys = {
    {key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1)},
    {key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1)}
}

-- and finally, return the configuration to wezterm
return config
