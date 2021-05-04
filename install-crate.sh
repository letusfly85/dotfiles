#/usr/bin/env bash

cargo install \
    exa \
    bat \
    pueue \
    gitui \
    git-delta \
    just \
    cargo-make

cargo install diesel_cli --no-default-features --features mysql
