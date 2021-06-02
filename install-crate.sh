#/usr/bin/env bash

cargo install \
    exa \
    bat \
    pueue \
    gitui \
    atuin \
    git-delta \
    just \
    cargo-make

cargo install diesel_cli --no-default-features --features mysql

cargo install --git https://github.com/XAMPPRocky/tokei.git tokei
