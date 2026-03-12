# Linux 利用時のポイント

## 日本語入力の設定（IBus + Mozc）

### 前提

- Ubuntu (IBus + Mozc)
- Windows App (Microsoft Remote Desktop) 経由でリモートアクセス

### 入力ソースの設定

Settings → Region & Language → Input Sources に以下を追加する：

- Japanese (xkb:jp)
- Japanese (Mozc) (ibus:mozc-jp)
- English (US) (xkb:us)

### 入力切替のショートカットキー

RDP 経由だと `Ctrl+Space` や `Super+Space` はクライアント側に消費されてリモートに届かない。
競合しにくいキーを設定する必要がある。

**現在の設定: `Ctrl+;`**

```bash
# IBus のトリガーキー設定
dconf write /desktop/ibus/general/hotkey/triggers "['<Control>semicolon']"

# GNOME の入力ソース切替キー設定
dconf write /org/gnome/desktop/wm/keybindings/switch-input-source "['<Control>semicolon']"

# IBus の再起動
ibus-daemon -drx
```

### RDP で使えないキーの例

| キー | 理由 |
|------|------|
| `Ctrl+Space` | RDP クライアントが消費する |
| `Super+Space` | Windows キーがクライアント側で処理される |
| `Ctrl+\` | ターミナルで SIGQUIT として扱われる |

### Mozc の入力モード

切替後に日本語入力ができない場合、Mozc の入力モードが「直接入力」になっている可能性がある。

- システムトレイの IBus アイコンを右クリック → 入力モード → **ひらがな** を選択
- または Mozc 設定ツールで確認: `/usr/lib/mozc/mozc_tool --mode=config_dialog`
