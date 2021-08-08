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

# Helm
brew install helm

# kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# SASS
brew install sass/sass/sass

# Stripe
brew install stripe/stripe-cli/stripe

# Nushell
brew install nushell

# RustScan
brew install rustscan
