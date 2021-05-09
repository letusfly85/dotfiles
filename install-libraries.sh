#/usr/bin/env bash

brew install starship


# https://github.com/koekeishiya/dotfiles/blob/master/yabai/yabairc
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

brew services start skhd
brew services start yabai
