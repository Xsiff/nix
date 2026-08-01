local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- colors
config.color_scheme = "rose-pine-moon"

-- font
config.font = wezterm.font("Hack Nerd Font", { weight = "Regular" })
config.font_size = 14.0

--opacity
config.window_background_opacity = 0.90

--other
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- Keep macOS input-method support enabled. WezTerm's native Dictation path
-- does not currently accept Apple's Dictation text reliably.
config.use_ime = true

return config
