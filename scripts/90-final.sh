#!/usr/bin/env bash
set -euo pipefail

PROFILE=${1:-all-in-one}

echo "[90] final (${PROFILE})"

# Student/dev baseline apps (light-ish)
# Note: OnlyOffice may be installed via AUR depending on your Arch setup.
# We keep LibreOffice out by default for low-end machines and allow OnlyOffice as optional.
sudo pacman -S --noconfirm --needed \
  firefox \
  zathura zathura-pdf-mupdf \
  unzip \
  ripgrep \
  fd \
  bash-completion

# Optional office suite
# - If ONLYOFFICE package is available, install it.
# - Otherwise, print instructions (AUR) and continue.
if pacman -Si onlyoffice >/dev/null 2>&1; then
  sudo pacman -S --noconfirm --needed onlyoffice
else
  echo "NOTE: 'onlyoffice' is not available in your current pacman repos." >&2
  echo "      If you want it, you will likely need an AUR helper (e.g., yay) and install 'onlyoffice-bin'." >&2
  echo "      Example: yay -S onlyoffice-bin" >&2
fi

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
