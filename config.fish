# Rust
if [ -d $HOME/.cargo ];
  source $HOME/.cargo/env
else
   echo "You don't install Rust/Cargo still yet"
end

# Python
if [ -d $HOME/.pyenv ];
  export PATH="$HOME/.pyenv/shims:$PATH"
else
   echo "You don't install pyenv still yet"
end

# Node
if [ -d $HOME/.nodenv ];
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval (nodenv init - | source)
else
   echo "You don't install nodenv still yet"
end

# Aliases
if [ -f $HOME/.aliases ];
   source $HOME/.aliases
else
   echo "You don't have $HOME/.aliases"
end

# direnv
eval (direnv hook fish)
export EDITOR=vim

set fish_color_command brpurple

eval (gh completion -s fish| source)
