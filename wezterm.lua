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

-- === SSH接続検出: 他の宇宙船に乗り込んだ演出（フェードトランジション付き） ===

local mars_img = os.getenv('HOME') .. '/work/letusfly85/dotfiles/mars.png'

-- hex色をR,G,Bに分解
local function hex2rgb(hex)
  hex = hex:gsub('#', '')
  return tonumber(hex:sub(1, 2), 16),
         tonumber(hex:sub(3, 4), 16),
         tonumber(hex:sub(5, 6), 16)
end

-- R,G,Bをhex色に変換
local function rgb2hex(r, g, b)
  return string.format('#%02x%02x%02x',
    math.max(0, math.min(255, math.floor(r + 0.5))),
    math.max(0, math.min(255, math.floor(g + 0.5))),
    math.max(0, math.min(255, math.floor(b + 0.5))))
end

-- 2つのhex色を t (0.0〜1.0) で線形補間
local function lerp_color(c1, c2, t)
  local r1, g1, b1 = hex2rgb(c1)
  local r2, g2, b2 = hex2rgb(c2)
  return rgb2hex(
    r1 + (r2 - r1) * t,
    g1 + (g2 - g1) * t,
    b1 + (b2 - b1) * t)
end

-- 数値を線形補間
local function lerp(a, b, t) return a + (b - a) * t end

-- 火星テーマ（通常）とエイリアン宇宙船テーマ（SSH）の定義
local theme_mars = {
  gradient = { '#000000', '#0A0A0A', '#1A0F0A', '#2D1B0E', '#4A2C1A' },
  overlay  = { '#000814', '#000a14' },
  img_opacity  = 0.55,
  img_hue      = 1.0,
  img_sat      = 1.0,
  img_bright   = 1.0,
  ovr_opacity  = 0.45,
  scrollbar    = { 0, 255, 255, 0.35 },
}
local theme_alien = {
  gradient = { '#000010', '#0A0A2E', '#0F1A3A', '#162050', '#1A1A4A' },
  overlay  = { '#000020', '#0A0A3E' },
  img_opacity  = 0.25,
  img_hue      = 0.6,
  img_sat      = 1.5,
  img_bright   = 0.4,
  ovr_opacity  = 0.55,
  scrollbar    = { 100, 100, 255, 0.35 },
}

-- トランジション状態管理（ウィンドウ単位で管理し、複数ウィンドウの干渉を防ぐ）
local transition_states = {}  -- window_id -> { current, generation }
local TRANSITION_STEPS = 8
local TRANSITION_INTERVAL = 0.05  -- 各ステップ間隔（秒） → 合計 ~400ms

local function get_win_state(window)
  local wid = tostring(window:window_id())
  if not transition_states[wid] then
    transition_states[wid] = { current = 'mars', generation = 0 }
  end
  return transition_states[wid], wid
end

-- t (0.0=mars, 1.0=alien) に基づいて中間テーマを適用
-- 既存の per-window override を保持しつつ、テーマ関連キーのみ更新する
local function apply_interpolated_theme(window, t)
  local overrides = window:get_config_overrides() or {}

  if t <= 0.001 then
    -- 完全に火星テーマ → テーマ関連キーを削除して元のconfigに戻す
    overrides.window_background_gradient = nil
    overrides.background = nil
    overrides.colors = nil
    window:set_config_overrides(overrides)
    return
  end

  local from = theme_mars
  local to = theme_alien

  -- グラデーション色の補間
  local grad = {}
  for i = 1, 5 do
    grad[i] = lerp_color(from.gradient[i], to.gradient[i], t)
  end

  -- オーバーレイ色の補間
  local ovr = {}
  for i = 1, 2 do
    ovr[i] = lerp_color(from.overlay[i], to.overlay[i], t)
  end

  -- スクロールバー色の補間
  local sb = string.format('rgba(%d, %d, %d, %.2f)',
    math.floor(lerp(from.scrollbar[1], to.scrollbar[1], t)),
    math.floor(lerp(from.scrollbar[2], to.scrollbar[2], t)),
    math.floor(lerp(from.scrollbar[3], to.scrollbar[3], t)),
    lerp(from.scrollbar[4], to.scrollbar[4], t))

  overrides.window_background_gradient = {
    colors = grad,
    orientation = 'Vertical',
    blend = 'LinearRgb',
  }
  overrides.background = {
    {
      source = { File = mars_img },
      attachment = 'Fixed',
      opacity = lerp(from.img_opacity, to.img_opacity, t),
      vertical_align = 'Middle',
      horizontal_align = 'Center',
      horizontal_offset = '0px',
      repeat_x = 'NoRepeat',
      repeat_y = 'NoRepeat',
      height = '100%',
      hsb = {
        hue = lerp(from.img_hue, to.img_hue, t),
        saturation = lerp(from.img_sat, to.img_sat, t),
        brightness = lerp(from.img_bright, to.img_bright, t),
      },
    },
    {
      source = {
        Gradient = {
          colors = ovr,
          orientation = { Linear = { angle = -50.0 } },
        },
      },
      opacity = lerp(from.ovr_opacity, to.ovr_opacity, t),
      width = '100%',
      height = '100%',
    },
  }
  overrides.colors = {
    tab_bar = { inactive_tab_edge = 'none' },
    scrollbar_thumb = sb,
  }
  window:set_config_overrides(overrides)
end

-- フェードトランジションを開始（世代番号で旧コールバックを無効化）
local function start_transition(window, target)
  local state = get_win_state(window)
  if state.current == target then return end
  state.current = target
  state.generation = state.generation + 1
  local my_gen = state.generation

  local step = 1
  local function step_fn()
    -- 世代が変わっていたら旧トランジション → 何もしない
    if state.generation ~= my_gen then return end
    if step > TRANSITION_STEPS then return end

    -- イーズイン・アウト (smoothstep) で滑らかに
    local raw_t = step / TRANSITION_STEPS
    local t = raw_t * raw_t * (3 - 2 * raw_t)

    -- mars→alien なら t をそのまま、alien→mars なら反転
    if target == 'mars' then t = 1.0 - t end

    apply_interpolated_theme(window, t)

    step = step + 1
    if step <= TRANSITION_STEPS then
      wezterm.time.call_after(TRANSITION_INTERVAL, step_fn)
    end
  end

  step_fn()
end

-- ローカルpane上の前景プロセスが ssh の場合にテーマを切り替える
-- 注: multiplexer pane や wezterm ssh ドメインでは検出不可
wezterm.on('update-status', function(window, pane)
  local proc = pane:get_foreground_process_name() or ''
  if proc:find('ssh$') then
    start_transition(window, 'alien')
  else
    start_transition(window, 'mars')
  end
end)

wezterm.on('bell', function(window, pane)
  window:toast_notification('Claude Code', 'Task completed', nil, 4000)
end)

return config
