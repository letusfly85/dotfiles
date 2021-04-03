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
```

## Fonts

- [Cica](https://github.com/miiton/Cica)

## Crates

- [gitui](https://github.com/extrawurst/gitui)


## Config

```bash
powerline-shell --generate-config > ~/.powerline-shell.json
```
