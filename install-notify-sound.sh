#!/usr/bin/env bash

# Install the notification sound used by the wezterm bell handler (see wezterm.lua).
# The asset is copied from the local Slack.app instead of being committed, because
# it belongs to Slack Technologies and this repository is public.

set -e

DEST_DIR="$(cd "$(dirname "$0")" && pwd)/sounds"
DEST="${DEST_DIR}/notify.mp3"
SRC="/Applications/Slack.app/Contents/Resources/confirm_delivery.mp3"

echo "Installing notification sound..."

if [ -f "$DEST" ]; then
    echo "Notification sound is already installed: $DEST"
    exit 0
fi

if [ ! -f "$SRC" ]; then
    echo "Slack.app not found at $SRC" >&2
    echo "Put any mp3 at $DEST instead, or install Slack and re-run." >&2
    exit 1
fi

mkdir -p "$DEST_DIR"
cp "$SRC" "$DEST"

echo "Notification sound installation completed: $DEST"
