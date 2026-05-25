#!/usr/bin/env bash
set -euo pipefail

PROFILE=${1:-all-in-one}

echo "[90] final (${PROFILE})"

# Student/dev baseline apps (light-ish)
sudo pacman -S --noconfirm --needed \
  firefox \
  zathura zathura-pdf-mupdf \
  libreoffice-fresh \
  unzip \
  ripgrep \
  fd \
  bash-completion

# Bluetooth / webcam support (optional but you said you have them)
# We'll install basics but not enable services automatically.
sudo pacman -S --noconfirm --needed \
  bluez bluez-utils \
  v4l-utils

echo "Next steps (manual):"
echo "- Set git identity: git config --global user.name '...' && git config --global user.email '...'"
echo "- Generate SSH key: ssh-keygen -t ed25519"
echo "- Start X: startx"
echo "- Bluetooth: sudo systemctl enable --now bluetooth (only if you need it)"

echo "OK"
