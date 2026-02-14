# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

このリポジトリは、個人用の dotfiles 設定集です。Zsh、Vim、Wezterm、その他開発ツールの設定ファイルを管理しています。

## 主要な設定ファイル

- `.zshrc`: Zsh の設定（zplug、キーバインド、各種言語環境）
- `wezterm.lua`: Wezterm ターミナルエミュレータの設定（宇宙火星風テーマ）
- `vimrc`: Vim エディタの設定
- `base_aliases`: シェルエイリアスの定義

## セットアップコマンド

### 基本的なシンボリックリンクの作成

```bash
# Zsh
sudo ln -s $PWD/.zshrc $HOME/.zshrc

# tmux
sudo ln -s $PWD/.tmux.conf $HOME/.tmux.conf

# powerline
sudo ln -s $PWD/.powerline-shell.json $HOME/.powerline-shell.json
```

### Rust クレートのインストール

```bash
./install-crate.sh
```

以下のツールがインストールされます：
- exa（ls の代替）
- bat（cat の代替）
- jaq（jq の代替）
- atuin（履歴管理）
- just（タスクランナー）
- cargo-generate
- hurl（HTTPクライアント）

### 外部ライブラリのインストール

```bash
./install-libraries.sh
```

以下がインストールされます：
- Scala CLI
- AWS EKS CLI (eksctl)
- Helm
- kustomize
- Stripe CLI
- PostgreSQL クライアント
- tflint
- Shell 開発ツール（shellcheck、shfmt）
- MeCab（形態素解析）
- Entire CLI（AIコーディングセッション管理）

### bun のインストール

```bash
./install-bun.sh
```

bun（JavaScript/TypeScript ランタイム）がインストールされます。

## アーキテクチャ

### 環境管理
- 複数言語環境の管理（pyenv、nodenv、jenv、asdf、SDKMAN）
- Rust ツールチェーンのサポート
- Homebrew ベースのツール管理

### シェル設定
- zplug によるプラグイン管理
- atuin による高度な履歴管理

### ターミナル設定
- Wezterm で宇宙火星風ファンタジーサイバーパンクテーマを実装
- Cica フォントの使用
- 背景画像とグラデーションの組み合わせ

## 重要なパス設定

- `/usr/local/opt/libpq/bin`: PostgreSQL クライアント
- `/opt/homebrew/opt/mysql-client/bin`: MySQL クライアント
- `/opt/homebrew/opt/openjdk@17/bin`: OpenJDK 17
- `$HOME/.cargo/bin`: Rust ツール
- `$HOME/.local/bin`: Poetry など Python ツール
- `$HOME/.bun/bin`: bun ランタイム

## 対応言語とツール

- **Rust**: cargo、各種 Rust クレート
- **Python**: pyenv、poetry
- **Node.js**: nodenv
- **JavaScript/TypeScript**: bun
- **Java**: jenv、SDKMAN
- **Scala**: Scala CLI
- **Shell**: shellcheck、shfmt
- **Infrastructure**: AWS CLI、kubectl、helm、terraform
- **AI Tools**: Entire CLI（セッション管理）