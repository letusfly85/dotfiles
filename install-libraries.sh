#/usr/bin/env bash

# Terminal
brew install starship


# Tail Managers
# https://github.com/koekeishiya/dotfiles/blob/master/yabai/yabairc
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew services start skhd
brew services start yabai

# Terminal
brew cask install alacritty

# AWS EKS
brew install weaveworks/tap/eksctl
