local wezterm = require 'wezterm'


-- 宇宙火星風ファンタジーサイバーパンクテーマ
local scheme = wezterm.get_builtin_color_schemes()['Gruvbox Light']

config = {
  background = {
    {
	source = { File = "/Users/letusfly85/work/wonder-soft/dotfiles/mars.png" },
        attachment = "Fixed", -- 画像を固定位置に配置（ウィンドウサイズに応じて見える範囲が変わる）
        opacity = 0.55, -- 透明度
        vertical_align = "Middle", -- 垂直方向の画像位置
        horizontal_align = "Center", -- 水平方向の画像位置
        horizontal_offset = "0px", -- 水平方向のオフセット
        repeat_x = "NoRepeat", -- 画像をx方向に繰り返すか
        repeat_y = "NoRepeat", -- 画像をy方向に繰り返すか
        height = "100%" -- 高さだけ指定してアスペクト比を維持（球体が歪まない）
    },
    {
      source = {
       Gradient = {
         colors = { "#000814", "#000a14" }, -- 黒めで少しだけ青み
         orientation = {
           Linear = { angle = -50.0 }, -- グラデーションの方向と角度
         },
       },
     },
     opacity = 0.45, -- 黒めのオーバーレイ
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
  -- カスタムカラースキームを定義
  colors = {
    foreground = "#E6D5B8",
    background = "#0A0A0A",
    
    cursor_bg = "#FFD700",
    cursor_fg = "#0A0A0A",
    cursor_border = "#FF6600",
    
    selection_fg = "#0A0A0A",
    selection_bg = "#00FFFF",
    
    -- ANSIカラー（宇宙火星風ファンタジーサイバーパンク）
    ansi = {
      "#0A0A0A", -- 黒（深宇宙）
      "#B8460E", -- 赤（暗い火星の赤）
      "#6B8E23", -- 緑（暗いファンタジーの自然）
      "#DAA520", -- 黄色（暗いゴールド）
      "#2E4BC6", -- 青（暗いサイバーブルー）
      "#7A4FBF", -- マゼンタ（暗いネオンパープル）
      "#008B8B", -- シアン（暗いサイバーシアン）
      "#C0A080", -- 白（暗い砂色）
    },
    brights = {
      "#8B4513", -- 明るい黒（赤茶色）
      "#FF6600", -- 明るい赤（エレクトリックオレンジ）
      "#ADFF2F", -- 明るい緑（ネオングリーン）
      "#FFFF00", -- 明るい黄色（ネオンイエロー）
      "#00BFFF", -- 明るい青（ディープスカイブルー）
      "#DA70D6", -- 明るいマゼンタ（オーキッド）
      "#00FFFF", -- 明るいシアン（アクア）
      "#FFFAF0", -- 明るい白（フローラルホワイト）
    },
  },

  font_size = 20.0,
  use_ime = true,
  window_background_opacity = 0.70,
  macos_window_background_blur = 40,

  window_background_gradient = {
    colors = { "#000000", "#0A0A0A", "#1A0F0A", "#2D1B0E", "#4A2C1A" },  
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
  local background = "#2D1B0E" -- 暗い火星の土壌
  local foreground = "#C0A080"
  local edge_background = "none"
  if tab.is_active then
    background = "#4A2C1A" -- 暗い火星表面
    foreground = "#00FFFF" -- サイバーシアン（明るく保持）
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

wezterm.on('bell', function(window, pane)
  window:toast_notification('Claude Code', 'Task completed', nil, 4000)
end)

return config
