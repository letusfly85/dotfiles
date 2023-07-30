# Initial setup operations

## Font

### Ricty

```bash
brew install --with-powerline ricty

cp -f /opt/homebrew/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf
```

### Cica

- https://github.com/miiton/Cica/releases

## Python

```bash
brew update
brew install pyenv
```

```bash
brew install xz
pyenv install 3.10.11

pyenv global 3.10.11
eval "$(pyenv init -)"
```

## PowerLine Shell

```bash
pip3 install powerline-shell

brew tap sanemat/font
brew install --with-powerline ricty
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf
```

## Slack

```bash
brew install --cask slack
```

## jq

```bash
brew install jq
```

## GitHub command

```bash
brew install gh
```

## jenv

```bash
brew install jenv
```

## zsh

```bash
brew install fzf
```

```bash
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

sudo ln -s $PWD/.zshrc $HOME/.zshrc

mkdir $HOME/.zsh
git clone --depth=1 https://github.com/woefe/git-prompt.zsh ~/.zsh/git-prompt.zsh
echo "source ~/.zsh/git-prompt.zsh/git-prompt.zsh" >> .zshrc

source ~/.zshrc
```

## Rust

```bash
curl https://sh.rustup.rs -sSf | sh

bash install-crate.sh
```

## Terraform

```bash
brew install tfenv
brew install tflint
```

## Docker

```bash
brew install --cask docker

sudo mkdir -p /usr/local/lib/docker/cli-plugins

sudo curl -SL https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-darwin-aarch64 -o /usr/local/lib/docker/cli-plugins/docker-compose

sudo chmod a+x /usr/local/lib/docker/cli-plugins/docker-compose

docker compose -v
```

## Node

```bash
brew install nodenv
brew upgrade nodenv node-build
```

## direnv

```bash
brew install direnv
```

## Scala

### SDK

- https://sdkman.io/

```bash
curl -s "https://get.sdkman.io" | bash
```

```bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java $(sdk list java | grep -o "\b8\.[0-9]*\.[0-9]*\-tem" | head -1)
sdk install sbt

sdk install java 11.0.20-zulu
```

## Databases

```bash
brew install mysql-client
pip install mycli
```
