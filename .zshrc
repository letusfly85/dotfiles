# 基本設定
export LANG=ja_JP.UTF-8
export EDITOR=vim
export SAVEHIST=100000

# プロンプト設定（カレントディレクトリ + gitブランチ名のみ）
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%~${vcs_info_msg_0_} $ '

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
