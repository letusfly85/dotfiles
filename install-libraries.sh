#/usr/bin/env bash

# Scala CLI
brew install Virtuslab/scala-cli/scala-cli

# AWS EKS
brew install weaveworks/tap/eksctl

# Helm
brew install helm

# kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash

# Stripe
brew install stripe/stripe-cli/stripe

# PostgreSQL Client
brew install libpq

# tflint
brew install tflint

# Shell
brew install shellcheck shfmt

# hurl
brew install hurl

# Mecab
brew install mecab
brew install mecab-ipadic

# Database CLI
brew install mycli
brew install pgcli

# ---- Cross-platform (macOS / Ubuntu) tools ----
# macOS は brew、Ubuntu/Debian は apt を利用する
install_xplat() {
    local name="$1"
    local brew_pkg="$2"
    local apt_pkg="$3"

    case "$(uname -s)" in
        Darwin)
            brew install "$brew_pkg"
            ;;
        Linux)
            if [ -f /etc/os-release ] && grep -qiE 'ubuntu|debian' /etc/os-release; then
                sudo apt-get update
                sudo apt-get install -y "$apt_pkg"
            else
                echo "Unsupported Linux distribution for $name" >&2
            fi
            ;;
        *)
            echo "Unsupported OS for $name install: $(uname -s)" >&2
            ;;
    esac
}

# zoxide (smarter cd)
# https://github.com/ajeetdsouza/zoxide
install_xplat zoxide zoxide zoxide

# fzf (fuzzy finder)
# https://github.com/junegunn/fzf
install_xplat fzf fzf fzf

# eza (modern ls)
# https://github.com/eza-community/eza
install_xplat eza eza eza

# ripgrep (fast grep)
# https://github.com/BurntSushi/ripgrep
install_xplat ripgrep ripgrep ripgrep

# lazygit (terminal UI for git)
# https://github.com/jesseduffield/lazygit
case "$(uname -s)" in
    Darwin)
        brew install lazygit
        ;;
    Linux)
        if [ -f /etc/os-release ] && grep -qiE 'ubuntu|debian' /etc/os-release; then
            # Ubuntu の apt には lazygit が無いため公式 tarball を使用
            LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
            curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
            tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
            sudo install /tmp/lazygit /usr/local/bin
            rm -f /tmp/lazygit /tmp/lazygit.tar.gz
        fi
        ;;
esac

# yazi (blazing fast terminal file manager)
# https://github.com/sxyazi/yazi
case "$(uname -s)" in
    Darwin)
        brew install yazi
        ;;
    Linux)
        if [ -f /etc/os-release ] && grep -qiE 'ubuntu|debian' /etc/os-release; then
            # Ubuntu の apt には yazi が無いため cargo でインストール
            if command -v cargo &> /dev/null; then
                cargo install --locked yazi-fm yazi-cli
            else
                echo "cargo が必要です。./install-crate.sh を先に実行するか rustup を導入してください" >&2
            fi
        fi
        ;;
esac
