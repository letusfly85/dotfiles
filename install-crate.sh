#/usr/bin/env bash

cargo install \
    exa \
    bat \
    jaq \
    pueue \
    gitui \
    atuin \
    git-delta \
    just \
    cargo-make \
    cargo-hf2 \
    hf2-cli \
    cargo-generate

cargo install diesel_cli --no-default-features --features mysql

cargo install --git https://github.com/XAMPPRocky/tokei.git tokei
