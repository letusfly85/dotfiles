local wezterm = require 'wezterm'


local scheme = wezterm.get_builtin_color_schemes()['Gruvbox Light']

config = {
  background = {
    {
	source = { File = "/Users/letusfly85/.config/wezterm/scala.png" },
        attachment = { Parallax = 0.05 },
        opacity = 1.0, -- 透明度
        vertical_align = "Middle", -- 垂直方向の画像位置
        horizontal_align = "Right", -- 水平方向の画像位置
        horizontal_offset = "0px", -- 水平方向のオフセット
        repeat_x = "NoRepeat", -- 画像をx方向に繰り返すか
        repeat_y = "NoRepeat", -- 画像をy方向に繰り返すか
        width = "512px", -- 画像の幅 (%指定も可能)
        height = "512px" -- 画像の高さ (%指定も可能),
    },
    {
      source = {
       Gradient = {
         colors = { "#090a0d", "#212326" }, -- グラデーションのカラーセット
         orientation = {
           Linear = { angle = -50.0 }, -- グラデーションの方向と角度
         },
       },
     },
     opacity = 0.8, -- 透明度
     width = "100%", -- 幅
     height = "100%" -- 高さ
    }
  },
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
  window_background_opacity = 0.8,
  macos_window_background_blur = 30,

  window_background_gradient = {
    colors = { "#000000", "#212326", "#0e1012", "#212326","#000000" },  
    orientation = "Vertical",
    blend = "LinearRgb",
  },
  -- window_background_gradient = {
  --  colors = { "#1b1b25" },
  -- },

  window_decorations = "RESIZE",
  show_tabs_in_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
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
