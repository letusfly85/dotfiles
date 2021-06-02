# dotfiles

* vimrc
* tmux.conf
* zshrc

## Setup

```bash
# Zsh
sudo ln -s $PWD/.zshrc $HOME/.zshrc

# tmux
sudo ln -s $PWD/.tmux.conf $HOME/.tmux.conf

# powerline
sudo ln -s $PWD/.powerline-shell.json $HOME/.powerline-shell.json

# yabai
sudo ln -s $PWD/.yabairc $HOME/.yabairc
sudo ln -s $PWD/.skhdrc $HOME/.skhdrc
```

## Fonts

- [Cica](https://github.com/miiton/Cica)

## Tools

- [starship](https://github.com/starship/starship)
- [alacritty](https://github.com/alacritty/alacritty)

## Crates

- [gitui](https://github.com/extrawurst/gitui)
- [delta](https://github.com/dandavison/delta)
- [cargo-make](https://github.com/sagiegurari/cargo-make)
- [just](https://github.com/casey/just)
- [atuin](https://github.com/ellie/atuin)
- [tokei](https://github.com/XAMPPRocky/tokei)

## NPM

- [tldr](https://github.com/tldr-pages/tldr)
- [terminalizer](https://github.com/faressoft/terminalizer)


## Config

```bash
powerline-shell --generate-config > ~/.powerline-shell.json
```
