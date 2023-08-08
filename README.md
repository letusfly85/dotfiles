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


## Fonts

- [Cica](https://github.com/miiton/Cica)

## Crates

- [cargo-make](https://github.com/sagiegurari/cargo-make)
- [just](https://github.com/casey/just)
- [atuin](https://github.com/ellie/atuin)
- [tokei](https://github.com/XAMPPRocky/tokei)
- [tui-rs](https://github.com/fdehau/tui-rs)


## Config

```bash
powerline-shell --generate-config > ~/.powerline-shell.json
```
