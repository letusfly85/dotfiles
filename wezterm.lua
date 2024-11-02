local wezterm = require 'wezterm'

local scheme = wezterm.get_builtin_color_schemes()['Gruvbox Light']

config = {
  color_schemes = {
    -- Override the builtin Gruvbox Light scheme with our modification.
    ['Gruvbox Light'] = scheme,

    -- We can also give it a different name if we don't want to override
    -- the default
    ['Gruvbox Red'] = scheme,
  },
  -- color_scheme = 'Gruvbox Light',

  font_size = 20.0,
  use_ime = true,
  window_background_opacity = 0.9,
  macos_window_background_blur = 30,
  window_decorations = "RESIZE",
  show_tabs_in_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  },
  window_background_gradient = {
    colors = { "#1b1b25" },
  },
  show_new_tab_button_in_tab_bar = false,
  -- show_close_tab_button_in_tabs = false,
  colors = {
      tab_bar = {
      inactive_tab_edge = "none"
    }
  },
  font = wezterm.font('Cica', { weight = 'DemiBold' })
}

-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"
  local edge_background = "none"
  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end
  local edge_foreground = background
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)


return config
