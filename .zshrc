# 基本設定
export LANG=ja_JP.UTF-8
export EDITOR=vim
export SAVEHIST=100000

# プロンプト設定（グラデーション付きディレクトリ + git ブランチ/ステータス）
zmodload zsh/mathfunc
zmodload zsh/datetime
autoload -Uz vcs_info add-zsh-hook

# 時間帯ベースの色相範囲（JST）
# 朝(5-9): 暖かい朝焼け, 昼(9-13): 明るい黄緑,
# 午後(13-17): 爽やかシアン, 夕方(17-20): 夕焼けマゼンタ, 夜(20-5): 深い青紫
_prompt_time_hue() {
  local hour_str
  TZ=Asia/Tokyo strftime -s hour_str '%H' $EPOCHSECONDS
  local -i hour=$(( 10#$hour_str ))
  local -i hue_min hue_max
  if (( hour >= 5 && hour < 9 )); then
    hue_min=15; hue_max=55       # 朝焼けのオレンジ〜ピンク
  elif (( hour >= 9 && hour < 13 )); then
    hue_min=55; hue_max=140      # 陽光の黄色〜緑
  elif (( hour >= 13 && hour < 17 )); then
    hue_min=140; hue_max=210     # 午後の緑〜シアン
  elif (( hour >= 17 && hour < 20 )); then
    hue_min=300; hue_max=360     # 夕焼けの赤〜マゼンタ
  else
    hue_min=220; hue_max=300     # 夜空の青〜紫
  fi
  _PROMPT_HUE=$(( hue_min + RANDOM % (hue_max - hue_min + 1) ))
}

# 初回の色相設定
_prompt_time_hue

# HSL の色相を truecolor エスケープ用 R;G;B に変換（S=70%, L=65% 固定）
_hue2rgb() {
  local -F h=$1 s=0.70 l=0.65
  local -F c=$(( (1.0 - fabs(2.0 * l - 1.0)) * s ))
  local -F hp=$(( h / 60.0 ))
  local -F x=$(( c * (1.0 - fabs(fmod(hp, 2.0) - 1.0)) ))
  local -F m=$(( l - c / 2.0 ))
  local -F r=0 g=0 b=0
  if   (( hp < 1 )); then r=$c; g=$x
  elif (( hp < 2 )); then r=$x; g=$c
  elif (( hp < 3 )); then g=$c; b=$x
  elif (( hp < 4 )); then g=$x; b=$c
  elif (( hp < 5 )); then r=$x; b=$c
  else                     r=$c; b=$x
  fi
  REPLY="$(( int((r+m)*255) ));$(( int((g+m)*255) ));$(( int((b+m)*255) ))"
}

# ディレクトリ文字列をグラデーションで着色
_gradient_dir() {
  local dir="${(%):-%~}"
  local -i len=${#dir}
  local -F step=$(( len > 1 ? 50.0 / len : 0 ))
  local esc=$'\e'
  _PROMPT_DIR=""
  for (( i = 1; i <= len; i++ )); do
    _hue2rgb $(( fmod(_PROMPT_HUE + (i-1) * step, 360.0) ))
    _PROMPT_DIR+="%{${esc}[38;2;${REPLY}m%}${dir[$i]}"
  done
  _PROMPT_DIR+="%f"
}

# vcs_info: git ブランチ名 + ステータス表示
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}+'
zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}!'
zstyle ':vcs_info:git:*' formats ' %F{cyan}(%b%c%u%m%F{cyan})%f'
zstyle ':vcs_info:git:*' actionformats ' %F{cyan}(%b%F{cyan}|%F{red}%a%c%u%m%F{cyan})%f'

# vcs_info hooks: ブランチ色分け + untracked 検出
zstyle ':vcs_info:git*+set-message:*' hooks git-branch-color git-untracked git-remote-status

# conventional branch prefix でブランチ名の色を変える
+vi-git-branch-color() {
  local branch="${hook_com[branch]}"
  local color
  case "$branch" in
    feat/*|feature/*)   color="%F{green}" ;;
    fix/*|bug/*)        color="%F{red}" ;;
    hotfix/*)           color="%F{magenta}" ;;
    docs/*)             color="%F{cyan}" ;;
    chore/*)            color="%F{yellow}" ;;
    refactor/*)         color="%F{blue}" ;;
    test/*)             color="%F{white}" ;;
    main|master|develop) color="%F{green}" ;;
    *)                  color="%F{blue}" ;;
  esac
  hook_com[branch]="${color}${branch}"
}

# untracked ファイルの検出（? 表示）
+vi-git-untracked() {
  if [[ $(command git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]] \
     && command git status --porcelain 2>/dev/null | command grep -q '^??'; then
    hook_com[misc]+='%F{red}?'
  fi
}

# リモートブランチとの差分（↑push待ち ↓pull待ち）
+vi-git-remote-status() {
  local -i ahead behind
  ahead=$(command git rev-list --count @{upstream}..HEAD 2>/dev/null) || return
  behind=$(command git rev-list --count HEAD..@{upstream} 2>/dev/null) || return
  local arrows=""
  (( ahead > 0 )) && arrows+="%F{green}↑${ahead}"
  (( behind > 0 )) && arrows+="%F{red}↓${behind}"
  [[ -n "$arrows" ]] && hook_com[misc]+="${arrows}"
}

_prompt_precmd() {
  _prompt_time_hue
  vcs_info
  _gradient_dir
}
add-zsh-hook precmd _prompt_precmd

setopt PROMPT_SUBST
PROMPT='${_PROMPT_DIR}${vcs_info_msg_0_} $ '

# To Enable Ctrl+a, Ctrl+e
bindkey -e

# zplugの設定
source ~/.zplug/init.zsh

# 必要なプラグイン
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"
zplug "tcnksm/docker-alias", use:zshrc
zplug "k4rthik/git-cal", as:command, frozen:1
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "jhawthorn/fzy", as:command, rename-to:fzy, hook-build:"make && sudo make install"
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# git-prompt.zsh は不要（vcs_info でブランチ名を表示）
# zplug "~/.zsh", from:local

# プラグインのインストール
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
  fi
fi

zplug load

# キーバインド設定
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down
bindkey '^p' history-beginning-search-backward-end
bindkey '^n' history-beginning-search-forward-end
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# 履歴検索の設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Rust
if [ -d $HOME/.cargo ]; then
  source $HOME/.cargo/env
fi

# Aliases
if [ -f $HOME/.aliases ]; then
  . $HOME/.aliases
fi

# Python (pyenv)
if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/shims:$PATH"
fi

export PATH=${0:A:h}/bin:$PATH

# direnv
eval "$(direnv hook zsh)"

# SSH補完
function _ssh {
  compadd $(fgrep 'Host ' ~/.ssh/*.config | awk '{print $2}' | sort)
}

# poetry
export PATH="$HOME/.local/bin:$PATH"


# Node.js (nodenv)
if [ -d $HOME/.nodenv ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

# atuin (シェル履歴管理)
if [ -f $HOME/.cargo/bin/atuin ]; then
  eval "$(atuin init zsh)"
fi

# パス設定
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

export DYLD_LIBRARY_PATH="$HOME/.local/lib:$DYLD_LIBRARY_PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Google Cloud SDK
source "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc"

# claude-mem (memory service for Claude Code)
alias claude-mem="$BUN_INSTALL/bin/bun $HOME/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"
