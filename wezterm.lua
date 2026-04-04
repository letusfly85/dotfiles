local wezterm = require 'wezterm'


-- 宇宙火星風ファンタジーサイバーパンクテーマ
local scheme = wezterm.get_builtin_color_schemes()['Gruvbox Light']

local act = wezterm.action

-- macOS/Linux 両対応: zsh をデフォルトシェルに
local zsh_path = '/bin/zsh'
if wezterm.target_triple:find('apple') then
  zsh_path = '/bin/zsh'
end

-- デフォルトの作業ディレクトリを設定
local default_cwd = wezterm.home_dir
local work_dir = wezterm.home_dir .. '/work'

config = {
  default_prog = { zsh_path, '-l' },
  default_cwd = work_dir,
  background = {
    {
	source = { File = os.getenv("HOME") .. "/work/letusfly85/dotfiles/mars.png" },
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
    },
    scrollbar_thumb = "rgba(0, 255, 255, 0.35)", -- サイバーシアンの半透明スクロールバー
  },

  -- スクロールバーの幅（右パディングで制御）
  window_padding = {
    left = 0,
    right = '1.5cell',
    top = 0,
    bottom = 0,
  },
  -- フォント設定: macOS は Cica Bold + 大きめ、Linux は Cica Regular + 小さめ
  font = wezterm.target_triple:find('apple')
    and wezterm.font('Cica', { weight = 'Bold' })
    or wezterm.font('Cica', { weight = 'Regular' }),
  font_size = wezterm.target_triple:find('apple') and 20.0 or 16.0,

  -- スクロール性能の改善
  max_fps = 120,
  scrollback_lines = 10000,
  enable_scroll_bar = true,

  -- マウスホイールスクロールを固定行数にしてガクガクを防止
  mouse_bindings = {
    -- マウスホイールスクロール
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = 'NONE',
      action = act.ScrollByLine(-3),
      alt_screen = false,
    },
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = 'NONE',
      action = act.ScrollByLine(3),
      alt_screen = false,
    },
    -- 選択範囲をクリップボードにコピー（左ボタンを離した時）
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelectionOrOpenLinkAtMouseCursor('ClipboardAndPrimarySelection'),
    },
    -- 右クリックでクリップボードからペースト
    {
      event = { Down = { streak = 1, button = 'Right' } },
      mods = 'NONE',
      action = act.PasteFrom('Clipboard'),
    },
  },
}

-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

-- === SSH接続検出: タブの色を赤背景・白文字に変更 ===
-- pane ごとに SSH 接続中かどうかを記録
local ssh_panes = {}

wezterm.on('update-status', function(window, pane)
  local proc = pane:get_foreground_process_name() or ''
  local pane_id = tostring(pane:pane_id())
  local is_ssh = (proc:find('ssh$') ~= nil)
  ssh_panes[pane_id] = is_ssh or nil
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#2D1B0E" -- 暗い火星の土壌
  local foreground = "#C0A080"
  local edge_background = "none"

  -- SSH接続中のタブは赤背景・白文字
  local pane_id = tostring(tab.active_pane.pane_id)
  local is_ssh = ssh_panes[pane_id]

  if is_ssh then
    background = "#8B1A1A" -- 深宇宙の暗い赤（火星の岩肌）
    foreground = "#FFD0C0" -- 星明かりのような淡いピンクホワイト
  elseif tab.is_active then
    background = "#4A2C1A" -- 暗い火星表面
    foreground = "#00FFFF" -- サイバーシアン（明るく保持）
  end

  local edge_foreground = background
  local raw_title = tab.active_pane.title or ''
  -- タイトルが空白のみ or 空の場合、SSH中なら "SSH" をフォールバック表示
  if raw_title:match('^%s*$') and is_ssh then
    raw_title = 'SSH'
  end
  local title = "   " .. wezterm.truncate_right(raw_title, max_width - 1) .. "   "
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
